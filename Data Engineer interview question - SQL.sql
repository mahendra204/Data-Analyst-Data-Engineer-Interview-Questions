use meanlifestudies

create table students (id int, name varchar(10))

insert into students values (1,'Mahi'),(2,'Mahendra'),(3,'Paresh'),(4,'Sam'),(5,'Rajesh')

create table friends (id int, friend_id int)

insert into friends values (1,2),(2,4),(3,5),(4,1),(5,3)

create table packages (id int, salary float)

insert into packages values (1, 12.5),(2,9.6),(3,16.2),(4,8.4),(5, 10.8)

select * from students
select * from friends
select * from packages

----Q 31) return students names whose friends are earning more salary than them.
 with cte as(
 select p.id as student_id, f.friend_id as friend_id, p.salary as student_salary from packages p join friends f on p.id = f.id
 ), cte2 as(
 select cte.student_id, cte.friend_id, cte.student_salary, c1.student_salary as friend_salary from cte join cte c1 on cte.friend_id = c1.student_id
 )
 select * from cte2 c2 join students s on c2.student_id = s.id where friend_salary > student_salary




