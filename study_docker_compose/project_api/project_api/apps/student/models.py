# from django.db import models
#
#
# # 试卷表
# class TExamPaper(models.Model):
#     # 试卷名称
#     name = models.CharField(max_length=255, blank=True, null=True)
#     # 学科
#     subject_id = models.IntegerField(blank=True, null=True)
#     # 试卷类型
#     paper_type = models.IntegerField(blank=True, null=True)
#     # 试卷总分
#     score = models.IntegerField(blank=True, default=100)
#     # 题数
#     question_count = models.IntegerField(blank=True, null=True)
#     # 建议时长
#     suggest_time = models.IntegerField(blank=True, null=True)
#     # 开始时间
#     limit_start_time = models.DateTimeField(blank=True, null=True)
#     # 结束时间
#     limit_end_time = models.DateTimeField(blank=True, null=True)
#
#     frame_text_content_id = models.IntegerField(blank=True, null=True)
#
#     # 创建时间
#     create_time = models.DateTimeField(blank=True, auto_now_add=True)
#     # 删除时间
#     deleted = models.TextField(blank=True, null=True)  # This field type is a guess.
#     # 考试时间
#     task_exam_id = models.IntegerField(blank=True, null=True)
#
#     class Meta:
#         managed = False
#         db_table = 't_exam_paper'
#
#
# # 试卷答案表
# class TExamPaperAnswer(models.Model):
#     exam_paper_id = models.IntegerField(blank=True, null=True)
#     # 试卷名称
#     paper_name = models.CharField(max_length=255, blank=True, null=True)
#     # 试卷类型
#     paper_type = models.IntegerField(blank=True, null=True)
#     subject_id = models.IntegerField(blank=True, null=True)
#     system_score = models.IntegerField(blank=True, null=True)
#     user_score = models.IntegerField(blank=True, null=True)
#     paper_score = models.IntegerField(blank=True, null=True)
#     question_correct = models.IntegerField(blank=True, null=True)
#     question_count = models.IntegerField(blank=True, null=True)
#     do_time = models.IntegerField(blank=True, null=True)
#     status = models.IntegerField(blank=True, null=True)
#     create_user = models.IntegerField(blank=True, null=True)
#     create_time = models.DateTimeField(blank=True, null=True)
#     task_exam_id = models.IntegerField(blank=True, null=True)
#
#     class Meta:
#         managed = False
#         db_table = 't_exam_paper_answer'
#
#
# class TExamPaperQuestionCustomerAnswer(models.Model):
#     question_id = models.IntegerField(blank=True, null=True)
#     exam_paper_id = models.IntegerField(blank=True, null=True)
#     exam_paper_answer_id = models.IntegerField(blank=True, null=True)
#     question_type = models.IntegerField(blank=True, null=True)
#     subject_id = models.IntegerField(blank=True, null=True)
#     customer_score = models.IntegerField(blank=True, null=True)
#     question_score = models.IntegerField(blank=True, null=True)
#     question_text_content_id = models.IntegerField(blank=True, null=True)
#     answer = models.CharField(max_length=255, blank=True, null=True)
#     text_content_id = models.IntegerField(blank=True, null=True)
#     do_right = models.TextField(blank=True, null=True)  # This field type is a guess.
#     create_user = models.IntegerField(blank=True, null=True)
#     create_time = models.DateTimeField(blank=True, null=True)
#     item_order = models.IntegerField(blank=True, null=True)
#
#     class Meta:
#         managed = False
#         db_table = 't_exam_paper_question_customer_answer'
#
#
# class TMessage(models.Model):
#     title = models.CharField(max_length=255, blank=True, null=True)
#     content = models.CharField(max_length=500, blank=True, null=True)
#     create_time = models.DateTimeField(blank=True, null=True)
#     send_user_id = models.IntegerField(blank=True, null=True)
#     send_user_name = models.CharField(max_length=255, blank=True, null=True)
#     send_real_name = models.CharField(max_length=255, blank=True, null=True)
#     receive_user_count = models.IntegerField(blank=True, null=True)
#     read_count = models.IntegerField(blank=True, null=True)
#
#     class Meta:
#         managed = False
#         db_table = 't_message'
#
#
# class TMessageUser(models.Model):
#     message_id = models.IntegerField(blank=True, null=True)
#     receive_user_id = models.IntegerField(blank=True, null=True)
#     receive_user_name = models.CharField(max_length=255, blank=True, null=True)
#     receive_real_name = models.CharField(max_length=255, blank=True, null=True)
#     readed = models.TextField(blank=True, null=True)  # This field type is a guess.
#     create_time = models.DateTimeField(blank=True, null=True)
#     read_time = models.DateTimeField(blank=True, null=True)
#
#     class Meta:
#         managed = False
#         db_table = 't_message_user'
#
#
# class TQuestion(models.Model):
#     question_type = models.IntegerField(blank=True, null=True)
#     subject_id = models.IntegerField(blank=True, null=True)
#     score = models.IntegerField(blank=True, null=True)
#     grade_level = models.IntegerField(blank=True, null=True)
#     difficult = models.IntegerField(blank=True, null=True)
#     correct = models.TextField(blank=True, null=True)
#     info_text_content_id = models.IntegerField(blank=True, null=True)
#     create_user = models.IntegerField(blank=True, null=True)
#     status = models.IntegerField(blank=True, null=True)
#     create_time = models.DateTimeField(blank=True, null=True)
#     deleted = models.TextField(blank=True, null=True)  # This field type is a guess.
#
#     class Meta:
#         managed = False
#         db_table = 't_question'
#
#
# class TSubject(models.Model):
#     name = models.CharField(max_length=255, blank=True, null=True)
#     level = models.IntegerField(blank=True, null=True)
#     level_name = models.CharField(max_length=255, blank=True, null=True)
#     item_order = models.IntegerField(blank=True, null=True)
#     deleted = models.TextField(blank=True, null=True)  # This field type is a guess.
#
#     class Meta:
#         managed = False
#         db_table = 't_subject'
#
#
# class TTaskExam(models.Model):
#     title = models.CharField(max_length=255, blank=True, null=True)
#     grade_level = models.IntegerField(blank=True, null=True)
#     frame_text_content_id = models.IntegerField(blank=True, null=True)
#     create_user = models.IntegerField(blank=True, null=True)
#     create_time = models.DateTimeField(blank=True, null=True)
#     deleted = models.TextField(blank=True, null=True)  # This field type is a guess.
#     create_user_name = models.CharField(max_length=255, blank=True, null=True)
#
#     class Meta:
#         managed = False
#         db_table = 't_task_exam'
#
#
# class TTaskExamCustomerAnswer(models.Model):
#     task_exam_id = models.IntegerField(blank=True, null=True)
#     create_user = models.IntegerField(blank=True, null=True)
#     create_time = models.DateTimeField(blank=True, null=True)
#     text_content_id = models.IntegerField(blank=True, null=True)
#
#     class Meta:
#         managed = False
#         db_table = 't_task_exam_customer_answer'
#
#
# class TTextContent(models.Model):
#     content = models.TextField(blank=True, null=True)
#     create_time = models.DateTimeField(blank=True, null=True)
#
#     class Meta:
#         managed = False
#         db_table = 't_text_content'
#
#
# class TUser(models.Model):
#     user_uuid = models.CharField(max_length=36, blank=True, null=True)
#     user_name = models.CharField(max_length=255, blank=True, null=True)
#     password = models.CharField(max_length=255, blank=True, null=True)
#     real_name = models.CharField(max_length=255, blank=True, null=True)
#     age = models.IntegerField(blank=True, null=True)
#     sex = models.IntegerField(blank=True, null=True)
#     birth_day = models.DateTimeField(blank=True, null=True)
#     user_level = models.IntegerField(blank=True, null=True)
#     phone = models.CharField(max_length=255, blank=True, null=True)
#     role = models.IntegerField(blank=True, null=True)
#     status = models.IntegerField(blank=True, null=True)
#     image_path = models.CharField(max_length=255, blank=True, null=True)
#     create_time = models.DateTimeField(blank=True, null=True)
#     modify_time = models.DateTimeField(blank=True, null=True)
#     last_active_time = models.DateTimeField(blank=True, null=True)
#     deleted = models.TextField(blank=True, null=True)  # This field type is a guess.
#     wx_open_id = models.CharField(max_length=255, blank=True, null=True)
#
#     class Meta:
#         managed = False
#         db_table = 't_user'
#
#
# class TUserEventLog(models.Model):
#     user_id = models.IntegerField(blank=True, null=True)
#     user_name = models.CharField(max_length=255, blank=True, null=True)
#     real_name = models.CharField(max_length=255, blank=True, null=True)
#     content = models.TextField(blank=True, null=True)
#     create_time = models.DateTimeField(blank=True, null=True)
#
#     class Meta:
#         managed = False
#         db_table = 't_user_event_log'
#
#
# class TUserToken(models.Model):
#     token = models.CharField(max_length=36, blank=True, null=True)
#     user_id = models.IntegerField(blank=True, null=True)
#     wx_open_id = models.CharField(max_length=255, blank=True, null=True)
#     create_time = models.DateTimeField(blank=True, null=True)
#     end_time = models.DateTimeField(blank=True, null=True)
#     user_name = models.CharField(max_length=255, blank=True, null=True)
#
#     class Meta:
#         managed = False
#         db_table = 't_user_token'
