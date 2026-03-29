-- Dữ liệu 
create database session7_8;
create table sales (
    sale_id serial primary key,
    customer_id int,
    product_id int,
    sale_date date,
    amount numeric
);

insert into sales (customer_id, product_id, sale_date, amount)
values
(1, 101, '2024-01-01', 500),
(1, 102, '2024-01-02', 700),
(2, 103, '2024-01-03', 300),
(2, 104, '2024-01-04', 400),
(3, 105, '2024-01-05', 1500),
(3, 106, '2024-01-06', 800);

-- Tạo View CustomerSales tổng hợp tổng amount theo từng customer_id

create view customersales as
select 
    customer_id,
    sum(amount) as total_amount
from sales
group by customer_id;

-- Viết truy vấn SELECT * FROM CustomerSales WHERE total_amount > 1000; để xem khách hàng mua nhiều
select *
from customersales
where total_amount > 1000;

-- Thử cập nhật một bản ghi qua View và quan sát kết quả
update customersales
set total_amount = 2000
where customer_id = 1;
-- kết quả:
/*
ERROR:  cannot update view "customersales"
Views containing GROUP BY are not automatically updatable. 

SQL state: 55000
Detail: Views containing GROUP BY are not automatically updatable.
Hint: To enable updating the view, provide an INSTEAD OF UPDATE trigger or an unconditional ON UPDATE DO INSTEAD rule.
*/
-- Do view chỉ thực hiện được cập nhật khi không có các điều kiện như join group by distinct thôi 