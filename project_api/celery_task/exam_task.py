from .celery import app
from exam import models


@app.task  # 异步批改试卷
def correcting_test_papers(paper_record_id, username):
    obj = models.Paper_Record.objects.filter(pk=paper_record_id).first()
    if obj.get_state_display() == '待批改':
        score = 0
        user_answer_list = [
            {'que_id': user_answer.que.pk, 'obj': user_answer, 'user_answer': user_answer.user_answer}
            for user_answer in obj.user_paper_answer_set.all()]

        paper_answer = [
            {'que_id': answer.que.pk, 'score': answer.que.score, 'answer': answer.que.get_answer_display()}
            for answer in obj.user_paper_answer_set.all()]

        for index, show in enumerate(user_answer_list):

            if paper_answer[index]['que_id'] == show['que_id']:
                if paper_answer[index]['answer'] == show['user_answer']:
                    score += int(paper_answer[index]['score'])
                    show['obj'].is_true = True
                    show['obj'].save()
                    # is_true_list.append(show['que_id'])

        obj.paper_score = score
        obj.state = '1'
        obj.save()

        models.DynamicMessage.objects.create(
            user_id=obj.user_id,
            message='%s提交了基础试卷!得分:%s分!' % (username, score)
        )
    return
