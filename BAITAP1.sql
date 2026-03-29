-- Dữ liệu 
create database session7_8;
create table orders (
    order_id serial primary key,
    customer_id int,
    order_date date,
    total_amount numeric
);
insert into orders (customer_id, order_date, total_amount)
select 
    (random() * 1000)::int,  -- 1000 khách hàng
    current_date - (random() * 365)::int,
    (random() * 10000000)::numeric
from generate_series(1, 100000);

-- Trước khi tạo B-tree
explain analyze
select * from orders where customer_id = 500;
/*
"Seq Scan on orders  (cost=0.00..1563.30 rows=366 width=44) (actual time=0.055..9.564 rows=95.00 loops=1)"
"  Filter: (customer_id = 500)"
"  Rows Removed by Filter: 99905"
"  Buffers: shared hit=648"
"Planning:"
"  Buffers: shared hit=2"
"Planning Time: 0.094 ms"
"Execution Time: 9.589 ms"
*/
-- Thực hiện quét tuần tự nên thời gian thực thi lâu 
create index idx_orders_customer_id on orders (customer_id );
explain analyze
select * from orders where customer_id = 500;
/*
"Bitmap Heap Scan on orders  (cost=5.06..270.30 rows=99 width=23) (actual time=0.108..0.198 rows=95.00 loops=1)"
"  Recheck Cond: (customer_id = 500)"
"  Heap Blocks: exact=91"
"  Buffers: shared hit=91 read=2"
"  ->  Bitmap Index Scan on idx_orders_customer_id  (cost=0.00..5.04 rows=99 width=0) (actual time=0.071..0.071 rows=95.00 loops=1)"
"        Index Cond: (customer_id = 500)"
"        Index Searches: 1"
"        Buffers: shared read=2"
"Planning:"
"  Buffers: shared hit=38 read=1 dirtied=1"
"Planning Time: 2.213 ms"
"Execution Time: 0.218 ms"
*/
-- Thời gian thực thi giảm từ 9.589 ms ->  0.218 ms khi sủ dụng B-tree index 