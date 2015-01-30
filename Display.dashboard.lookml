- dashboard: display
  title: Display
  layout: tile
  tile_size: 100

  filters:

    - name: date
      title: "Date"
      type: date_filter # see also "type: filter" and "type: number_filter"
      default_value: Last 30 Days

    - name: campaign
      title: "Campaign"
      type: suggest_filter
      explore: crm_daily_reports
      dimension:  display_costs_google.campaign
  
    - name: source
      title: "Source"
      type: suggest_filter
      explore: crm_daily_reports
      dimension: visits_for_display.source
  


  elements:
  
      
    - name: visits_chart
      title: Visits
      type: looker_line
      model: marketing
      listen:
        campaign: display_costs_google.campaign
        date: display_costs_google.report_date_date
      explore: display_costs_google
      dimensions: [display_costs_google.report_date_date]
      measures: [visits_pivoted.total_visits]
      sorts: [display_costs_google.report_date]
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
      
    - name: display_orders
      title: Orders
      type: looker_line
      model: marketing
      explore: display_costs_google
      dimensions: [display_costs_google.report_date_date]
      measures: [attributed_orders.orders]
      listen:
        campaign: display_costs_google.campaign
        date: display_costs_google.report_date_date
      sorts: [display_costs_google.report_date, display_costs_google.report_date_date desc]
      limit: 500
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
  
  

    - name: display_campaigns
      title: Display Campaigns
      type: table
      model: marketing
      listen:
        campaign: display_costs_google.campaign
        date: display_costs_google.report_date_date
      explore: display_costs_google
      dimensions: [display_costs_google.campaign]
      measures: [display_costs_google.impressions, visits_pivoted.total_visits, display_costs_google.CTR, display_costs_google.ad_costs,
        display_costs_google.CPV, attributed_orders.orders, display_costs_google.CPO, display_costs_google.CVR,
        attributed_orders.new_customers, display_costs_google.CAC, attributed_orders.gmv_fwd]
      sorts: [display_costs_google.campaign]
      width: 16
    
    - name: display_daily_overview
      title: Display Overview
      type: table
      model: marketing
      listen:
        campaign: display_costs_google.campaign
        date: display_costs_google.report_date_date
      explore: display_costs_google
      dimensions: [display_costs_google.report_date_date]
      measures: [display_costs_google.impressions, visits_pivoted.total_visits, display_costs_google.CTR, display_costs_google.ad_costs,
        display_costs_google.CPV, attributed_orders.orders, display_costs_google.CPO, display_costs_google.CVR,
        attributed_orders.new_customers, display_costs_google.CAC, attributed_orders.gmv_fwd]
      sorts: [ddisplay_costs_google.report_date]
      width: 16
      
    - name: temp_all_campaigns
      title: Rough Information on All Campaigns
      type: table
      model: marketing
      explore: visits_for_display
      listen:
        campaign: display_costs_google.campaign
        date: display_costs_google.report_date_date
        source: visits_for_display.source
      dimensions: [visits_for_display.campaign, visits_for_display.source]
      measures: [visits_for_display.total_visits, attributed_orders.orders, attributed_orders.new_customers,
        attributed_orders.gmv_fwd]
      sorts: [visits_for_display.campaign]
      width: 16

      
