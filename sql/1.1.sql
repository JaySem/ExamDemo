-- oracle sql
-- 统计20171001至20171007期间累计访问pv大于100的男性用户数

Select count(1)
from PAGEVISIT pt, USER_INFO ui
Where pt. MSISDN = ui. MSISDN
And ui. SEX = ’男’
And pt. PV > 100
And RECORD_DAY between '20171001' and '20171007';



