select * from student;

select * from student where status = true;

SELECT * FROM `subject` where Credit<10;

-- SELECT * FROM class where ClassName = 'A1';

SELECT S.StudentId, S.StudentName, C.ClassName
FROM Student S join Class C on S.ClassId = C.ClassID;

SELECT S.StudentId, S.StudentName, C.ClassName
FROM Student S join Class C on S.ClassId = C.ClassID
WHERE C.ClassName = 'A1';


SELECT S.StudentId, S.StudentName, Sub.SubName, M.Mark FROM Student S 
join Mark M on S.StudentId = M.StudentId 
join Subject Sub on M.SubId = Sub.SubId
where sub.subname = 'CF';
