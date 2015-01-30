#This is for temporary use

- view: visits_for_display
  derived_table:
    sql: |
      SELECT
              campaign,
              source,
              report_date,
              SUM(CASE user_type WHEN 'New Visitor' THEN sessions END) AS "new_visits",
              SUM(CASE user_type WHEN 'Returning Visitor' THEN sessions END) AS "returning_visits"
            
              from marketing.visits
              where source = 'Zanox' or source = 'criteo' or source = 'yahoo'
              group by 1, 2, 3 

  fields:
  - measure: count
    type: count
    drill_fields: detail*

  - dimension: campaign
    sql: ${TABLE}.campaign

  - dimension: source
    sql: ${TABLE}.source

  - dimension: report_date
    sql: ${TABLE}.report_date
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.report_date

  - measure: new_visits
    type: sum
    sql: ${TABLE}.new_visits

  - measure: returning_visits
    type: sum
    sql: ${TABLE}.returning_visits

  - measure: total_visits
    type: number
    sql: ${new_visits} + ${returning_visits}

  sets:
    detail:
      - campaign
      - source
      - report_date
      - new_visits
      - returning_visits
