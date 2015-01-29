- view: visits_pivoted_keyword
  derived_table:
    sql: |
      SELECT
        campaign,
        report_date,
        keyword,
        
        SUM(CASE user_type WHEN 'New Visitor' THEN visitor_cnt END) AS "new_visits",
        SUM(CASE user_type WHEN 'Returning Visitor' THEN visitor_cnt END) AS "returning_visits"
      
        from marketing.visits
        group by 1, 2,3

  fields:
  - measure: count
    type: count
    drill_fields: detail*

  - dimension: campaign
    sql: ${TABLE}.campaign

  - dimension: report_date
    sql: ${TABLE}.report_date
  
  - dimension: keyword
    sql: ${TABLE}.keyword
  

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
      - report_date
      - new_visits
      - returning_visits
