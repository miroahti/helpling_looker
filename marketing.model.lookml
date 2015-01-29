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
      
- explore: display_costs_google
  joins:
    - join: visits_pivoted
      sql_on:  ${display_costs_google.campaign}::varchar = ${visits_pivoted.campaign}::varchar and ${display_costs_google.report_date_date} = ${visits_pivoted.report_date}
      relationship: one_to_one  
    - join: attributed_orders
      sql_on:  ${display_costs_google.campaign}::varchar = ${attributed_orders.campaign}::varchar and ${display_costs_google.report_date_date} = DATE(${attributed_orders.order_date})
      relationship: one_to_one  