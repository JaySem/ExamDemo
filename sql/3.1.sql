-- oracle sql
/*统计2013-10-01日至2013-10-03日期间，每天非禁止用户的取消率。你的SQL语句应返回如下结果，取消率（Cancellation Rate）保留两位小数。*/

with result_cancel_driver as
(
-- 司机的取消单子
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
  -- 司机的所有单子
select request_at,count(1) drive_all_trips
  from TRIPS a, users b
 where a.request_at between '2013-10-01' and '2013-10-03'
   and a.driver_id = b.user_id
   and b.banned = 'No'
   and b.role = 'DRIVER'
   group by request_at)
select a.request_at Day,round(a.drive_cancel_trips/b.drive_all_trips,2) CancellationRate from result_cancel_driver a,result_all_driver b
where a.request_at =  b.request_at

-- 司机和乘客的结果union 
union all

with result_cancel_client as
(
-- 乘客的取消单子
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
  -- 乘客的所有单子
  select request_at,count(1) drive_all_trips
  from TRIPS a, users b
 where a.request_at between '2013-10-01' and '2013-10-03'
   and a.cliend_id = b.user_id
   and b.banned = 'No'
   and b.role = 'CLIENT'
   group by request_at)
select a.request_at Day, round(a.client_cancel_trips/b.drive_all_trips,2) CancellationRate from result_cancel_client a, result_all_client b
where a.request_at = b.request_at;
