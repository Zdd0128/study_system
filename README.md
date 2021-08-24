# 在线学习系统

### 项目介绍

```
	本项目是一个关于学习考核系统的项目,主要有在线考试,视频学习等模块,适用于热爱编程热爱学习的有志向青年
```

### 项目架构
```
# 项目架构:
	Django-Drf + Vue
	
# 前端:
	前端主要使用Vue框架,以及其他Element Ui,Vue-Cookies,Axios,Vue-Video-Player,vue-Quill-Editor,Dayjs等第三方插件
	
# 后端:
	后端主要使用Django-Drf,以及其他PyJWT,Celery,Pillow,Redis,Uwsgi,Django-Simpleui,Django-Ckeditor等第三方依赖
```

### 项目技术点

```
1.Minio分布式文件系统实现图片视频托管
2.支付宝支付
3.Celery异步任务发送邮箱,短信,自动批改试卷
4.Docker-compose一键部署
5.Nginx负载均衡
6.MySQL主从同步
```

### 使用说明

#### 本地启动项目

```
# 1.clone本项目到本地:
	git clone https://gitee.com/zqw99/study_system_v1.git
	
# 2.打开前端项目project_vue,终端输入:
	npm install
	
# 3.打开后端项目project_api,修改mysql,redis,邮箱,短信,支付宝支付等配置,缺少依赖安装即可
```

#### Docker-compose启动配置

```
# study_docker_compose文件夹是docker启动相关

# docker-compose.yml配置:
    version: "3.0"

    services:
      nginx:
        image: nginx
        container_name: study_nginx
        ports:
          - "85:85"				# 前端监听端口
          - "8001:8001"			# 后端监听端口
        restart: always
        volumes:
          - ./study_vue/dist:/var/study/html/dist
          - ./project_api/project_api/static:/var/study_s/static
          - ./docker_compose_files/nginx:/etc/nginx/conf.d
        depends_on:
          - django
        networks:
          - web

      django:
        build:
          context: ./project_api
          dockerfile: Dockerfile
        container_name: study_django
        restart: always
        ports:
          - "8188:8188"			# 项目后端端口
        volumes:
          - ./project_api:/soft
        environment:
          - TZ=Asia/Shanghai
        depends_on:
          - mysql
          - redis
        networks:
          - web

      redis:
        image: redis:latest
        container_name: study_redis
        ports:
          - "6379:6379"
        volumes:
          - ./docker_compose_files/redis/data:/data
          - ./docker_compose_files/redis/redis.conf:/etc/redis/redis.conf
        command: redis-server /etc/redis/redis.conf
        networks:
          - web

      mysql:
        image: mysql:5.7
        container_name: study_mysql
        restart: always
        ports:
          - "3306:3306"
        env_file:
          - ./docker_compose_files/mysql.env
        volumes:
          - ./docker_compose_files/mysql/data:/var/lib/mysql
          - ./docker_compose_files/mysql/logs:/var/log/mysql
          - ./docker_compose_files/mysql/conf:/etc/mysql/conf.d
        networks:
          - web

    networks:
      web:


# docker_compose_files/nginx/default.conf配置:

	upstream study {
         server 101.91.213.1:85 weight=1 fail_timeout=15 max_conns=200;
         server 110.40.189.224 weight=3 fail_timeout=15 max_conns=200;
         server 106.14.126.115 weight=3 fail_timeout=15 max_conns=200;
        }
	server {
            listen 85;		# 前端监听端口
            server_name  127.0.0.1;
            charset utf-8;
            location / {
                root /var/study/html/dist; # 前端静态文件映射到容器内的地址
                index index.html; 
                try_files $uri $uri/ /index.html; # 解决单页面应用刷新404问题
                proxy_pass http://study;  # nginx负载均衡配合上方upstream使用
            }
        }
       server {
            listen 8001;	# 后端监听端口
            server_name  127.0.0.1; 
            charset utf-8;
            location / {
    		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    		proxy_set_header Host $http_host;
    		proxy_redirect off;
    		proxy_pass http://study_django:8188;# 后端监听端口,需和uwsgi配置一致
		}
		location /static {
        	alias /var/study_s/static;	# 后端静态文件映射容器内的路径
    	}
      }
      
      
# uwsgi配置,项目根目录下新建study.ini文件并写入以下内容
    [uwsgi]
    chdir = /soft
    master = true
    wsgi-file = /soft/project_api/wsgi.py
    http = 0.0.0.0:8188		# 和nginx配置的后端监听端口对应
    chmod-socket = 755
    processes = 2
    pidfile = /soft/project_api/uwsgi.pid
    #设置缓冲
    post-buffering = 4096
    
    
# mysql.env配置:
    MYSQL_ROOT_PASSWORD=study123?		
    MYSQL_DATABASE=study_system			
    MYSQL_USER=zqw
    MYSQL_PASSWORD=study123?
    TZ=Asia/Shanghai
    
   
# 其他说明:
	1.前端静态文件存放在study_vue文件夹,启动project_vue修改base_url(项目后端地址)并build替换掉study_vue下dist文件
	2.docker-compose启动之前进入项目后端修改数据库,缓存等相关配置,seettings文件夹下pro.py文件修改mysql和redis配置,HOST写容器名(写其他的可能有问题),celery_task配置中也有redis配置,HOST改容器名,异步发送邮箱任务配置详情进入项目后端查看(异步发送短信配置参考md文件),支付调用第三方支付宝支付配置文件在libs文件夹下alipay,修改settings.py文件更换前后端回调地址
	3.docker-compose up启动后进入django容器启动celery服务(发邮件,短信,自动批卷等均采用celery异步任务),若启动报错,则在当前soft/文件夹下创建log文件夹即可
	celery服务启动命令:celery -A celery_task worker -l info
	4.其他相关问题无法解决可联系作者:
		企鹅:1912419375
	5.支付测试：
        	账号：bqpjmb5822@sandbox.com
        	密码及支付密码：111111
```
