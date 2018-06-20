-- oracle sql
/*ͳ��ÿ��������н������top3���û��б�ע�����ڶ���н����ͬ���������ǰ����н��ֱ�Ϊ10��8��8��7���򷵻صĽ�����������ˣ�
���������Ϣ����������|Ա������|н��
*/

select dept_name ��������, name Ա������, salary н��
  from (select name,
               salary,
               a.departmentid,
               b.dept_name,
               dense_rank() over(partition by a.departmentid order by salary desc) rn
          from EMPLOYEE a, DEPARTMENT b
         where a.departmentid = b.departmentid)
 where rn <= 3;