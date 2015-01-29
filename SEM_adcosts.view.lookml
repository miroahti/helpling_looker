- view: sem_adcosts
  derived_table:
    sql: |
      SELECT
      campaign,
      keyword,
      report_date,
      ad_cost,
      ad_impressions
      FROM marketing.adcosts
      WHERE keyword_match_type <> '(not set)' and keyword <> '(content targeting)'

  fields:
  - measure: count
    type: count
    drill_fields: detail*

  - dimension: report_date
    sql: ${TABLE}.report_date
    
  - dimension: keyword
    sql: ${TABLE}.keyword    


  - dimension: campaign
    sql: ${TABLE}.campaign

  - measure: ad_cost
    type: sum
    sql: ${TABLE}.ad_cost

  - measure: ad_impressions
    type: sum
    sql: ${TABLE}.ad_impressions

  - dimension: date
    type: time
    sql: ${TABLE}.report_date
    timeframes: [date]

#Defining some measures for the report

  - measure: CPM
    type: number
    decimals: 2
    sql: ${ad_cost}  / (nullif(${ad_impressions},0)*1000)

  - measure: CTR
    type: number
    sql: (${visits_pivoted_keyword.total_visits}  / nullif(${ad_impressions},0))*100
    format: "%.f%"
    
  - measure: CPV
    type: number
    decimals: 2
    sql: ${ad_cost}  / nullif(${visits_pivoted_keyword.total_visits},0)

  - measure: CPO
    type: number
    sql: ${ad_cost}  / nullif(${attributed_orders_keyword.orders},0)
    
  - measure: CAC
    type: number
    sql: ${ad_cost}  / nullif(${attributed_orders_keyword.new_customers},0)

  sets:
    detail:
      - campaign
      - keyword
      - ad_cost
      - ad_impressions
