- dashboard: crm
  title: Crm
  layout: tile
  tile_size: 100

  filters:
  
    - name: date
      title: "Date"
      type: date_filter # see also "type: filter" and "type: number_filter"
      default_value: Last 30 Days
    
    - name: country
      title: "Country"
      type: suggest_filter
      explore: crm_daily_reports
      dimension:  crm_daily_reports.profile_name
      
    - name: campaign
      title: "Campaign"
      type: suggest_filter
      explore: crm_daily_reports
      dimension:  crm_daily_reports.campaign_name  
  
  elements:
    - name: crm_ctr_visualization
      title: CRM CTR
      type: looker_line
      model: marketing
      explore: crm_daily_reports
      dimensions: [crm_daily_reports.date_sent_date]
      measures: [crm_daily_reports.UCTR]
      listen:
        date: crm_daily_reports.date_sent_date
        country: crm_daily_reports.profile_name
        campaign: crm_daily_reports.campaign_name
      sorts: [crm_daily_reports.date_sent_date desc]
      show_null_points: true
      stacking: ''
      show_value_labels: false
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      point_style: none
      interpolation: linear
    
    - name: crm_orders
      title: CRM Orders
      type: looker_line
      model: marketing
      explore: crm_daily_reports
      dimensions: [crm_daily_reports.date_sent_date]
      measures: [attributed_orders.orders]
      listen:
        date: crm_daily_reports.date_sent_date  
        country: crm_daily_reports.profile_name
        campaign: crm_daily_reports.campaign_name
      sorts: [crm_daily_reports.date_sent_date desc]
      stacking: ''
      show_value_labels: false
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: true
      show_y_axis_labels: true
      show_y_axis_ticks: true
      show_x_axis_label: true
      show_x_axis_ticks: true
      x_axis_scale: auto
      show_null_points: true
      show_null_labels: false
      point_style: none
      interpolation: linear
      
    - name: crm_campaigns
      title: CRM Campaigns
      type: table
      model: marketing
      explore: crm_daily_reports
      width: 14
      listen:
        date: crm_daily_reports.date_sent_date 
        country: crm_daily_reports.profile_name
        campaign: crm_daily_reports.campaign_name
      dimensions: [crm_daily_reports.profile_name, crm_daily_reports.campaign_name]
      measures: [crm_daily_reports.emails_sent, crm_daily_reports.open_rate, crm_daily_reports.UCTR,
        crm_daily_reports.UCTOR, crm_daily_reports.SB_Rate, crm_daily_reports.HB_Rate,
        crm_daily_reports.Unsubscribed_Rate, crm_daily_reports.generic_costs, visits_pivoted.total_visits,
        attributed_orders.orders, crm_daily_reports.CVR, attributed_orders.new_customers, attributed_orders.gmv_fwd]
      sorts: [crm_daily_reports.profile_name]
  
    - name: crm_daily_overview
      title: CRM Daily Overview
      type: table
      model: marketing
      explore: crm_daily_reports
      width: 14
      listen:
        date: crm_daily_reports.date_sent_date 
        country: crm_daily_reports.profile_name
        campaign: crm_daily_reports.campaign_name
      dimensions: [crm_daily_reports.date_sent_date]
      measures: [crm_daily_reports.emails_sent, crm_daily_reports.open_rate, crm_daily_reports.UCTR,
        crm_daily_reports.UCTOR, crm_daily_reports.SB_Rate, crm_daily_reports.HB_Rate,
        crm_daily_reports.Unsubscribed_Rate, crm_daily_reports.generic_costs, visits_pivoted.total_visits,
        attributed_orders.orders, crm_daily_reports.CVR, attributed_orders.new_customers, attributed_orders.gmv_fwd]
      sorts: [crm_daily_reports.profile_name]  
