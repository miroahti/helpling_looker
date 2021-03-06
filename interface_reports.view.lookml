- view: interface_reports
  derived_table:
    sql: |
      select
      profile_id,
      profile_name,
      interface_id,
      interface_alias,
      date_sent,
      sent_cnt,
      open_unique_cnt,
      click_unique_cnt,
      hardbounce_cnt,
      softbounce_cnt
      from marketing.interface_reports
      

  fields:
  - measure: count
    type: count
    drill_fields: detail*

  - dimension: profile_id
    type: number
    sql: ${TABLE}.profile_id

  - dimension: interface_id
    type: number
    sql: ${TABLE}.interface_id

  - dimension: interface_alias
    sql: ${TABLE}.interface_alias
    
  - dimension: profile_name
    sql: LEFT(${TABLE}.profile_name,2)

  - dimension: date_sent
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.date_sent

  - measure: emails_sent
    type: sum
    sql: ${TABLE}.sent_cnt

  - measure: unique_opens
    type: sum
    sql: ${TABLE}.open_unique_cnt

  - measure: unique_clicks
    type: sum
    sql: ${TABLE}.click_unique_cnt

  - measure: hardbounces
    type: sum
    sql: ${TABLE}.hardbounce_cnt

  - measure: softbounces
    type: sum
    sql: ${TABLE}.softbounce_cnt

  
#Define some measures

  - measure: emails_sent_successfully
    type: number
    sql: ${emails_sent} - ${hardbounces} - ${softbounces}
    
#Define some ratios

  - measure: unique_open_rate
    type: number
    sql: ((${unique_opens})*1.0 / nullif(${emails_sent_successfully},0))*100
    format: "%.f%"   
    
  - measure: UCTR
    type: number
    sql: ((${unique_clicks})*1.0  / nullif(${emails_sent_successfully},0))*100
    format: "%.f%"
    
  - measure: UCTOR
    type: number
    sql: ((${unique_clicks})*1.0  / nullif(${unique_opens},0))*100
    format: "%.f%"
    
  - measure: HB_Rate
    type: number
    sql: ((${hardbounces})*1.0  / nullif(${emails_sent},0))*100
    format: "%.2f%"
    
  - measure: SB_Rate
    type: number
    decimals: 2
    sql: ((${softbounces})*1.0  / nullif(${emails_sent},0))*100   
    format: "%.2f%"

  - measure: CVR
    type: number
    sql: (${attributed_orders.orders}*1.0  / nullif(${visits_pivoted.total_visits},0))*100 
    format: "%.f%"  

  sets:
    detail:
      - profile_id
      - profile_name
      - interface_id
      - interface_alias
      - date_sent
      - sent_cnt
      - open_unique_cnt
      - click_unique_cnt
      - hardbounce_cnt
      - softbounce_cnt
