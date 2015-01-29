- connection: dwh

- scoping: true                  # for backward compatibility
- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- explore: crm_daily_reports
  joins:
    - join: visits_pivoted
      sql_on:  ${crm_daily_reports.campaign_name}::varchar = ${visits_pivoted.campaign}::varchar and ${crm_daily_reports.date_sent_date} = ${visits_pivoted.report_date}
      relationship: one_to_one
    - join: attributed_orders
      sql_on:  ${crm_daily_reports.campaign_name}::varchar = ${attributed_orders.campaign}::varchar and  ${crm_daily_reports.date_sent_date} = DATE(${attributed_orders.order_date})
      relationship: one_to_one
      
- explore: interface_reports      
  joins:
    - join: visits_pivoted
      sql_on:  ${interface_reports.interface_id}::varchar = ${visits_pivoted.campaign}::varchar and ${interface_reports.date_sent_date} = ${visits_pivoted.report_date}
      relationship: one_to_one
    - join: attributed_orders
      sql_on:  ${interface_reports.interface_id}::varchar = ${attributed_orders.campaign}::varchar and  ${interface_reports.date_sent_date} = DATE(${attributed_orders.order_date})
      relationship: one_to_one
      
- explore: display_marketing_costs
  joins:
    - join: visits_pivoted
      sql_on:  ${display_marketing_costs.campaign}::varchar = ${visits_pivoted.campaign}::varchar and ${display_marketing_costs.report_date} = ${visits_pivoted.report_date}
      relationship: one_to_one
    - join: attributed_orders
      sql_on:  ${display_marketing_costs.campaign}::varchar = ${attributed_orders.campaign}::varchar and  ${display_marketing_costs.report_date} = DATE(${attributed_orders.order_date}) and  ${display_marketing_costs.country_iso} = ${attributed_orders.country_iso}
      relationship: one_to_one 
      
- explore: sem_adcosts
  joins:   
    - join: attributed_orders_keyword
      sql_on:  ${sem_adcosts.campaign}::varchar = ${attributed_orders_keyword.campaign}::varchar and  ${sem_adcosts.report_date} = DATE(${attributed_orders_keyword.order_date}) and  ${sem_adcosts.keyword} = ${attributed_orders_keyword.keyword}
      relationship: one_to_one 
    - join: visits_pivoted_keyword
      sql_on: ${sem_adcosts.campaign}::varchar = ${visits_pivoted_keyword.campaign}::varchar and  ${sem_adcosts.report_date} = DATE(${visits_pivoted_keyword.report_date}) and  ${sem_adcosts.keyword} = ${visits_pivoted_keyword.keyword}
      relationship: one_to_one
      
