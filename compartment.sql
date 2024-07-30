use meanlifestudies

create table crowd_info (
    crowd_id int,
    crowd_count int,
    compartment_id int,
    compartment_limit int
)


insert into crowd_info (crowd_id, crowd_count, compartment_id, compartment_limit) values
(1, 485, 101, 400),
(2, 358, 102, 300),
(3, 450, 103, 400),
(4, 380, 104, 200),
(5, 520, 105, 450),
(6, 265, 106, 250),
(7, 324, 107, 500),
(8, 203, 108, 150),
(9, 312, 109, 400),
(10, 233, 110, 100)

select * from crowd_info

select compartment_id, compartment_limit, total_pending, compartment_limit - total_pending  as rems from (
select *, sum(crowdpending) over(order by crowd_id) as total, sum(crowdpending) over() as total_pending
 from(
select *, crowd_count - compartment_limit as crowdpending from crowd_info)a)b


