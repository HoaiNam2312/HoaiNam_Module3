select  * from student where StudentName like 'h%';

select * from class where StartDate>'2008-12-01';

select * from subject where Credit between 3 and 5;

update student set ClassId = 2 where StudentName = 'Hung';

select stu.studentname, sub.subname, m.mark from
student stu join mark m on stu.StudentID = m.studentid
join `subject` sub on m.subid = sub.SubID
order by m.Mark desc, stu.StudentName asc;