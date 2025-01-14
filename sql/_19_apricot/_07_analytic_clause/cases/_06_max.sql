
create table t(i1 int, i2 int, i3 int);
insert into t values
(1,1,1),
(1,1,2),
(1,2,1),
(1,2,2),
(1,2,3),
(2,1,1),
(2,1,2),
(2,1,3),
(2,1,4),
(2,2,1),
(2,2,2),
(2,3,1),
(2,3,2),
(2,3,3);

-- OVER()
select i1,i2,i3,max(i1) over() from t order by 1 desc, 2 desc, 3 desc;
select i1,i2,i3,max(distinct i1) over () from t order by 1 desc, 2 desc, 3 desc;
select i1,i2,i3,max(i2) over(), max(i3) over() from t order by 1 desc, 2 desc, 3 desc;
select i1,i2,i3,max(distinct i2) over(), max(distinct i3) over() from t order by 1 desc, 2 desc, 3 desc;

-- OVER(PARTITION BY)
select i1,i2,i3,max(i2) over (partition by i1) from t order by 1, 2 desc, 3 desc;
select i1,i2,i3,max(distinct i2) over (partition by i1) from t order by 1, 2 desc, 3 desc;
select i1,i2,i3,max(i3) over (partition by i1,i2) from t order by 1, 2, 3 desc;
select i1,i2,i3,max(distinct i3) over (partition by i1,i2) from t order by 1, 2, 3 desc;

-- OVER(ORDER BY)
select i1,i2,i3,max(i2) over (order by i1) from t order by 1, 2 desc, 3 desc;
select i1,i2,i3,max(distinct i2) over (order by i1) from t order by 1, 2 desc, 3 desc;
select i1,i2,i3,max(i3) over (order by i1,i2) from t order by 1, 2, 3 desc;
select i1,i2,i3,max(distinct i3) over (order by i1,i2) from t order by 1, 2, 3 desc;

-- OVER(PARTITION BY ORDER BY)
select i1,i2,i3,max(i3) over (partittion by i1 order by i2) from t order by 1, 2, 3 desc;
select i1,i2,i3,max(distinct i3) over (partition by i1 order by i2) from t order by 1, 2, 3 desc;
select i1,i2,i3,max(i3) over (partition by i1 order by i2,i3) from t order by 1, 2, 3;
select i1,i2,i3,max(distinct i3) over (partition by i1 order by i2,i3) from t order by 1, 2, 3;
select i1,i2,i3,max(i3) over (partition by i1,i2 order by i3) from t order by 1, 2, 3;
select i1,i2,i3,max(distinct i3) over (partition by i1,i2 order by i3) from t order by 1, 2, 3;

drop t;
