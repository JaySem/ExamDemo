-- oracle sql
/*统计每个部门中薪酬排名top3的用户列表（注：存在多人薪酬相同的情况，如前四人薪酬分别为10万，8万，8万，7万，则返回的结果包含此四人）
输出以下信息：部门名称|员工姓名|薪酬
*/

select dept_name 部门名称, name 员工姓名, salary 薪酬
  from (select name,
               salary,
               a.departmentid,
               b.dept_name,
               dense_rank() over(partition by a.departmentid order by salary desc) rn
          from EMPLOYEE a, DEPARTMENT b
         where a.departmentid = b.departmentid)
 where rn <= 3;