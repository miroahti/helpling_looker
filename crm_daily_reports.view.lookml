- view: crm_daily_reports
  derived_table:
    sql: |
      SELECT
      *
      FROM marketing.daily_reports
      where report_hour = 23 and report_type = 1
      
  fields:
  - dimension: id
    primary_key: true
    sql: ${TABLE}.id

  - dimension: campaign_id
    type: string
    sql: ${TABLE}.campaign_id

  - dimension: campaign_name
    sql: ${TABLE}.campaign_name

  - dimension_group: created
    type: time
    hidden: true
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at

  - dimension_group: date_sent_end
    type: time
    hidden: true
    timeframes: [time, date, week, month]
    sql: ${TABLE}.date_sent_end

  - dimension: date_sent_error_msg
    hidden: true
    sql: ${TABLE}.date_sent_error_msg

  - dimension_group: date_sent
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.date_sent_start

  - dimension_group: date_sent_target
    type: time
    hidden: true
    timeframes: [time, date, week, month]
    sql: ${TABLE}.date_sent_target


  - dimension: email_sent_mb
    type: number
    hidden: true
    sql: ${TABLE}.email_sent_mb

  - dimension: email_target_cnt
    type: number
    hidden: true
    sql: ${TABLE}.email_target_cnt

  - dimension: file_name
    hidden: true
    sql: ${TABLE}.file_name

  - dimension: gmx_compl_cnt
    type: int
    hidden: true
    sql: ${TABLE}.gmx_compl_cnt

  - dimension: hotmail_compl_cnt
    type: int
    hidden: true
    sql: ${TABLE}.hotmail_compl_cnt

  - dimension: mailing_id
    type: int
    hidden: true
    sql: ${TABLE}.mailing_id

  - dimension: mailing_name
    hidden: true
    sql: ${TABLE}.mailing_name

  - dimension: mediumbounce_cnt
    type: int
    hidden: true
    sql: ${TABLE}.mediumbounce_cnt

  - dimension: profile_id
    type: int
    hidden: true
    sql: ${TABLE}.profile_id

  - dimension: report_hour
    type: int
    sql: ${TABLE}.report_hour

  - dimension: report_type
    type: int
    sql: ${TABLE}.report_type

  - dimension: subject_line
    hidden: true
    sql: ${TABLE}.subject_line

  - dimension_group: updated
    type: time
    hidden: true
    timeframes: [time, date, week, month]
    sql: ${TABLE}.updated_at

  - measure: count
    hidden: true
    type: count
    drill_fields: [id, profile_name, mailing_name, campaign_name, file_name]
    
#Find the country
  
  - dimension: profile_name
    sql: LEFT(${TABLE}.profile_name,2)

    
#Define relevant sums    

  - measure: unique_clicks
    type: sum
    sql: ${TABLE}.click_unique_cnt

  - measure: clicks
    type: sum
    sql: ${TABLE}.click_cnt

  - measure: open_html_cnt
    type: sum
    hidden: true
    sql: ${TABLE}.open_html_cnt
  
  - measure: open_txt_cnt
    type: sum
    hidden: true
    sql: ${TABLE}.open_txt_cnt

  - measure: opens
    type: sum
    sql: ${TABLE}.open_txt_cnt + ${TABLE}.open_html_cnt
    
  - measure: Softbounces
    type: sum
    sql: ${TABLE}.softbounce_cnt
    
  - measure: Hardbounces
    type: sum
    sql: ${TABLE}.hardbounce_cnt
    
  - measure: unsubscribed
    type: sum
    sql: ${TABLE}.unsubscribe_cnt
    
  - dimension: emails_sent
    type: sum
    sql: ${TABLE}.email_sent_cnt
    
  - dimension: emails_sent_successfully
    type: sum
    sql: ${TABLE}.email_sent_cnt  - ${TABLE}.hardbounce_cnt - ${TABLE}.softbounce_cnt   
    
#Relevant ratios for the report

  - measure: open_rate
    type: number
    sql: ((${opens})*1.0 / nullif(${emails_sent_successfully},0))*100
    format: "%.f%"   

  - measure: CTR
    type: number
    sql: ((${clicks})*1.0  / nullif(${emails_sent_successfully},0))*100
    format: "%.f%"
      
  - measure: CTOR
    type: number
    sql: ((${clicks})*1.0  / nullif(${opens},0))*100
    format: "%.f%"
    
  - measure: UCTR
    type: number
    sql: ((${unique_clicks})*1.0  / nullif(${emails_sent_successfully},0))*100
    format: "%.f%"
    
  - measure: UCTOR
    type: number
    sql: ((${unique_clicks})*1.0  / nullif(${opens},0))*100
    format: "%.f%"
    
  - measure: HB_Rate
    type: number
    sql: ((${Hardbounces})*1.0  / nullif(${emails_sent},0))*100
    format: "%.2f%"
    
  - measure: SB_Rate
    type: number
    decimals: 2
    sql: ((${Softbounces})*1.0  / nullif(${emails_sent},0))*100    
    format: "%.2f%"
    
  - measure: Unsubscribed_Rate
    type: number
    decimals: 2
    sql: ((${unsubscribed})*1.0  / nullif(${emails_sent_successfully},0))*100  
    format: "%.2f%"

#With some uncertainty

  - measure: generic_costs
    type: number
    decimals: 2
    sql: ${emails_sent} * 0.00032
    
  - measure: total_costs
    type: number
    sql: ${generic_costs} #+ ${attributed_orders.voucher_cost}
    
#Metrics

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

#Unnecessary fields    
    
  - dimension: yahoo_compl_cnt
    type: int
    hidden: true
    sql: ${TABLE}.yahoo_compl_cnt
    
  - dimension: aol_compl_cnt
    type: int
    hidden: true
    sql: ${TABLE}.aol_compl_cnt
    
    