- view: attributed_orders
  derived_table:
    sql: |
      SELECT
              ba.campaign,
              ba.click_date,
              co.country_iso,
              sum(ba.orders_attributed) as orders,
              sum(o.booking_cost_price * ba.orders_attributed) as gmv_fwd,
              sum(ba.first_order *ba.orders_attributed) as new_customers
              
            from marketing.bigquery_attribution ba
            left join dwh_dl.orders o on o.reference = ba.order_id and o.dwh_country_id = ba.dwh_country_id
            left join dwh_dl.orders_booking_cost_vouchers vc on vc.fk_orders_id = o._id and o.dwh_country_id = vc.dwh_country_id
            left join dwh_mart.t_dim_countries co on co.country_id =  ba.dwh_country_id 
            
            group by 1,2,3
            

  fields:
  - measure: count
    type: count
    drill_fields: detail*

  - dimension: campaign
    sql: ${TABLE}.campaign
    
  - dimension: country_iso
    sql: ${TABLE}.country_iso

  - measure: orders
    type: sum
    sql: ${TABLE}.orders

  - measure: gmv_fwd
    type: sum
    sql: ${TABLE}.gmv_fwd / 100

  - measure: new_customers
    type: sum
    sql: ${TABLE}.new_customers
    
  - dimension: click_date
    sql: ${TABLE}.click_date  

  sets:
    detail:
      - campaign
      - orders
      - gmv_fwd
      - voucher_cost
      - new_customers