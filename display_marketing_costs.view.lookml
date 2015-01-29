- view: display_marketing_costs
  derived_table:
    sql: |
      SELECT
      dmc.campaign,
      dmc.content,
      dmc.provider,
      dmc.report_date,
      co.country_iso,
      dmc.costs
      FROM marketing.display_marketing_costs dmc
      left join dwh_mart.t_dim_countries co on co.country_id =dmc.dwh_country_id


  fields:
  - measure: count
    type: count
    drill_fields: detail*

  - dimension: campaign
    sql: ${TABLE}.campaign

  - dimension: content
    sql: ${TABLE}.content

  - dimension: ad_network
    sql: ${TABLE}.provider

  - dimension: report_date
    sql: ${TABLE}.report_date

  - dimension: country_iso
    sql: ${TABLE}.country_iso

  - measure: generic_costs
    type: sum
    sql: ${TABLE}.costs

  sets:
    detail:
      - campaign
      - content
      - provider
      - report_date
      - country_iso
      - costs
