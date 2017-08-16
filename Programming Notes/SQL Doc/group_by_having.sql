select d.DNAME, e.DEPTNO , sum(e.SAL) from emp e, dept d
where e.deptno = d.deptno
group by d.DNAME, e.deptno  
having sum(e.sal) = (select max(sum(e1.sal)) from emp e1 , dept d1
	   			  	 where e1.deptno = d1.deptno
					 --and  d.dname  not like 'RESEARCH'
	   			  	 group by e1.deptno)   -- group by having

select d.DNAME, e.DEPTNO , sum(e.SAL) from emp e, dept d
where e.deptno = d.deptno
group by d.DNAME, e.deptno  
having sum(e.sal) = (select max(sum(e1.sal)) from emp e1 , dept d1
where e1.deptno = d1.deptno
and  d1.dname  not like 'RESEARCH'
group by e1.deptno)  --, max(sum(e1.sal))
					 
					 
					 
select max(sum(e1.sal)) from emp e1 , dept d1
where e1.deptno = d1.deptno
and  d1.dname  not like 'RESEARCH'
group by e1.deptno--, max(sum(e1.sal))



