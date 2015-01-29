- view: attributed_orders_keyword
  derived_table:
    sql: |
      SELECT
                    ba.keyword,
                    ba.click_date,
                    ba.source,
                    ba.campaign,
                    co.country_iso,
                    sum(ba.orders_attributed) as orders,
                    sum(o.booking_cost_price * ba.orders_attributed) as gmv_fwd,
                    sum(ba.first_order *ba.orders_attributed) as new_customers
                    
                  from marketing.bigquery_attribution ba
                  left join dwh_dl.orders o on o.reference = ba.order_id and o.dwh_country_id = ba.dwh_country_id
                  left join dwh_dl.orders_booking_cost_vouchers vc on vc.fk_orders_id = o._id and o.dwh_country_id = vc.dwh_country_id
                  left join dwh_mart.t_dim_countries co on co.country_id =  ba.dwh_country_id 
                  
                  where co.country_iso <> ''
                  group by 1,2,3,4,5 
                
                  
                  

  fields:
  - measure: count
    type: count
    drill_fields: detail*

  - dimension: keyword
    sql: ${TABLE}.keyword

  - dimension: order_date
    sql: ${TABLE}.click_date

  - dimension: source
    sql: ${TABLE}.source

  - dimension: campaign
    sql: ${TABLE}.campaign
    
  - dimension: country_iso
    sql: ${TABLE}.country_iso

  - measure: orders
    decimals: 2
    type: sum
    sql: ${TABLE}.orders

  - measure: gmv_fwd
    type: sum
    sql: ${TABLE}.gmv_fwd /100

  - measure: new_customers
    decimals: 2
    type: sum
    sql: ${TABLE}.new_customers

  sets:
    detail:
      - keyword
      - order_date
      - source
      - campaign
      - orders
      - gmv_fwd
      - voucher_cost
      - new_customers

