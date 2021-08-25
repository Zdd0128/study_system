/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50647
 Source Host           : localhost:3306
 Source Schema         : test

 Target Server Type    : MySQL
 Target Server Version : 50647
 File Encoding         : 65001

 Date: 25/08/2021 08:21:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 'add_logentry', 1);
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 'change_logentry', 1);
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 'delete_logentry', 1);
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 'view_logentry', 1);
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 'add_permission', 2);
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 'change_permission', 2);
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 'delete_permission', 2);
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 'view_permission', 2);
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 'add_group', 3);
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 'change_group', 3);
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 'delete_group', 3);
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 'view_group', 3);
INSERT INTO `auth_permission` VALUES (13, 'Can add user', 'add_user', 4);
INSERT INTO `auth_permission` VALUES (14, 'Can change user', 'change_user', 4);
INSERT INTO `auth_permission` VALUES (15, 'Can delete user', 'delete_user', 4);
INSERT INTO `auth_permission` VALUES (16, 'Can view user', 'view_user', 4);
INSERT INTO `auth_permission` VALUES (17, 'Can add content type', 'add_contenttype', 5);
INSERT INTO `auth_permission` VALUES (18, 'Can change content type', 'change_contenttype', 5);
INSERT INTO `auth_permission` VALUES (19, 'Can delete content type', 'delete_contenttype', 5);
INSERT INTO `auth_permission` VALUES (20, 'Can view content type', 'view_contenttype', 5);
INSERT INTO `auth_permission` VALUES (21, 'Can add session', 'add_session', 6);
INSERT INTO `auth_permission` VALUES (22, 'Can change session', 'change_session', 6);
INSERT INTO `auth_permission` VALUES (23, 'Can delete session', 'delete_session', 6);
INSERT INTO `auth_permission` VALUES (24, 'Can view session', 'view_session', 6);
INSERT INTO `auth_permission` VALUES (25, 'Can add 轮播图表', 'add_banner', 7);
INSERT INTO `auth_permission` VALUES (26, 'Can change 轮播图表', 'change_banner', 7);
INSERT INTO `auth_permission` VALUES (27, 'Can delete 轮播图表', 'delete_banner', 7);
INSERT INTO `auth_permission` VALUES (28, 'Can view 轮播图表', 'view_banner', 7);
INSERT INTO `auth_permission` VALUES (29, 'Can add 单选题表', 'add_choice_question', 8);
INSERT INTO `auth_permission` VALUES (30, 'Can change 单选题表', 'change_choice_question', 8);
INSERT INTO `auth_permission` VALUES (31, 'Can delete 单选题表', 'delete_choice_question', 8);
INSERT INTO `auth_permission` VALUES (32, 'Can view 单选题表', 'view_choice_question', 8);
INSERT INTO `auth_permission` VALUES (33, 'Can add 学院表', 'add_college', 9);
INSERT INTO `auth_permission` VALUES (34, 'Can change 学院表', 'change_college', 9);
INSERT INTO `auth_permission` VALUES (35, 'Can delete 学院表', 'delete_college', 9);
INSERT INTO `auth_permission` VALUES (36, 'Can view 学院表', 'view_college', 9);
INSERT INTO `auth_permission` VALUES (37, 'Can add 课程表', 'add_course', 10);
INSERT INTO `auth_permission` VALUES (38, 'Can change 课程表', 'change_course', 10);
INSERT INTO `auth_permission` VALUES (39, 'Can delete 课程表', 'delete_course', 10);
INSERT INTO `auth_permission` VALUES (40, 'Can view 课程表', 'view_course', 10);
INSERT INTO `auth_permission` VALUES (41, 'Can add 专业表', 'add_major', 11);
INSERT INTO `auth_permission` VALUES (42, 'Can change 专业表', 'change_major', 11);
INSERT INTO `auth_permission` VALUES (43, 'Can delete 专业表', 'delete_major', 11);
INSERT INTO `auth_permission` VALUES (44, 'Can view 专业表', 'view_major', 11);
INSERT INTO `auth_permission` VALUES (45, 'Can add 试卷表', 'add_paper', 12);
INSERT INTO `auth_permission` VALUES (46, 'Can change 试卷表', 'change_paper', 12);
INSERT INTO `auth_permission` VALUES (47, 'Can delete 试卷表', 'delete_paper', 12);
INSERT INTO `auth_permission` VALUES (48, 'Can view 试卷表', 'view_paper', 12);
INSERT INTO `auth_permission` VALUES (49, 'Can add 试卷记录表', 'add_paper_record', 13);
INSERT INTO `auth_permission` VALUES (50, 'Can change 试卷记录表', 'change_paper_record', 13);
INSERT INTO `auth_permission` VALUES (51, 'Can delete 试卷记录表', 'delete_paper_record', 13);
INSERT INTO `auth_permission` VALUES (52, 'Can view 试卷记录表', 'view_paper_record', 13);
INSERT INTO `auth_permission` VALUES (53, 'Can add 简答题表', 'add_simple_question', 14);
INSERT INTO `auth_permission` VALUES (54, 'Can change 简答题表', 'change_simple_question', 14);
INSERT INTO `auth_permission` VALUES (55, 'Can delete 简答题表', 'delete_simple_question', 14);
INSERT INTO `auth_permission` VALUES (56, 'Can view 简答题表', 'view_simple_question', 14);
INSERT INTO `auth_permission` VALUES (57, 'Can add 任务表', 'add_task', 15);
INSERT INTO `auth_permission` VALUES (58, 'Can change 任务表', 'change_task', 15);
INSERT INTO `auth_permission` VALUES (59, 'Can delete 任务表', 'delete_task', 15);
INSERT INTO `auth_permission` VALUES (60, 'Can view 任务表', 'view_task', 15);
INSERT INTO `auth_permission` VALUES (61, 'Can add 任务记录表', 'add_task_record', 16);
INSERT INTO `auth_permission` VALUES (62, 'Can change 任务记录表', 'change_task_record', 16);
INSERT INTO `auth_permission` VALUES (63, 'Can delete 任务记录表', 'delete_task_record', 16);
INSERT INTO `auth_permission` VALUES (64, 'Can view 任务记录表', 'view_task_record', 16);
INSERT INTO `auth_permission` VALUES (65, 'Can add 用户任务答案表', 'add_user_task_answer', 17);
INSERT INTO `auth_permission` VALUES (66, 'Can change 用户任务答案表', 'change_user_task_answer', 17);
INSERT INTO `auth_permission` VALUES (67, 'Can delete 用户任务答案表', 'delete_user_task_answer', 17);
INSERT INTO `auth_permission` VALUES (68, 'Can view 用户任务答案表', 'view_user_task_answer', 17);
INSERT INTO `auth_permission` VALUES (69, 'Can add 用户试卷答案', 'add_user_paper_answer', 18);
INSERT INTO `auth_permission` VALUES (70, 'Can change 用户试卷答案', 'change_user_paper_answer', 18);
INSERT INTO `auth_permission` VALUES (71, 'Can delete 用户试卷答案', 'delete_user_paper_answer', 18);
INSERT INTO `auth_permission` VALUES (72, 'Can view 用户试卷答案', 'view_user_paper_answer', 18);
INSERT INTO `auth_permission` VALUES (73, 'Can add 用户表', 'add_user', 19);
INSERT INTO `auth_permission` VALUES (74, 'Can change 用户表', 'change_user', 19);
INSERT INTO `auth_permission` VALUES (75, 'Can delete 用户表', 'delete_user', 19);
INSERT INTO `auth_permission` VALUES (76, 'Can view 用户表', 'view_user', 19);
INSERT INTO `auth_permission` VALUES (77, 'Can add 用户动态表', 'add_dynamicmessage', 20);
INSERT INTO `auth_permission` VALUES (78, 'Can change 用户动态表', 'change_dynamicmessage', 20);
INSERT INTO `auth_permission` VALUES (79, 'Can delete 用户动态表', 'delete_dynamicmessage', 20);
INSERT INTO `auth_permission` VALUES (80, 'Can view 用户动态表', 'view_dynamicmessage', 20);
INSERT INTO `auth_permission` VALUES (81, 'Can add 教师表', 'add_teacher', 21);
INSERT INTO `auth_permission` VALUES (82, 'Can change 教师表', 'change_teacher', 21);
INSERT INTO `auth_permission` VALUES (83, 'Can delete 教师表', 'delete_teacher', 21);
INSERT INTO `auth_permission` VALUES (84, 'Can view 教师表', 'view_teacher', 21);
INSERT INTO `auth_permission` VALUES (85, 'Can add 章节表', 'add_coursechapter', 22);
INSERT INTO `auth_permission` VALUES (86, 'Can change 章节表', 'change_coursechapter', 22);
INSERT INTO `auth_permission` VALUES (87, 'Can delete 章节表', 'delete_coursechapter', 22);
INSERT INTO `auth_permission` VALUES (88, 'Can view 章节表', 'view_coursechapter', 22);
INSERT INTO `auth_permission` VALUES (89, 'Can add 订单详情', 'add_orderdetail', 23);
INSERT INTO `auth_permission` VALUES (90, 'Can change 订单详情', 'change_orderdetail', 23);
INSERT INTO `auth_permission` VALUES (91, 'Can delete 订单详情', 'delete_orderdetail', 23);
INSERT INTO `auth_permission` VALUES (92, 'Can view 订单详情', 'view_orderdetail', 23);
INSERT INTO `auth_permission` VALUES (93, 'Can add 订单记录', 'add_order', 24);
INSERT INTO `auth_permission` VALUES (94, 'Can change 订单记录', 'change_order', 24);
INSERT INTO `auth_permission` VALUES (95, 'Can delete 订单记录', 'delete_order', 24);
INSERT INTO `auth_permission` VALUES (96, 'Can view 订单记录', 'view_order', 24);
INSERT INTO `auth_permission` VALUES (97, 'Can add 电影表', 'add_movies', 25);
INSERT INTO `auth_permission` VALUES (98, 'Can change 电影表', 'change_movies', 25);
INSERT INTO `auth_permission` VALUES (99, 'Can delete 电影表', 'delete_movies', 25);
INSERT INTO `auth_permission` VALUES (100, 'Can view 电影表', 'view_movies', 25);

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `first_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES (1, 'pbkdf2_sha256$150000$9HYAcMnWPiGf$CcbPbeuTNaP/TkGa8J6DRjaqydWXGARh4mYUpGToyJo=', '2021-08-10 17:27:44.286457', 1, 'admin', '', '', '', 1, 1, '2021-08-09 21:54:37.231228');

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id`, `group_id`) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id`, `permission_id`) USING BTREE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id`) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 65 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES (1, '2021-08-09 21:57:00.899393', '1', '魔都老男孩', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (2, '2021-08-09 21:57:03.067138', '1', 'Python', 1, '[{\"added\": {}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (3, '2021-08-09 21:57:10.558879', '2', 'Linux', 1, '[{\"added\": {}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (4, '2021-08-09 21:57:21.419859', '3', '数据分析', 1, '[{\"added\": {}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (5, '2021-08-09 21:57:37.605058', '1', '每日默写', 1, '[{\"added\": {}}]', 15, 1);
INSERT INTO `django_admin_log` VALUES (6, '2021-08-09 21:57:57.300961', '1', 'Choice_Question object (1)', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (7, '2021-08-09 21:58:10.237345', '2', 'Choice_Question object (2)', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (8, '2021-08-09 21:58:22.052890', '3', 'Choice_Question object (3)', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (9, '2021-08-09 21:58:34.789677', '4', 'Choice_Question object (4)', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (10, '2021-08-09 21:58:48.245737', '5', 'Choice_Question object (5)', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (11, '2021-08-09 21:59:04.759212', '1', 'Choice_Question object (1)', 2, '[{\"changed\": {\"fields\": [\"title\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (12, '2021-08-09 21:59:11.742684', '2', 'Choice_Question object (2)', 2, '[{\"changed\": {\"fields\": [\"title\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (13, '2021-08-09 21:59:17.989954', '3', 'Choice_Question object (3)', 2, '[{\"changed\": {\"fields\": [\"title\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (14, '2021-08-09 21:59:24.905015', '3', 'Choice_Question object (3)', 2, '[]', 8, 1);
INSERT INTO `django_admin_log` VALUES (15, '2021-08-09 21:59:30.369867', '4', 'Choice_Question object (4)', 2, '[{\"changed\": {\"fields\": [\"title\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (16, '2021-08-09 21:59:37.862044', '5', 'Choice_Question object (5)', 2, '[{\"changed\": {\"fields\": [\"title\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (17, '2021-08-09 22:00:16.315718', '1', '简述Python垃圾回收机制', 1, '[{\"added\": {}}]', 14, 1);
INSERT INTO `django_admin_log` VALUES (18, '2021-08-09 22:00:27.647661', '2', '简述TCP协议', 1, '[{\"added\": {}}]', 14, 1);
INSERT INTO `django_admin_log` VALUES (19, '2021-08-09 22:00:36.544702', '3', '简述HTTP协议', 1, '[{\"added\": {}}]', 14, 1);
INSERT INTO `django_admin_log` VALUES (20, '2021-08-09 22:00:46.838226', '4', '简述Django生命周期', 1, '[{\"added\": {}}]', 14, 1);
INSERT INTO `django_admin_log` VALUES (21, '2021-08-09 22:00:56.063912', '5', '简述JWT认证', 1, '[{\"added\": {}}]', 14, 1);
INSERT INTO `django_admin_log` VALUES (22, '2021-08-09 22:01:33.117421', '1', 'Python', 1, '[{\"added\": {}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (23, '2021-08-09 22:01:35.479052', '1', 'Python基础', 1, '[{\"added\": {}}]', 12, 1);
INSERT INTO `django_admin_log` VALUES (24, '2021-08-09 22:02:28.407861', '1', 'banner1', 1, '[{\"added\": {}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (25, '2021-08-09 22:02:41.628539', '2', 'banner2', 1, '[{\"added\": {}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (26, '2021-08-09 22:02:51.025373', '3', 'banner3', 1, '[{\"added\": {}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (27, '2021-08-09 22:03:00.345656', '4', 'banner4', 1, '[{\"added\": {}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (28, '2021-08-10 18:10:47.599729', '5', 'Task_Record object (5)', 2, '[{\"changed\": {\"fields\": [\"state\", \"task_score\", \"user_task_answer\"]}}]', 16, 1);
INSERT INTO `django_admin_log` VALUES (29, '2021-08-10 19:02:53.916874', '5', '简述JWT认证', 2, '[{\"changed\": {\"fields\": [\"task_score\"]}}]', 14, 1);
INSERT INTO `django_admin_log` VALUES (30, '2021-08-10 19:03:08.732687', '4', '简述Django生命周期', 2, '[{\"changed\": {\"fields\": [\"task_score\"]}}]', 14, 1);
INSERT INTO `django_admin_log` VALUES (31, '2021-08-10 19:03:13.342329', '3', '简述HTTP协议', 2, '[{\"changed\": {\"fields\": [\"task_score\"]}}]', 14, 1);
INSERT INTO `django_admin_log` VALUES (32, '2021-08-10 19:03:17.390206', '2', '简述TCP协议', 2, '[{\"changed\": {\"fields\": [\"task_score\"]}}]', 14, 1);
INSERT INTO `django_admin_log` VALUES (33, '2021-08-10 19:03:21.386997', '1', '简述Python垃圾回收机制', 2, '[{\"changed\": {\"fields\": [\"task_score\"]}}]', 14, 1);
INSERT INTO `django_admin_log` VALUES (34, '2021-08-10 19:14:11.324993', '6', 'Task_Record object (6)', 2, '[{\"changed\": {\"fields\": [\"task_score\"]}}]', 16, 1);
INSERT INTO `django_admin_log` VALUES (35, '2021-08-10 19:14:15.660503', '7', 'Task_Record object (7)', 2, '[{\"changed\": {\"fields\": [\"task_score\"]}}]', 16, 1);
INSERT INTO `django_admin_log` VALUES (36, '2021-08-10 19:14:22.067349', '7', 'Task_Record object (7)', 2, '[{\"changed\": {\"fields\": [\"state\"]}}]', 16, 1);
INSERT INTO `django_admin_log` VALUES (37, '2021-08-10 19:14:24.920082', '6', 'Task_Record object (6)', 2, '[{\"changed\": {\"fields\": [\"state\"]}}]', 16, 1);
INSERT INTO `django_admin_log` VALUES (38, '2021-08-11 22:22:00.543910', '1', 'Choice_Question object (1)', 2, '[{\"changed\": {\"fields\": [\"title\", \"score\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (39, '2021-08-11 22:22:11.364878', '1', 'Choice_Question object (1)', 2, '[{\"changed\": {\"fields\": [\"title\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (40, '2021-08-11 22:22:19.924271', '2', 'Choice_Question object (2)', 2, '[{\"changed\": {\"fields\": [\"score\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (41, '2021-08-11 22:22:27.956013', '3', 'Choice_Question object (3)', 2, '[{\"changed\": {\"fields\": [\"score\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (42, '2021-08-11 22:22:36.620554', '4', 'Choice_Question object (4)', 2, '[{\"changed\": {\"fields\": [\"score\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (43, '2021-08-11 22:22:51.208452', '5', 'Choice_Question object (5)', 2, '[{\"changed\": {\"fields\": [\"score\"]}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (46, '2021-08-12 19:26:50.071542', '1', 'Egon', 1, '[{\"added\": {}}]', 21, 1);
INSERT INTO `django_admin_log` VALUES (47, '2021-08-12 19:27:18.905383', '2', '老刘', 1, '[{\"added\": {}}]', 21, 1);
INSERT INTO `django_admin_log` VALUES (48, '2021-08-12 19:31:05.337513', '2', '老刘', 2, '[{\"changed\": {\"fields\": [\"course\"]}}]', 21, 1);
INSERT INTO `django_admin_log` VALUES (49, '2021-08-12 19:31:08.844760', '1', 'Egon', 2, '[{\"changed\": {\"fields\": [\"course\"]}}]', 21, 1);
INSERT INTO `django_admin_log` VALUES (50, '2021-08-12 19:37:52.282642', '1', 'Egon', 2, '[{\"changed\": {\"fields\": [\"teacher_motto\"]}}]', 21, 1);
INSERT INTO `django_admin_log` VALUES (51, '2021-08-12 19:38:13.388195', '2', '老刘', 2, '[{\"changed\": {\"fields\": [\"teacher_motto\"]}}]', 21, 1);
INSERT INTO `django_admin_log` VALUES (52, '2021-08-12 19:40:36.930384', '3', 'Jason', 1, '[{\"added\": {}}]', 21, 1);
INSERT INTO `django_admin_log` VALUES (54, '2021-08-12 19:45:04.327503', '1', 'Python', 2, '[{\"changed\": {\"fields\": [\"course_brief\", \"major\", \"course_user\"]}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (55, '2021-08-12 19:46:06.955462', '1', 'Python', 2, '[{\"changed\": {\"fields\": [\"course_user\"]}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (56, '2021-08-12 20:20:25.248720', '1', 'Python', 3, '', 10, 1);
INSERT INTO `django_admin_log` VALUES (57, '2021-08-12 20:33:19.634772', '1', 'Python', 2, '[{\"changed\": {\"fields\": [\"course_user\"]}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (58, '2021-08-12 20:34:20.344500', '2', 'Linux', 1, '[{\"added\": {}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (59, '2021-08-12 20:46:50.396476', '1', 'Python', 2, '[{\"changed\": {\"fields\": [\"course_brief\"]}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (60, '2021-08-12 20:50:18.207584', '2', 'Linux', 2, '[{\"changed\": {\"fields\": [\"course_brief\"]}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (61, '2021-08-12 20:57:44.393934', '1', 'Python', 2, '[{\"changed\": {\"fields\": [\"course_brief\"]}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (62, '2021-08-12 20:57:56.790317', '2', 'Linux', 2, '[{\"changed\": {\"fields\": [\"course_brief\"]}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (63, '2021-08-12 21:08:21.430361', '2', 'Linux', 2, '[]', 10, 1);
INSERT INTO `django_admin_log` VALUES (64, '2021-08-12 21:08:54.846709', '2', 'Linux', 2, '[]', 10, 1);

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (7, 'exam', 'banner');
INSERT INTO `django_content_type` VALUES (8, 'exam', 'choice_question');
INSERT INTO `django_content_type` VALUES (9, 'exam', 'college');
INSERT INTO `django_content_type` VALUES (10, 'exam', 'course');
INSERT INTO `django_content_type` VALUES (22, 'exam', 'coursechapter');
INSERT INTO `django_content_type` VALUES (20, 'exam', 'dynamicmessage');
INSERT INTO `django_content_type` VALUES (11, 'exam', 'major');
INSERT INTO `django_content_type` VALUES (25, 'exam', 'movies');
INSERT INTO `django_content_type` VALUES (24, 'exam', 'order');
INSERT INTO `django_content_type` VALUES (23, 'exam', 'orderdetail');
INSERT INTO `django_content_type` VALUES (12, 'exam', 'paper');
INSERT INTO `django_content_type` VALUES (13, 'exam', 'paper_record');
INSERT INTO `django_content_type` VALUES (14, 'exam', 'simple_question');
INSERT INTO `django_content_type` VALUES (15, 'exam', 'task');
INSERT INTO `django_content_type` VALUES (16, 'exam', 'task_record');
INSERT INTO `django_content_type` VALUES (21, 'exam', 'teacher');
INSERT INTO `django_content_type` VALUES (19, 'exam', 'user');
INSERT INTO `django_content_type` VALUES (18, 'exam', 'user_paper_answer');
INSERT INTO `django_content_type` VALUES (17, 'exam', 'user_task_answer');
INSERT INTO `django_content_type` VALUES (6, 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2021-08-09 21:46:12.573843');
INSERT INTO `django_migrations` VALUES (2, 'contenttypes', '0002_remove_content_type_name', '2021-08-09 21:46:12.632677');
INSERT INTO `django_migrations` VALUES (3, 'auth', '0001_initial', '2021-08-09 21:46:12.758340');
INSERT INTO `django_migrations` VALUES (4, 'admin', '0001_initial', '2021-08-09 21:46:13.090799');
INSERT INTO `django_migrations` VALUES (5, 'admin', '0002_logentry_user', '2021-08-09 21:46:13.164592');
INSERT INTO `django_migrations` VALUES (6, 'exam', '0001_initial', '2021-08-09 21:46:13.676475');
INSERT INTO `django_migrations` VALUES (7, 'sessions', '0001_initial', '2021-08-09 21:56:03.416851');
INSERT INTO `django_migrations` VALUES (8, 'exam', '0002_auto_20210809_2317', '2021-08-09 23:17:56.952431');
INSERT INTO `django_migrations` VALUES (9, 'exam', '0003_user_paper_answer_is_true', '2021-08-10 08:05:47.090157');
INSERT INTO `django_migrations` VALUES (10, 'exam', '0004_auto_20210810_1624', '2021-08-10 16:25:05.171004');
INSERT INTO `django_migrations` VALUES (11, 'exam', '0005_auto_20210810_1902', '2021-08-10 19:02:29.716489');
INSERT INTO `django_migrations` VALUES (12, 'exam', '0006_remove_task_record_que_answer', '2021-08-10 19:04:40.717006');
INSERT INTO `django_migrations` VALUES (13, 'exam', '0007_auto_20210810_2232', '2021-08-10 22:32:12.655132');
INSERT INTO `django_migrations` VALUES (14, 'exam', '0008_dynamicmessage', '2021-08-11 17:31:44.593665');
INSERT INTO `django_migrations` VALUES (15, 'exam', '0009_auto_20210812_1920', '2021-08-12 19:20:40.374055');
INSERT INTO `django_migrations` VALUES (16, 'exam', '0010_auto_20210812_1930', '2021-08-12 19:30:59.456966');
INSERT INTO `django_migrations` VALUES (17, 'exam', '0011_auto_20210812_1945', '2021-08-12 19:45:56.705179');
INSERT INTO `django_migrations` VALUES (18, 'exam', '0012_order_orderdetail', '2021-08-12 23:25:46.956854');
INSERT INTO `django_migrations` VALUES (19, 'exam', '0013_auto_20210813_0001', '2021-08-13 00:01:55.518845');
INSERT INTO `django_migrations` VALUES (20, 'exam', '0014_remove_course_course_user', '2021-08-13 00:06:52.719575');
INSERT INTO `django_migrations` VALUES (21, 'exam', '0015_auto_20210813_1445', '2021-08-13 14:45:12.237045');
INSERT INTO `django_migrations` VALUES (22, 'exam', '0016_auto_20210813_1451', '2021-08-13 14:51:41.453167');
INSERT INTO `django_migrations` VALUES (23, 'exam', '0017_auto_20210813_2343', '2021-08-13 23:43:52.132046');
INSERT INTO `django_migrations` VALUES (24, 'exam', '0018_coursechapter_chapter_time', '2021-08-14 15:02:29.305382');
INSERT INTO `django_migrations` VALUES (25, 'exam', '0019_auto_20210815_1240', '2021-08-15 12:40:21.131136');
INSERT INTO `django_migrations` VALUES (26, 'exam', '0020_movies_movie_img', '2021-08-15 13:24:30.750873');
INSERT INTO `django_migrations` VALUES (27, 'exam', '0021_auto_20210815_1345', '2021-08-15 13:45:18.504582');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('gjcmyxm0z9t3441oiq7tcippit5hfvng', 'Y2VlNDU1NzY2ODM3NWQ1ZDNiNDc3NTlmNDE5YzdhNWJlODIxYjA0OTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxNWJlNzcyMjMzNTBkYWFkNGFmODY4MTFhY2ZhNmVhMjQ5OTE5ZTQ1IiwiX21lbnVzIjoiW3tcIm5hbWVcIjogXCJcXHU4MDAzXFx1OGJkNVxcdTdjZmJcXHU3ZWRmXFx1NTQwZVxcdTUzZjBcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcIm1vZGVsc1wiOiBbe1wibmFtZVwiOiBcIlxcdTRlMTNcXHU0ZTFhXFx1ODg2OFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL2V4YW0vbWFqb3IvXCIsIFwiYWRkVXJsXCI6IFwiL2FkbWluL2V4YW0vbWFqb3IvYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiXFx1ODAwM1xcdThiZDVcXHU3Y2ZiXFx1N2VkZlxcdTU0MGVcXHU1M2YwXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJcXHU0ZTEzXFx1NGUxYVxcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDJ9LCB7XCJuYW1lXCI6IFwiXFx1NGVmYlxcdTUyYTFcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vZXhhbS90YXNrL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi9leGFtL3Rhc2svYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiXFx1ODAwM1xcdThiZDVcXHU3Y2ZiXFx1N2VkZlxcdTU0MGVcXHU1M2YwXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJcXHU0ZWZiXFx1NTJhMVxcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDN9LCB7XCJuYW1lXCI6IFwiXFx1NGVmYlxcdTUyYTFcXHU4YmIwXFx1NWY1NVxcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi9leGFtL3Rhc2tfcmVjb3JkL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi9leGFtL3Rhc2tfcmVjb3JkL2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIlxcdTgwMDNcXHU4YmQ1XFx1N2NmYlxcdTdlZGZcXHU1NDBlXFx1NTNmMFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiXFx1NGVmYlxcdTUyYTFcXHU4YmIwXFx1NWY1NVxcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDR9LCB7XCJuYW1lXCI6IFwiXFx1NTM1NVxcdTkwMDlcXHU5ODk4XFx1ODg2OFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL2V4YW0vY2hvaWNlX3F1ZXN0aW9uL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi9leGFtL2Nob2ljZV9xdWVzdGlvbi9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJcXHU4MDAzXFx1OGJkNVxcdTdjZmJcXHU3ZWRmXFx1NTQwZVxcdTUzZjBcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifSwge1wibmFtZVwiOiBcIlxcdTUzNTVcXHU5MDA5XFx1OTg5OFxcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDV9LCB7XCJuYW1lXCI6IFwiXFx1NWI2NlxcdTk2NjJcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vZXhhbS9jb2xsZWdlL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi9leGFtL2NvbGxlZ2UvYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiXFx1ODAwM1xcdThiZDVcXHU3Y2ZiXFx1N2VkZlxcdTU0MGVcXHU1M2YwXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJcXHU1YjY2XFx1OTY2MlxcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDZ9LCB7XCJuYW1lXCI6IFwiXFx1NzUyOFxcdTYyMzdcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS11c2VyXCIsIFwidXJsXCI6IFwiL2FkbWluL2V4YW0vdXNlci9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vZXhhbS91c2VyL2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIlxcdTgwMDNcXHU4YmQ1XFx1N2NmYlxcdTdlZGZcXHU1NDBlXFx1NTNmMFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiXFx1NzUyOFxcdTYyMzdcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS11c2VyXCJ9XSwgXCJlaWRcIjogMTAwN30sIHtcIm5hbWVcIjogXCJcXHU3YjgwXFx1N2I1NFxcdTk4OThcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vZXhhbS9zaW1wbGVfcXVlc3Rpb24vXCIsIFwiYWRkVXJsXCI6IFwiL2FkbWluL2V4YW0vc2ltcGxlX3F1ZXN0aW9uL2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIlxcdTgwMDNcXHU4YmQ1XFx1N2NmYlxcdTdlZGZcXHU1NDBlXFx1NTNmMFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiXFx1N2I4MFxcdTdiNTRcXHU5ODk4XFx1ODg2OFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9XSwgXCJlaWRcIjogMTAwOH0sIHtcIm5hbWVcIjogXCJcXHU4YmQ1XFx1NTM3N1xcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi9leGFtL3BhcGVyL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi9leGFtL3BhcGVyL2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIlxcdTgwMDNcXHU4YmQ1XFx1N2NmYlxcdTdlZGZcXHU1NDBlXFx1NTNmMFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiXFx1OGJkNVxcdTUzNzdcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDA5fSwge1wibmFtZVwiOiBcIlxcdThmNmVcXHU2NGFkXFx1NTZmZVxcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi9leGFtL2Jhbm5lci9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vZXhhbS9iYW5uZXIvYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiXFx1ODAwM1xcdThiZDVcXHU3Y2ZiXFx1N2VkZlxcdTU0MGVcXHU1M2YwXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJcXHU4ZjZlXFx1NjRhZFxcdTU2ZmVcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDEwfV0sIFwiZWlkXCI6IDEwMDF9LCB7XCJuYW1lXCI6IFwiXFx1OGJhNFxcdThiYzFcXHU1NDhjXFx1NjM4OFxcdTY3NDNcIiwgXCJpY29uXCI6IFwiZmFzIGZhLXNoaWVsZC1hbHRcIiwgXCJtb2RlbHNcIjogW3tcIm5hbWVcIjogXCJcXHU3NTI4XFx1NjIzN1wiLCBcImljb25cIjogXCJmYXIgZmEtdXNlclwiLCBcInVybFwiOiBcIi9hZG1pbi9hdXRoL3VzZXIvXCIsIFwiYWRkVXJsXCI6IFwiL2FkbWluL2F1dGgvdXNlci9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJcXHU4YmE0XFx1OGJjMVxcdTU0OGNcXHU2Mzg4XFx1Njc0M1wiLCBcImljb25cIjogXCJmYXMgZmEtc2hpZWxkLWFsdFwifSwge1wibmFtZVwiOiBcIlxcdTc1MjhcXHU2MjM3XCIsIFwiaWNvblwiOiBcImZhciBmYS11c2VyXCJ9XSwgXCJlaWRcIjogMTAxMn0sIHtcIm5hbWVcIjogXCJcXHU3ZWM0XCIsIFwiaWNvblwiOiBcImZhcyBmYS11c2Vycy1jb2dcIiwgXCJ1cmxcIjogXCIvYWRtaW4vYXV0aC9ncm91cC9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vYXV0aC9ncm91cC9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJcXHU4YmE0XFx1OGJjMVxcdTU0OGNcXHU2Mzg4XFx1Njc0M1wiLCBcImljb25cIjogXCJmYXMgZmEtc2hpZWxkLWFsdFwifSwge1wibmFtZVwiOiBcIlxcdTdlYzRcIiwgXCJpY29uXCI6IFwiZmFzIGZhLXVzZXJzLWNvZ1wifV0sIFwiZWlkXCI6IDEwMTN9XSwgXCJlaWRcIjogMTAxMX1dIn0=', '2021-08-24 17:29:45.375559');
INSERT INTO `django_session` VALUES ('v8uud2zbrapv8b5dq3g4u2am4jg4nv39', 'NTc0NzM5ZDczMWMwZWYwMTJjNjI3NDIwNmI1N2M1MTFkNmMzNTBhMjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxNWJlNzcyMjMzNTBkYWFkNGFmODY4MTFhY2ZhNmVhMjQ5OTE5ZTQ1IiwiX21lbnVzIjoiW3tcIm5hbWVcIjogXCJcXHU4MDAzXFx1OGJkNVxcdTdjZmJcXHU3ZWRmXFx1NTQwZVxcdTUzZjBcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcIm1vZGVsc1wiOiBbe1wibmFtZVwiOiBcIlxcdTRlMTNcXHU0ZTFhXFx1ODg2OFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL2V4YW0vbWFqb3IvXCIsIFwiYWRkVXJsXCI6IFwiL2FkbWluL2V4YW0vbWFqb3IvYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiXFx1ODAwM1xcdThiZDVcXHU3Y2ZiXFx1N2VkZlxcdTU0MGVcXHU1M2YwXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJcXHU0ZTEzXFx1NGUxYVxcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDJ9LCB7XCJuYW1lXCI6IFwiXFx1NGVmYlxcdTUyYTFcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vZXhhbS90YXNrL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi9leGFtL3Rhc2svYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiXFx1ODAwM1xcdThiZDVcXHU3Y2ZiXFx1N2VkZlxcdTU0MGVcXHU1M2YwXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJcXHU0ZWZiXFx1NTJhMVxcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDN9LCB7XCJuYW1lXCI6IFwiXFx1NGVmYlxcdTUyYTFcXHU4YmIwXFx1NWY1NVxcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi9leGFtL3Rhc2tfcmVjb3JkL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi9leGFtL3Rhc2tfcmVjb3JkL2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIlxcdTgwMDNcXHU4YmQ1XFx1N2NmYlxcdTdlZGZcXHU1NDBlXFx1NTNmMFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiXFx1NGVmYlxcdTUyYTFcXHU4YmIwXFx1NWY1NVxcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDR9LCB7XCJuYW1lXCI6IFwiXFx1NTM1NVxcdTkwMDlcXHU5ODk4XFx1ODg2OFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL2V4YW0vY2hvaWNlX3F1ZXN0aW9uL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi9leGFtL2Nob2ljZV9xdWVzdGlvbi9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJcXHU4MDAzXFx1OGJkNVxcdTdjZmJcXHU3ZWRmXFx1NTQwZVxcdTUzZjBcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifSwge1wibmFtZVwiOiBcIlxcdTUzNTVcXHU5MDA5XFx1OTg5OFxcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDV9LCB7XCJuYW1lXCI6IFwiXFx1NWI2NlxcdTk2NjJcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vZXhhbS9jb2xsZWdlL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi9leGFtL2NvbGxlZ2UvYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiXFx1ODAwM1xcdThiZDVcXHU3Y2ZiXFx1N2VkZlxcdTU0MGVcXHU1M2YwXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJcXHU1YjY2XFx1OTY2MlxcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDZ9LCB7XCJuYW1lXCI6IFwiXFx1NzUyOFxcdTYyMzdcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS11c2VyXCIsIFwidXJsXCI6IFwiL2FkbWluL2V4YW0vdXNlci9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vZXhhbS91c2VyL2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIlxcdTgwMDNcXHU4YmQ1XFx1N2NmYlxcdTdlZGZcXHU1NDBlXFx1NTNmMFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiXFx1NzUyOFxcdTYyMzdcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS11c2VyXCJ9XSwgXCJlaWRcIjogMTAwN30sIHtcIm5hbWVcIjogXCJcXHU3NTM1XFx1NWY3MVxcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi9leGFtL21vdmllcy9cIiwgXCJhZGRVcmxcIjogXCIvYWRtaW4vZXhhbS9tb3ZpZXMvYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiXFx1ODAwM1xcdThiZDVcXHU3Y2ZiXFx1N2VkZlxcdTU0MGVcXHU1M2YwXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJcXHU3NTM1XFx1NWY3MVxcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDh9LCB7XCJuYW1lXCI6IFwiXFx1N2FlMFxcdTgyODJcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vZXhhbS9jb3Vyc2VjaGFwdGVyL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi9leGFtL2NvdXJzZWNoYXB0ZXIvYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiXFx1ODAwM1xcdThiZDVcXHU3Y2ZiXFx1N2VkZlxcdTU0MGVcXHU1M2YwXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJcXHU3YWUwXFx1ODI4MlxcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMDl9LCB7XCJuYW1lXCI6IFwiXFx1N2I4MFxcdTdiNTRcXHU5ODk4XFx1ODg2OFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL2V4YW0vc2ltcGxlX3F1ZXN0aW9uL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi9leGFtL3NpbXBsZV9xdWVzdGlvbi9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJcXHU4MDAzXFx1OGJkNVxcdTdjZmJcXHU3ZWRmXFx1NTQwZVxcdTUzZjBcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifSwge1wibmFtZVwiOiBcIlxcdTdiODBcXHU3YjU0XFx1OTg5OFxcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifV0sIFwiZWlkXCI6IDEwMTB9LCB7XCJuYW1lXCI6IFwiXFx1OGJhMlxcdTUzNTVcXHU4YmIwXFx1NWY1NVwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL2V4YW0vb3JkZXIvXCIsIFwiYWRkVXJsXCI6IFwiL2FkbWluL2V4YW0vb3JkZXIvYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiXFx1ODAwM1xcdThiZDVcXHU3Y2ZiXFx1N2VkZlxcdTU0MGVcXHU1M2YwXCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn0sIHtcIm5hbWVcIjogXCJcXHU4YmEyXFx1NTM1NVxcdThiYjBcXHU1ZjU1XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDExfSwge1wibmFtZVwiOiBcIlxcdThiYTJcXHU1MzU1XFx1OGJlNlxcdTYwYzVcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi9leGFtL29yZGVyZGV0YWlsL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi9leGFtL29yZGVyZGV0YWlsL2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIlxcdTgwMDNcXHU4YmQ1XFx1N2NmYlxcdTdlZGZcXHU1NDBlXFx1NTNmMFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiXFx1OGJhMlxcdTUzNTVcXHU4YmU2XFx1NjBjNVwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9XSwgXCJlaWRcIjogMTAxMn0sIHtcIm5hbWVcIjogXCJcXHU4YmQ1XFx1NTM3N1xcdTg4NjhcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwiLCBcInVybFwiOiBcIi9hZG1pbi9leGFtL3BhcGVyL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi9leGFtL3BhcGVyL2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIlxcdTgwMDNcXHU4YmQ1XFx1N2NmYlxcdTdlZGZcXHU1NDBlXFx1NTNmMFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiXFx1OGJkNVxcdTUzNzdcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIn1dLCBcImVpZFwiOiAxMDEzfSwge1wibmFtZVwiOiBcIlxcdThiZmVcXHU3YTBiXFx1ODg2OFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCIsIFwidXJsXCI6IFwiL2FkbWluL2V4YW0vY291cnNlL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi9leGFtL2NvdXJzZS9hZGQvXCIsIFwiYnJlYWRjcnVtYnNcIjogW3tcIm5hbWVcIjogXCJcXHU4MDAzXFx1OGJkNVxcdTdjZmJcXHU3ZWRmXFx1NTQwZVxcdTUzZjBcIiwgXCJpY29uXCI6IFwiZmFyIGZhLWNpcmNsZVwifSwge1wibmFtZVwiOiBcIlxcdThiZmVcXHU3YTBiXFx1ODg2OFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9XSwgXCJlaWRcIjogMTAxNH0sIHtcIm5hbWVcIjogXCJcXHU4ZjZlXFx1NjRhZFxcdTU2ZmVcXHU4ODY4XCIsIFwiaWNvblwiOiBcImZhciBmYS1jaXJjbGVcIiwgXCJ1cmxcIjogXCIvYWRtaW4vZXhhbS9iYW5uZXIvXCIsIFwiYWRkVXJsXCI6IFwiL2FkbWluL2V4YW0vYmFubmVyL2FkZC9cIiwgXCJicmVhZGNydW1ic1wiOiBbe1wibmFtZVwiOiBcIlxcdTgwMDNcXHU4YmQ1XFx1N2NmYlxcdTdlZGZcXHU1NDBlXFx1NTNmMFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9LCB7XCJuYW1lXCI6IFwiXFx1OGY2ZVxcdTY0YWRcXHU1NmZlXFx1ODg2OFwiLCBcImljb25cIjogXCJmYXIgZmEtY2lyY2xlXCJ9XSwgXCJlaWRcIjogMTAxNX1dLCBcImVpZFwiOiAxMDAxfSwge1wibmFtZVwiOiBcIlxcdThiYTRcXHU4YmMxXFx1NTQ4Y1xcdTYzODhcXHU2NzQzXCIsIFwiaWNvblwiOiBcImZhcyBmYS1zaGllbGQtYWx0XCIsIFwibW9kZWxzXCI6IFt7XCJuYW1lXCI6IFwiXFx1NzUyOFxcdTYyMzdcIiwgXCJpY29uXCI6IFwiZmFyIGZhLXVzZXJcIiwgXCJ1cmxcIjogXCIvYWRtaW4vYXV0aC91c2VyL1wiLCBcImFkZFVybFwiOiBcIi9hZG1pbi9hdXRoL3VzZXIvYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiXFx1OGJhNFxcdThiYzFcXHU1NDhjXFx1NjM4OFxcdTY3NDNcIiwgXCJpY29uXCI6IFwiZmFzIGZhLXNoaWVsZC1hbHRcIn0sIHtcIm5hbWVcIjogXCJcXHU3NTI4XFx1NjIzN1wiLCBcImljb25cIjogXCJmYXIgZmEtdXNlclwifV0sIFwiZWlkXCI6IDEwMTd9LCB7XCJuYW1lXCI6IFwiXFx1N2VjNFwiLCBcImljb25cIjogXCJmYXMgZmEtdXNlcnMtY29nXCIsIFwidXJsXCI6IFwiL2FkbWluL2F1dGgvZ3JvdXAvXCIsIFwiYWRkVXJsXCI6IFwiL2FkbWluL2F1dGgvZ3JvdXAvYWRkL1wiLCBcImJyZWFkY3J1bWJzXCI6IFt7XCJuYW1lXCI6IFwiXFx1OGJhNFxcdThiYzFcXHU1NDhjXFx1NjM4OFxcdTY3NDNcIiwgXCJpY29uXCI6IFwiZmFzIGZhLXNoaWVsZC1hbHRcIn0sIHtcIm5hbWVcIjogXCJcXHU3ZWM0XCIsIFwiaWNvblwiOiBcImZhcyBmYS11c2Vycy1jb2dcIn1dLCBcImVpZFwiOiAxMDE4fV0sIFwiZWlkXCI6IDEwMTZ9XSJ9', '2021-08-30 07:47:09.480493');

-- ----------------------------
-- Table structure for study_banner
-- ----------------------------
DROP TABLE IF EXISTS `study_banner`;
CREATE TABLE `study_banner`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `link` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `info` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `title`(`title`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of study_banner
-- ----------------------------
INSERT INTO `study_banner` VALUES (1, 'banner1', 'banner/banner1.png', '/', '/');
INSERT INTO `study_banner` VALUES (2, 'banner2', 'banner/banner2.png', '/', '/');
INSERT INTO `study_banner` VALUES (3, 'banner3', 'banner/banner3.png', '/', '/');
INSERT INTO `study_banner` VALUES (4, 'banner4', 'banner/banner4.png', '/', '/');

-- ----------------------------
-- Table structure for study_choice_question
-- ----------------------------
DROP TABLE IF EXISTS `study_choice_question`;
CREATE TABLE `study_choice_question`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `a` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `b` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `c` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `d` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `answer` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `score` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of study_choice_question
-- ----------------------------
INSERT INTO `study_choice_question` VALUES (1, '测试题一', 'A', 'B', 'C', 'D', 'A', '20');
INSERT INTO `study_choice_question` VALUES (2, '测试题二', 'A', 'B', 'C', 'D', 'A', '20');
INSERT INTO `study_choice_question` VALUES (3, '测试题三', 'A', 'B', 'C', 'D', 'A', '20');
INSERT INTO `study_choice_question` VALUES (4, '测试题四', 'A', 'B', 'C', 'D', 'A', '20');
INSERT INTO `study_choice_question` VALUES (5, '测试题五', 'A', 'B', 'C', 'D', 'A', '20');

-- ----------------------------
-- Table structure for study_college
-- ----------------------------
DROP TABLE IF EXISTS `study_college`;
CREATE TABLE `study_college`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `college_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `college_addr` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of study_college
-- ----------------------------
INSERT INTO `study_college` VALUES (1, '魔都学院', '上海');

-- ----------------------------
-- Table structure for study_course
-- ----------------------------
DROP TABLE IF EXISTS `study_course`;
CREATE TABLE `study_course`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `course_price` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `course_img` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `major_id` int(11) NULL DEFAULT NULL,
  `course_brief` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `course_pub_date` date NULL DEFAULT NULL,
  `course_sections` int(11) NULL DEFAULT NULL,
  `course_students` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of study_course
-- ----------------------------
INSERT INTO `study_course` VALUES (1, 'Python', '21888', 'course_img/Python.png', 1, '迎上AI风口，抓住行业红利，0基础6个月炼成人工智能时代热门人才!!!', '2021-08-12', 0, 8888);
INSERT INTO `study_course` VALUES (2, 'Linux', '16888', 'course_img/Linux_BVpJ6wM.png', 2, '玩转Linux，不写代码也能高薪，零基础首选，年薪30万不是梦!!!', '2021-08-12', 0, 6666);

-- ----------------------------
-- Table structure for study_course_chapter
-- ----------------------------
DROP TABLE IF EXISTS `study_course_chapter`;
CREATE TABLE `study_course_chapter`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chapter_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `chapter_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `course_id` int(11) NOT NULL,
  `chapter_time` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `study_course_chapter_course_id_6413221e_fk_study_course_id`(`course_id`) USING BTREE,
  CONSTRAINT `study_course_chapter_course_id_6413221e_fk_study_course_id` FOREIGN KEY (`course_id`) REFERENCES `study_course` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of study_course_chapter
-- ----------------------------
INSERT INTO `study_course_chapter` VALUES (21, ' 01.编程与编程语言介绍', '01.编程与编程语言介绍.mp4', 1, '46:54');
INSERT INTO `study_course_chapter` VALUES (22, '02.解释器多版本共存', '02.解释器多版本共存.mp4', 1, '11:31');
INSERT INTO `study_course_chapter` VALUES (23, '03.运行代码的两种方式', '03.运行代码的两种方式.mp4', 1, '06:21');
INSERT INTO `study_course_chapter` VALUES (24, '04.变量', '04.变量.mp4', 1, '50:03');
INSERT INTO `study_course_chapter` VALUES (25, '05.与用户交互', '05.与用户交互.mp4', 1, '07:39');
INSERT INTO `study_course_chapter` VALUES (26, '06.数据类型', '06.数据类型.mp4', 1, '51:06');
INSERT INTO `study_course_chapter` VALUES (27, '07.可变不可变类型', '07.可变不可变类型.mp4', 1, '12:28');
INSERT INTO `study_course_chapter` VALUES (28, '08.格式化输出', '08.格式化输出.mp4', 1, '08:08');
INSERT INTO `study_course_chapter` VALUES (29, '09.运算符', '09.运算符.mp4', 1, '25:03');
INSERT INTO `study_course_chapter` VALUES (30, '10.if判断', '10.if判断.mp4', 1, '18:26');
INSERT INTO `study_course_chapter` VALUES (31, '11.while循环', '11.while循环.mp4', 1, '40:55');

-- ----------------------------
-- Table structure for study_dynamic_message
-- ----------------------------
DROP TABLE IF EXISTS `study_dynamic_message`;
CREATE TABLE `study_dynamic_message`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `message` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `study_dynamic_message_user_id_38e51985_fk_study_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `study_dynamic_message_user_id_38e51985_fk_study_user_id` FOREIGN KEY (`user_id`) REFERENCES `study_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 87 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of study_dynamic_message
-- ----------------------------
INSERT INTO `study_dynamic_message` VALUES (44, '2021-08-15 19:37:38.863749', 'zqw提交了每日任务!', 1);
INSERT INTO `study_dynamic_message` VALUES (45, '2021-08-15 19:39:47.391908', 'zqw提交了基础试卷!得分:100分!', 1);
INSERT INTO `study_dynamic_message` VALUES (46, '2021-08-15 19:39:47.438754', 'zqw提交了基础试卷!得分:80分!', 1);
INSERT INTO `study_dynamic_message` VALUES (47, '2021-08-15 19:39:47.465689', 'zqw提交了基础试卷!得分:0分!', 1);
INSERT INTO `study_dynamic_message` VALUES (48, '2021-08-15 19:39:47.486655', 'zqw提交了基础试卷!得分:0分!', 1);
INSERT INTO `study_dynamic_message` VALUES (49, '2021-08-15 19:39:47.524525', 'zqw提交了基础试卷!得分:60分!', 1);
INSERT INTO `study_dynamic_message` VALUES (50, '2021-08-15 19:40:23.976582', 'zqw提交了每日任务!', 1);
INSERT INTO `study_dynamic_message` VALUES (51, '2021-08-15 19:41:23.286672', 'zqw修改个人信息!', 1);
INSERT INTO `study_dynamic_message` VALUES (52, '2021-08-15 19:41:30.079484', 'zqw修改个人信息!', 1);
INSERT INTO `study_dynamic_message` VALUES (53, '2021-08-15 19:42:57.149825', 'zqw使用手机登录学无止境学习系统!', 1);
INSERT INTO `study_dynamic_message` VALUES (54, '2021-08-15 19:44:59.220516', 'zqw使用手机登录学无止境学习系统!', 1);
INSERT INTO `study_dynamic_message` VALUES (58, '2021-08-15 20:06:13.274592', 'zqw使用账号登录学无止境学习系统!', 1);
INSERT INTO `study_dynamic_message` VALUES (59, '2021-08-15 20:06:14.102013', 'zqw使用账号登录学无止境学习系统!', 1);
INSERT INTO `study_dynamic_message` VALUES (60, '2021-08-15 20:06:14.891374', 'zqw使用账号登录学无止境学习系统!', 1);
INSERT INTO `study_dynamic_message` VALUES (61, '2021-08-15 20:06:15.115972', 'zqw使用账号登录学无止境学习系统!', 1);
INSERT INTO `study_dynamic_message` VALUES (62, '2021-08-15 20:06:15.324185', 'zqw使用账号登录学无止境学习系统!', 1);
INSERT INTO `study_dynamic_message` VALUES (63, '2021-08-15 20:06:28.396213', 'zqw使用账号登录学无止境学习系统!', 1);
INSERT INTO `study_dynamic_message` VALUES (64, '2021-08-15 20:16:46.066838', 'zqw使用账号登录学无止境学习系统!', 1);
INSERT INTO `study_dynamic_message` VALUES (65, '2021-08-15 20:22:36.215756', 'zqw使用账号登录学无止境学习系统!', 1);
INSERT INTO `study_dynamic_message` VALUES (66, '2021-08-15 20:25:07.826487', 'zqw使用账号登录学无止境学习系统!', 1);
INSERT INTO `study_dynamic_message` VALUES (67, '2021-08-15 20:51:34.320459', 'zqw通过邮箱成功找回了密码!', 1);
INSERT INTO `study_dynamic_message` VALUES (68, '2021-08-15 20:54:14.298398', 'zqw通过邮箱成功找回了密码!', 1);
INSERT INTO `study_dynamic_message` VALUES (69, '2021-08-15 20:54:18.511325', 'zqw使用账号登录学无止境学习系统!', 1);
INSERT INTO `study_dynamic_message` VALUES (70, '2021-08-15 20:54:24.633122', 'zqw使用账号登录学无止境学习系统!', 1);
INSERT INTO `study_dynamic_message` VALUES (71, '2021-08-15 20:55:23.177382', 'zqw通过手机成功找回了密码!', 1);
INSERT INTO `study_dynamic_message` VALUES (72, '2021-08-15 20:55:26.609831', 'zqw使用账号登录学无止境学习系统!', 1);
INSERT INTO `study_dynamic_message` VALUES (73, '2021-08-15 21:16:27.322079', 'zqw通过手机成功找回了密码!', 1);
INSERT INTO `study_dynamic_message` VALUES (74, '2021-08-15 21:19:28.227678', 'zqw通过手机成功找回了密码!', 1);
INSERT INTO `study_dynamic_message` VALUES (75, '2021-08-15 21:19:35.289192', 'zqw使用账号登录学无止境学习系统!', 1);
INSERT INTO `study_dynamic_message` VALUES (76, '2021-08-16 07:48:02.202760', 'zqw使用账号登录学无止境学习系统!', 1);
INSERT INTO `study_dynamic_message` VALUES (77, '2021-08-16 07:53:17.324661', 'zqw修改个人信息!', 1);
INSERT INTO `study_dynamic_message` VALUES (78, '2021-08-16 07:53:43.451556', 'zqw修改个人信息!', 1);
INSERT INTO `study_dynamic_message` VALUES (79, '2021-08-16 08:22:48.377869', 'zqw修改个人信息!', 1);
INSERT INTO `study_dynamic_message` VALUES (80, '2021-08-16 08:26:06.346926', 'zqw修改个人信息!', 1);
INSERT INTO `study_dynamic_message` VALUES (81, '2021-08-16 15:50:31.873840', 'zqw使用账号登录学无止境学习系统!', 1);
INSERT INTO `study_dynamic_message` VALUES (82, '2021-08-16 15:51:42.638720', 'zqw提交了基础试卷!得分:40分!', 1);
INSERT INTO `study_dynamic_message` VALUES (83, '2021-08-16 16:03:25.722526', 'zqw修改个人信息!', 1);
INSERT INTO `study_dynamic_message` VALUES (84, '2021-08-16 16:04:44.860995', 'zqw修改个人信息!', 1);
INSERT INTO `study_dynamic_message` VALUES (85, '2021-08-16 16:04:51.135609', 'zqw修改个人信息!', 1);
INSERT INTO `study_dynamic_message` VALUES (86, '2021-08-16 16:04:58.477922', 'zqw修改个人信息!', 1);

-- ----------------------------
-- Table structure for study_major
-- ----------------------------
DROP TABLE IF EXISTS `study_major`;
CREATE TABLE `study_major`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `major_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `college_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `study_major_college_id_fc87176b_fk_study_college_id`(`college_id`) USING BTREE,
  CONSTRAINT `study_major_college_id_fc87176b_fk_study_college_id` FOREIGN KEY (`college_id`) REFERENCES `study_college` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of study_major
-- ----------------------------
INSERT INTO `study_major` VALUES (1, 'Python', 1);
INSERT INTO `study_major` VALUES (2, 'Linux', 1);
INSERT INTO `study_major` VALUES (3, '数据分析', 1);

-- ----------------------------
-- Table structure for study_movies
-- ----------------------------
DROP TABLE IF EXISTS `study_movies`;
CREATE TABLE `study_movies`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `movie_title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `movie_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `movie_time` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `movie_img` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of study_movies
-- ----------------------------
INSERT INTO `study_movies` VALUES (1, '千与千寻', '千与千寻.mp4', '02:04:02', 'qyqx.png');
INSERT INTO `study_movies` VALUES (2, '大话西游之大圣娶亲', '大话西游之大圣娶亲.mp4', '01:54:06', 'dhxy.png');
INSERT INTO `study_movies` VALUES (3, '头号玩家', '头号玩家.mp4', '02:19:28', 'thwj.png');
INSERT INTO `study_movies` VALUES (4, '寂静之地2', '寂静之地2.mp4', '01:37:01', 'jjzd2.png');
INSERT INTO `study_movies` VALUES (5, '当幸福来敲门', '当幸福来敲门.mp4', '01:55:57', 'dxflqm.png');
INSERT INTO `study_movies` VALUES (6, '速度与激情9', '速度与激情9.mp4', '02:22:51', 'sdyjq9.png');

-- ----------------------------
-- Table structure for study_order
-- ----------------------------
DROP TABLE IF EXISTS `study_order`;
CREATE TABLE `study_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `total_amount` decimal(10, 2) NOT NULL,
  `out_trade_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trade_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `order_status` smallint(6) NOT NULL,
  `pay_type` smallint(6) NOT NULL,
  `pay_time` datetime(6) NULL DEFAULT NULL,
  `created_time` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  `course_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `out_trade_no`(`out_trade_no`) USING BTREE,
  INDEX `study_order_user_id_ea6e6297`(`user_id`) USING BTREE,
  INDEX `study_order_course_id_f4bf0181_fk_study_course_id`(`course_id`) USING BTREE,
  CONSTRAINT `study_order_course_id_f4bf0181_fk_study_course_id` FOREIGN KEY (`course_id`) REFERENCES `study_course` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `study_order_user_id_ea6e6297_fk_study_user_id` FOREIGN KEY (`user_id`) REFERENCES `study_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of study_order
-- ----------------------------

-- ----------------------------
-- Table structure for study_order_detail
-- ----------------------------
DROP TABLE IF EXISTS `study_order_detail`;
CREATE TABLE `study_order_detail`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price` decimal(10, 2) NOT NULL,
  `course_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `study_order_detail_course_id_d502eb52`(`course_id`) USING BTREE,
  INDEX `study_order_detail_order_id_c97fdee8`(`order_id`) USING BTREE,
  CONSTRAINT `study_order_detail_course_id_d502eb52_fk_study_course_id` FOREIGN KEY (`course_id`) REFERENCES `study_course` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `study_order_detail_order_id_c97fdee8_fk_study_order_id` FOREIGN KEY (`order_id`) REFERENCES `study_order` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of study_order_detail
-- ----------------------------

-- ----------------------------
-- Table structure for study_paper
-- ----------------------------
DROP TABLE IF EXISTS `study_paper`;
CREATE TABLE `study_paper`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `time` int(11) NOT NULL,
  `paper_level` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `paper_score` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `course_id` int(11) NOT NULL,
  `major_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `title`(`title`) USING BTREE,
  INDEX `study_paper_course_id_2e178bde_fk_study_course_id`(`course_id`) USING BTREE,
  INDEX `study_paper_major_id_b3ae6a6f_fk_study_major_id`(`major_id`) USING BTREE,
  CONSTRAINT `study_paper_course_id_2e178bde_fk_study_course_id` FOREIGN KEY (`course_id`) REFERENCES `study_course` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `study_paper_major_id_b3ae6a6f_fk_study_major_id` FOREIGN KEY (`major_id`) REFERENCES `study_major` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of study_paper
-- ----------------------------
INSERT INTO `study_paper` VALUES (1, 'Python基础', 20, '3', '50', 1, 1);

-- ----------------------------
-- Table structure for study_paper_choice_question
-- ----------------------------
DROP TABLE IF EXISTS `study_paper_choice_question`;
CREATE TABLE `study_paper_choice_question`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `paper_id` int(11) NOT NULL,
  `choice_question_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `study_paper_choice_quest_paper_id_choice_question_f972267b_uniq`(`paper_id`, `choice_question_id`) USING BTREE,
  INDEX `study_paper_choice_q_choice_question_id_f8737ce1_fk_study_cho`(`choice_question_id`) USING BTREE,
  CONSTRAINT `study_paper_choice_q_choice_question_id_f8737ce1_fk_study_cho` FOREIGN KEY (`choice_question_id`) REFERENCES `study_choice_question` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `study_paper_choice_question_paper_id_6dc2cf5e_fk_study_paper_id` FOREIGN KEY (`paper_id`) REFERENCES `study_paper` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of study_paper_choice_question
-- ----------------------------
INSERT INTO `study_paper_choice_question` VALUES (5, 1, 1);
INSERT INTO `study_paper_choice_question` VALUES (4, 1, 2);
INSERT INTO `study_paper_choice_question` VALUES (3, 1, 3);
INSERT INTO `study_paper_choice_question` VALUES (2, 1, 4);
INSERT INTO `study_paper_choice_question` VALUES (1, 1, 5);

-- ----------------------------
-- Table structure for study_paper_record
-- ----------------------------
DROP TABLE IF EXISTS `study_paper_record`;
CREATE TABLE `study_paper_record`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `paper_score` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `paper_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `study_paper_record_paper_id_3f94f14c_fk_study_paper_id`(`paper_id`) USING BTREE,
  CONSTRAINT `study_paper_record_paper_id_3f94f14c_fk_study_paper_id` FOREIGN KEY (`paper_id`) REFERENCES `study_paper` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 65 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of study_paper_record
-- ----------------------------
INSERT INTO `study_paper_record` VALUES (64, '1', '2021-08-16 15:50:46.103984', '40', 1, 1);

-- ----------------------------
-- Table structure for study_simple_question
-- ----------------------------
DROP TABLE IF EXISTS `study_simple_question`;
CREATE TABLE `study_simple_question`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `task_id` int(11) NULL DEFAULT NULL,
  `task_score` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of study_simple_question
-- ----------------------------
INSERT INTO `study_simple_question` VALUES (1, '简述Python垃圾回收机制', '111', 1, '20');
INSERT INTO `study_simple_question` VALUES (2, '简述TCP协议', '111', 1, '20');
INSERT INTO `study_simple_question` VALUES (3, '简述HTTP协议', '111', 1, '20');
INSERT INTO `study_simple_question` VALUES (4, '简述Django生命周期', '111', 1, '20');
INSERT INTO `study_simple_question` VALUES (5, '简述JWT认证', '111', 1, '20');

-- ----------------------------
-- Table structure for study_task
-- ----------------------------
DROP TABLE IF EXISTS `study_task`;
CREATE TABLE `study_task`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `task_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `task_time` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `task_level` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `task_score` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of study_task
-- ----------------------------
INSERT INTO `study_task` VALUES (1, '每日默写', '1', '24', '1', '100');

-- ----------------------------
-- Table structure for study_task_record
-- ----------------------------
DROP TABLE IF EXISTS `study_task_record`;
CREATE TABLE `study_task_record`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `task_score` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `task_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `study_task_record_task_id_6be0cbb1_fk_study_task_id`(`task_id`) USING BTREE,
  CONSTRAINT `study_task_record_task_id_6be0cbb1_fk_study_task_id` FOREIGN KEY (`task_id`) REFERENCES `study_task` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of study_task_record
-- ----------------------------

-- ----------------------------
-- Table structure for study_task_record_user_task_answer
-- ----------------------------
DROP TABLE IF EXISTS `study_task_record_user_task_answer`;
CREATE TABLE `study_task_record_user_task_answer`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_record_id` int(11) NOT NULL,
  `user_task_answer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `study_task_record_user_t_task_record_id_user_task_b3fbcbe4_uniq`(`task_record_id`, `user_task_answer_id`) USING BTREE,
  INDEX `study_task_record_us_user_task_answer_id_dc2958f0_fk_study_use`(`user_task_answer_id`) USING BTREE,
  CONSTRAINT `study_task_record_us_task_record_id_1d38c9dd_fk_study_tas` FOREIGN KEY (`task_record_id`) REFERENCES `study_task_record` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `study_task_record_us_user_task_answer_id_dc2958f0_fk_study_use` FOREIGN KEY (`user_task_answer_id`) REFERENCES `study_user_task_answer` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of study_task_record_user_task_answer
-- ----------------------------

-- ----------------------------
-- Table structure for study_user
-- ----------------------------
DROP TABLE IF EXISTS `study_user`;
CREATE TABLE `study_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `real_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `age` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sex` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `create_time` datetime(6) NOT NULL,
  `major_id` int(11) NULL DEFAULT NULL,
  `is_vip` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `phone`(`phone`) USING BTREE,
  INDEX `study_user_major_id_8dd1e62f_fk_study_major_id`(`major_id`) USING BTREE,
  CONSTRAINT `study_user_major_id_8dd1e62f_fk_study_major_id` FOREIGN KEY (`major_id`) REFERENCES `study_major` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of study_user
-- ----------------------------
INSERT INTO `study_user` VALUES (1, 'zqw', '左大大', '21', '1', '191249375@qq.com', '13373824455', 'c3817bffe53c69bf9f7d0d883965c3bc', 'avatar/QQ.jpg', '2021-08-09 21:53:44.038559', 1, 0);

-- ----------------------------
-- Table structure for study_user_paper_answer
-- ----------------------------
DROP TABLE IF EXISTS `study_user_paper_answer`;
CREATE TABLE `study_user_paper_answer`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `paper_record_id` int(11) NULL DEFAULT NULL,
  `que_id` int(11) NULL DEFAULT NULL,
  `is_true` tinyint(1) NOT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `study_user_paper_ans_paper_record_id_5243a94e_fk_study_pap`(`paper_record_id`) USING BTREE,
  INDEX `study_user_paper_answer_que_id_64202913`(`que_id`) USING BTREE,
  INDEX `study_user_paper_answer_user_id_3ed7be57_fk_study_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `study_user_paper_ans_paper_record_id_5243a94e_fk_study_pap` FOREIGN KEY (`paper_record_id`) REFERENCES `study_paper_record` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `study_user_paper_answer_user_id_3ed7be57_fk_study_user_id` FOREIGN KEY (`user_id`) REFERENCES `study_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 295 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of study_user_paper_answer
-- ----------------------------
INSERT INTO `study_user_paper_answer` VALUES (290, 'A', 64, 1, 1, 1);
INSERT INTO `study_user_paper_answer` VALUES (291, 'A', 64, 2, 1, 1);
INSERT INTO `study_user_paper_answer` VALUES (292, 'C', 64, 3, 0, 1);
INSERT INTO `study_user_paper_answer` VALUES (293, 'D', 64, 4, 0, 1);
INSERT INTO `study_user_paper_answer` VALUES (294, 'C', 64, 5, 0, 1);

-- ----------------------------
-- Table structure for study_user_task_answer
-- ----------------------------
DROP TABLE IF EXISTS `study_user_task_answer`;
CREATE TABLE `study_user_task_answer`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `que_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `study_user_task_answ_que_id_74b300de_fk_study_sim`(`que_id`) USING BTREE,
  CONSTRAINT `study_user_task_answ_que_id_74b300de_fk_study_sim` FOREIGN KEY (`que_id`) REFERENCES `study_simple_question` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of study_user_task_answer
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
