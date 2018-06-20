-- oracle sql
-- ͳ��20171001��20171007�ڼ���������3���з��ʵ��û��嵥
select pt.msisdn, pt.record_day, pt.pv, ui.sex
  from PAGEVISIT pt, USER_INFO ui
 where pt.msisdn = ui.msisdn
   and pt.msisdn in
       (select msisdn
          from (select pt.*,
                       trunc(pt.record_day - row_number()
                             over(partition by pt.msisdn order by
                                  pt.record_day)) rn
                  from USER_INFO ui, PAGEVISIT pt
                 where ui.msisdn = pt.msisdn
                   and pt.record_day between '20171001' and '20171007')
         group by msisdn, rn
        having count(1) >= 3);