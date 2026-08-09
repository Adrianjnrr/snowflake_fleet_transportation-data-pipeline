with delivery_summary as(
    select 
    trip_id,
    avg(temperature) as avg_temperature,
    avg(precipitation) as avg_precipitation,
    avg(wind_speed) as avg_wind_speed,
    avg(relative_humidity) as avg_relative_humidity,
    avg(detention_minutes) as avg_detention_minutes,
    booland_agg(on_time_flag) as on_time_flag

    from {{ ref('fact_delivery_events')}}
    group by trip_id
)

select
ft.trip_id,
ft.dispatch_date,
ft.trip_status,
ft.actual_duration_hours,
ft.fuel_gallon_used,
ft.actual_distance_miles,
ft.average_mpg,
ft.idle_time_hours,


dc.customer_name,
dc.customer_type,

drv.first_name,
drv.last_name,

r.origin_city,
r.origin_state,

tr.trailer_type,

dd.month_name,
dd.quarter,
dd.year,

de.on_time_flag,
de.avg_detention_minutes,
de.avg_temperature,
de.avg_precipitation,
de.avg_wind_speed,
de.avg_relative_humidity





from {{ ref("fact_trips")}} ft
left join {{ ref('dim_customers')}} dc
on ft.customer_id = dc.customer_id

left join {{ ref('dim_drivers')}} drv
on ft.driver_id = drv.driver_id

left join {{ ref('dim_routes')}} r
on ft.route_id = r.route_id
 
left join {{ ref('dim_trailer') }} tr
on ft.trailer_id = tr.trailer_id 

left join {{ ref('dim_date') }} dd
on ft.dispatch_date = dd.full_date   

left join delivery_summary de
on ft.trip_id = de.trip_id

