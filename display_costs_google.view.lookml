
- view: display_costs_google
  derived_table:
    sql: |
            SELECT
            campaign,
            report_date,
            sum(ad_cost) as ad_costs,
            sum(ad_impressions) as impressions
            FROM marketing.adcosts
            WHERE campaign LIKE '%DISPLAY%'
            group by 1,2

  fields:
  - measure: count
    type: count
    drill_fields: detail*

  - dimension: campaign
    sql: ${TABLE}.campaign

  - dimension: report_date
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.report_date

  - measure: ad_costs
    type: sum
    sql: ${TABLE}.ad_costs

  - measure: impressions
    type: sum
    sql: ${TABLE}.impressions
    
  - measure: total_costs
    type: number
    sql: ${ad_costs}
    
#Some ratios

  - measure: CTR
    type: number
    decimals: 2
    sql: (${visits_pivoted.total_visits} /  nullif(${impressions},0))*100 


  - measure: CPV
    type: number
    decimals: 2
    sql:  ${total_costs}*1.0 / nullif(${visits_pivoted.total_visits},0)
    
  - measure: CPO
    type: number
    decimals: 2
    sql:  ${total_costs}*1.0 / nullif(${attributed_orders.orders},0)
  
  - measure: CAC
    type: number
    decimals: 2
    sql:  ${total_costs}*1.0 / nullif(${attributed_orders.new_customers},0)
    
  - measure: cost_to_gmv
    type: number
    decimals: 2
    sql:  ${total_costs}*1.0 / nullif(${attributed_orders.gmv_fwd},0)

  sets:
    detail:
      - campaign
      - report_date
      - ad_costs
      - impressions

