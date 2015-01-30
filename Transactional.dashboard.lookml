- dashboard: transactional
  title: Transactional
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
      dimension: interface_reports.date_sent_date
      
    - name: alias
      title: "Alias"
      type: suggest_filter
      explore: crm_daily_reports
      dimension: interface_reports.interface_alias

  elements:
  
    - name: transactional_ctr
      title: Transactional CTR
      type: looker_line
      model: marketing
      explore: interface_reports
      dimensions: [interface_reports.date_sent_date]
      measures: [interface_reports.UCTR]
      listen: 
        date: interface_reports.date_sent
        country: interface_reports.profile_name
        alias: interface_reports.interface_alias
      sorts: [interface_reports.date_sent_date desc]
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
      
    - name: transactional_orders
      title: Transactional Orders
      type: looker_line
      model: marketing
      explore: interface_reports
      dimensions: [interface_reports.date_sent_date]
      measures: [attributed_orders.orders]
      listen: 
        date: interface_reports.date_sent
        country: interface_reports.profile_name
        alias: interface_reports.interface_alias  
      sorts: [interface_reports.date_sent_date desc]
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

    - name: transactional_campaigns
      title: Transactional Campaigns
      type: table
      model: marketing
      explore: interface_reports
      dimensions: [interface_reports.profile_name, interface_reports.interface_alias]
      measures: [interface_reports.emails_sent, interface_reports.unique_open_rate, interface_reports.UCTR,
        interface_reports.UCTOR, interface_reports.SB_Rate, interface_reports.HB_Rate,
        visits_pivoted.total_visits, attributed_orders.orders, attributed_orders.new_customers,
        attributed_orders.gmv_fwd]
      listen: 
        date: interface_reports.date_sent
        country: interface_reports.profile_name
        alias: interface_reports.interface_alias  
      sorts: [interface_reports.profile_name]
      width: 14
      
    - name: transactional_daily_overview
      title: Transactional Daily Overview
      type: table
      model: marketing
      explore: interface_reports
      dimensions: [interface_reports.date_sent_date]
      measures: [interface_reports.emails_sent, interface_reports.unique_open_rate, interface_reports.UCTR,
        interface_reports.UCTOR, interface_reports.SB_Rate, interface_reports.HB_Rate,
        visits_pivoted.total_visits, attributed_orders.orders, attributed_orders.new_customers,
        attributed_orders.gmv_fwd]
      listen: 
        date: interface_reports.date_sent
        country: interface_reports.profile_name
        alias: interface_reports.interface_alias  
      sorts: [interface_reports.date_sent_date desc]
      width: 14      