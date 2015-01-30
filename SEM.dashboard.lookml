- dashboard: sem
  title: Sem
  layout: tile
  tile_size: 100

  filters:
  
    - name: date
      title: "Date"
      type: date_filter # see also "type: filter" and "type: number_filter"
      default_value: Last 30 Days
  
    - name: keyword
      title: "Keyword"
      type: suggest_filter
      explore: sem_adcosts
      dimension:  sem_adcosts.keyword
      
    - name: campaign
      title: "Campaign"
      type: suggest_filter
      explore: sem_adcosts
      dimension:  sem_adcosts.keyword 
  

  elements:
  
    - name: sem_orders
      title: SEM orders
      type: looker_line
      model: marketing
      explore: sem_adcosts
      dimensions: [sem_adcosts.report_date_date]
      measures: [attributed_orders_keyword.orders]
      sorts: [sem_adcosts.report_date_date]
      show_null_points: true
      listen: 
        date: sem_adcosts.report_date_date
        keyword: sem_adcosts.keyword
        campaign: sem_adcosts.campaign
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

    - name: sem_gmv
      title: SEM GMV
      type: looker_line
      model: marketing
      explore: sem_adcosts
      dimensions: [sem_adcosts.report_date_date]
      measures: [attributed_orders_keyword.gmv_fwd]
      listen: 
        date: sem_adcosts.report_date_date
        keyword: sem_adcosts.keyword
        campaign: sem_adcosts.campaign
      listen: 
        date: sem_adcosts.report_date_date
        keyword: sem_adcosts.keyword
        campaign: sem_adcosts.campaign
      sorts: [sem_adcosts.report_date_date]
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

  
  
  
    - name: sem_daily_overview
      title: SEM Daily Overview
      type: table
      model: marketing
      explore: sem_adcosts
      listen: 
        date: sem_adcosts.report_date_date
        keyword: sem_adcosts.keyword
        campaign: sem_adcosts.campaign
      dimensions: [sem_adcosts.report_date_date]
      measures: [sem_adcosts.impressions, visits_pivoted_keyword.total_visits, sem_adcosts.CTR, sem_adcosts.ad_costs,  sem_adcosts.CPV,
        attributed_orders_keyword.orders, sem_adcosts.CPO, sem_adcosts.CVR, attributed_orders_keyword.new_customers,
        sem_adcosts.CAC, attributed_orders_keyword.gmv_fwd]
      sorts: [sem_adcosts.report_date_date desc]
      width: 16
      total: true

    - name: sem_keyword_overview
      title: SEM Keyword Overview
      type: table
      model: marketing
      explore: sem_adcosts
      listen: 
        date: sem_adcosts.report_date_date
        keyword: sem_adcosts.keyword
        campaign: sem_adcosts.campaign
      dimensions: [sem_adcosts.keyword]
      measures: [sem_adcosts.impressions, visits_pivoted_keyword.total_visits, sem_adcosts.CTR, sem_adcosts.ad_costs, sem_adcosts.CPV,
        attributed_orders_keyword.orders, sem_adcosts.CPO, sem_adcosts.CVR, attributed_orders_keyword.new_customers,
        sem_adcosts.CAC, attributed_orders_keyword.gmv_fwd]
      sorts: [sem_adcosts.report_date_date desc]
      width: 16
      total: true

    - name: sem_campaign_overview
      title: SEM Campaign Overview
      type: table
      model: marketing
      explore: sem_adcosts
      listen: 
        date: sem_adcosts.report_date_date
        keyword: sem_adcosts.keyword
        campaign: sem_adcosts.campaign
      listen: 
        date: sem_adcosts.report_date_date
        keyword: sem_adcosts.keyword
        campaign: sem_adcosts.campaign
      dimensions: [sem_adcosts.campaign, sem_adcosts.keyword]
      measures: [sem_adcosts.impressions, visits_pivoted_keyword.total_visits, sem_adcosts.CTR, sem_adcosts.ad_costs, sem_adcosts.CPV,
        attributed_orders_keyword.orders, sem_adcosts.CPO, sem_adcosts.CVR, attributed_orders_keyword.new_customers,
        sem_adcosts.CAC, attributed_orders_keyword.gmv_fwd]
      sorts: [sem_adcosts.report_date_date desc]
      width: 16
      total: true

