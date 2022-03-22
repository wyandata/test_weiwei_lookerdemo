include: "/views/raw/order_items.view.lkml"

view: +order_items {

  parameter: date_granularity {
    type: string
    allowed_value: { value: "Day" }
    allowed_value: { value: "Month" }
    allowed_value: { value: "Quarter" }
    allowed_value: { value: "Year" }
  }

  dimension: date_liquid {
    type: string
    label_from_parameter: date_granularity
    sql:
    {% if date_granularity._parameter_value == 'Day' %}
      ${created_date}
    {% elsif date_granularity._parameter_value == 'Month' %}
      ${created_month}
    {% elsif date_granularity._parameter_value == 'Quarter' %}
      ${created_quarter}
    {% else %}
      ${created_year}
    {% endif %};;
  }



  dimension: date {
    type: string
    label_from_parameter: date_granularity
    sql:
        CASE
          WHEN {% parameter date_granularity %} = 'Day' THEN CAST(${created_date} AS string)
          WHEN {% parameter date_granularity %} = 'Month' THEN CAST(${created_month} AS string)
          WHEN {% parameter date_granularity %} = 'Quarter' THEN CAST(${created_quarter} AS string)
          WHEN {% parameter date_granularity %} = 'Year' THEN CAST(${created_year} AS string)
        ELSE NULL
        END ;;
  }


  }
