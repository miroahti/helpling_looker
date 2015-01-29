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
  


  elements:

    - name: display_campaigns
      title: Display Campaigns
      type: table
      model: marketing
      listen:
        campaign: display_costs_google.campaign
        date: display_costs_google.report_date_date
      explore: display_costs_google
      dimensions: [display_costs_google.campaign]
      measures: [display_costs_google.impressions, visits_pivoted.total_visits, display_costs_google.ad_costs,
        display_costs_google.CPV, attributed_orders.orders, display_costs_google.CPO,
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
      measures: [display_costs_google.impressions, visits_pivoted.total_visits, display_costs_google.ad_costs,
        display_costs_google.CPV, attributed_orders.orders, display_costs_google.CPO,
        attributed_orders.new_customers, display_costs_google.CAC, attributed_orders.gmv_fwd]
      sorts: [ddisplay_costs_google.report_date]
      width: 16
      
      
    - name: visits_chart
      title: Visits Chart
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
