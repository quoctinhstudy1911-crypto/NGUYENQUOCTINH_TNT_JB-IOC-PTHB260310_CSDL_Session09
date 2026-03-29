-- Dữ liệu ( Sử dụng lại sales BAITAP3 )
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

create or replace procedure calculate_total_sales(
    start_date date,
    end_date date,
    out total numeric
)
language plpgsql
as $$
begin
    select coalesce(sum(amount), 0)
    into total
    from sales
    where sale_date between start_date and end_date;
end;
$$;

do $$
declare
    total numeric;
begin
    call calculate_total_sales('2024-01-01', '2024-01-04', total);
    raise notice 'tong doanh thu la: %', total;
end;
$$;


