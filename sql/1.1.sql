-- oracle sql
-- ͳ��20171001��20171007�ڼ��ۼƷ���pv����100�������û���

Select count(1)
from PAGEVISIT pt, USER_INFO ui
Where pt. MSISDN = ui. MSISDN
And ui. SEX = ���С�
And pt. PV > 100
And RECORD_DAY between '20171001' and '20171007';



