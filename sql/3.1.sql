-- oracle sql
/*ͳ��2013-10-01����2013-10-03���ڼ䣬ÿ��ǽ�ֹ�û���ȡ���ʡ����SQL���Ӧ�������½����ȡ���ʣ�Cancellation Rate��������λС����*/

with result_cancel_driver as
(
-- ˾����ȡ������
select request_at,count(1) drive_cancel_trips
  from TRIPS a, users b
 where a.request_at between '2013-10-01' and '2013-10-03'
   and a.status = 'CANCELLED_BY_DRIVER'
   and a.driver_id = b.user_id
   and b.banned = 'No'
   and b.role = 'DRIVER'
   group by request_at),
 result_all_driver as
(
  -- ˾�������е���
select request_at,count(1) drive_all_trips
  from TRIPS a, users b
 where a.request_at between '2013-10-01' and '2013-10-03'
   and a.driver_id = b.user_id
   and b.banned = 'No'
   and b.role = 'DRIVER'
   group by request_at)
select a.request_at Day,round(a.drive_cancel_trips/b.drive_all_trips,2) CancellationRate from result_cancel_driver a,result_all_driver b
where a.request_at =  b.request_at

-- ˾���ͳ˿͵Ľ��union 
union all

with result_cancel_client as
(
-- �˿͵�ȡ������
select request_at,count(1) client_cancel_trips
  from TRIPS a, users b
 where a.request_at between '2013-10-01' and '2013-10-03'
   and a.status = 'CANCELLED_BY_CLIENT'
   and a.cliend_id = b.user_id
   and b.banned = 'No'
   and b.role = 'CLIENT'
   group by request_at),
result_all_client as
(
  -- �˿͵����е���
  select request_at,count(1) drive_all_trips
  from TRIPS a, users b
 where a.request_at between '2013-10-01' and '2013-10-03'
   and a.cliend_id = b.user_id
   and b.banned = 'No'
   and b.role = 'CLIENT'
   group by request_at)
select a.request_at Day, round(a.client_cancel_trips/b.drive_all_trips,2) CancellationRate from result_cancel_client a, result_all_client b
where a.request_at = b.request_at;
