use meanlifestudies

select * from election
select * from candidates


with cte as(
select c.*,count(distinct voter_id) as voters_count from candidates c join election e on c.id=e.candidate_id
group by  c.id,c.name)
select name from cte
where voters_count=(select max(voters_count) from cte)