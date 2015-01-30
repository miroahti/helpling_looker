- view: sem_adcosts
  derived_table:
    sql: |
                  SELECT
                  campaign,
                  keyword,
                  report_date,
                  sum(ad_cost) as ad_costs,
                  sum(ad_impressions) as impressions
                  FROM marketing.adcosts
                  where campaign NOT LIKE '%DISPLAY%' and keyword <> '(remarketing/content targeting)'
                  group by 1,2,3

  fields:
  - measure: count
    type: count
    drill_fields: detail*

  - dimension: campaign
    sql: ${TABLE}.campaign

  - dimension: keyword
    sql: ${TABLE}.keyword

  - dimension: report_date
    type: time
    timeframes: [date, week, month, day_of_week]
    sql: ${TABLE}.report_date

  - dimension: ad_costs
    type: sum
    sql: ${TABLE}.ad_costs

  - measure: impressions
    type: sum
    sql: ${TABLE}.impressions

#Define some metrics

  - measure: total_costs
    type: number
    sql: ${ad_costs} #+ ${attributed_orders.voucher_cost}
    
#Metrics

  - measure: CTR
    type: number
    decimals: 2
    sql: (${visits_pivoted_keyword.total_visits}*1.0  /  nullif(${impressions},0))*100 
    format: "%.f%"

  - measure: CPV
    type: number
    decimals: 2
    sql:  ${total_costs}*1.0 / nullif(${visits_pivoted_keyword.total_visits},0)
    
  - measure: CVR
    type: number
    sql: (${attributed_orders_keyword.orders}*1.0  / nullif(${visits_pivoted_keyword.total_visits},0))*100 
    format: "%.f%"
    
  - measure: CPO
    type: number
    decimals: 2
    sql:  ${total_costs}*1.0 / nullif(${attributed_orders_keyword.orders},0)
  
  - measure: CAC
    type: number
    decimals: 2
    sql:  ${total_costs}*1.0 / nullif(${attributed_orders_keyword.new_customers},0)
        
    

  sets:
    detail:
      - campaign
      - keyword
      - report_date
      - ad_costs
      - impressions