聚合查询

    
    from django.db import connection
    from django.dbmodels import Sum

    假设model:
    class collectCompanyDaily(models.Model):
        today_rece=models.FloatField(null=True, blank=True,default=0,verbose_name=u'总接曲量')
        record_date = models.DateField(null=True, default=None,db_index=True,verbose_name=u'记录日期')

    按天归档统计
    select={'day':connection.ops.date_trunc_sql('day','record_date')}
    collectCompanyDaily.objects.extra(select=select).values('day').annotate(
      Sum('today_rece'),
      )
    
    按小时归档统计
    select={'hour':connection.ops.date_trunc_sql('hour','record_date')}
    collectCompanyDaily.objects.extra(select=select).values('hour').annotate(
      Sum('today_rece'),
      )
