- view: crm_voucher
  derived_table:
    sql: |
            SELECT
                    ba.order_date,
                    ba.dwh_country_id,
                    co.country_iso,
                    sum(ba.orders_attributed) as orders,
                    sum(o.booking_cost_price * ba.orders_attributed) as gmv_fwd,
                    sum(vc.total *  ba.orders_attributed) as voucher_cost,
                    sum(ba.first_order *ba.orders_attributed) as new_customers
                    
                  from marketing.bigquery_attribution ba
                  left join dwh_dl.orders o on o.reference = ba.order_id and o.dwh_country_id = ba.dwh_country_id
                  left join dwh_dl.orders_booking_cost_vouchers vc on vc.fk_orders_id = o._id and o.dwh_country_id = vc.dwh_country_id
                  left join dwh_dl.vouchers v on v.dwh_country_id = vc.dwh_country_id and vc.voucher = v._id
                  left join dwh_dl.vouchercampaigns vg on vg.dwh_country_id = v.dwh_country_id and v.campaign = vg._id
                  left join dwh_mart.t_dim_countries co on co.country_id =  ba.dwh_country_id
                  
                  where vg.departament = 'CRM'
                  
                  group by 1,2,3


  fields:
  - measure: count
    type: count
    drill_fields: detail*

  - dimension: order_date
    sql: ${TABLE}.order_date

  - measure: orders
    type: sum
    sql: ${TABLE}.orders

  - measure: gmv_fwd
    type: sum
    sql: ${TABLE}.gmv_fwd

  - measure: voucher_cost
    type: sum
    sql: ${TABLE}.voucher_cost

  - measure: new_customers
    type: number
    sql: ${TABLE}.new_customers

  sets:
    detail:
      - campaign
      - order_date
      - orders
      - gmv_fwd
      - voucher_cost
      - new_customers
