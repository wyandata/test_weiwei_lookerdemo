include: "/views/raw/inventory_items.view.lkml"


view: +inventory_items {


  dimension: cost_CAD {
    sql: ${cost} ;;
    value_format_name: usd_0
    link: {
      label: "Convert to CAD"
      url: "https://www.xe.com/currencyconverter/convert/?Amount={{ value }}&From=USD&To=CAD"
      icon_url: "https://www.google.com/favicon.ico"
    }
  }



    dimension: cost_USD {
      sql: ${cost} ;;
      html: <a href="https://www.xe.com/currencyconverter/convert/?Amount={{value}}}}&From=CAD&To=USD">Convert to USD</a> ;;
    }

    dimension: cost_of_total {
      sql: ${cost} ;;
      html: {{ total_cost._rendered_value }} Total Inventory ;;
    }

    dimension: cost {
      value_format_name: usd_0
    }


    measure: total_cost {
      type: sum
      value_format_name: usd_0
      sql: ${cost} ;;
    }

    measure: average_cost {
      type: average
      sql: ${cost} ;;
    }


    dimension: is_luxury {
      value_format_name: usd_0
      type: number
      sql: ${cost} ;;
      html:
      {% if value > 50 %}
      <font color="darkgreen">{{ rendered_value }} is luxury</font>
      {% endif %} ;;
    }

    dimension: not_luxury {
      value_format_name: usd_0
      type: number
      sql: ${cost} ;;
      html:
      {% unless value > 50 %}
      <font color="red">{{ rendered_value }} is not luxury</font>
      {% endunless %} ;;
    }


    dimension: luxury_identifier {
      type: number
      sql: ${product_category};;
      html:
          {% if value == 'Fashion Hoodies & Sweatshirts' %}
          <font color="teal">Luxury</font>
          {% elsif value == 'Outerwear & Coats' %}
          <font color="darkgreen">More luxury</font>
          {% elsif value == 'Dresses' %}
          <font color="gold">Much more luxury</font>
          {% else %}
          <font color="darkred">Not luxury</font>
          {% endif %} ;;
    }

    dimension: luxury_identifier_switch {
      type: number
      sql: ${product_category};;
      html:
          {% case value %}
             {% when 'Fashion Hoodies & Sweatshirts' %}
          <font color="teal">Luxury</font>
          {% when 'Outerwear & Coats' %}
          <font color="darkgreen">More luxury</font>
          {% when 'Dresses' %}
          <font color="gold">Much more luxury</font>
          {% else %}
          <font color="darkred">Not luxury</font>
          {% endcase %} ;;
    }




    dimension: switch_boujee {}



    parameter: date_granularity {
      type: string
      allowed_value: { value: "Day" }
      allowed_value: { value: "Month" }
      allowed_value: { value: "Quarter" }
      allowed_value: { value: "Year" }
    }


    dimension: date {
      type: string
      label_from_parameter: date_granularity
      sql:
        CASE
          WHEN {% parameter date_granularity %} = 'Day' THEN ${created_date}
          WHEN {% parameter date_granularity %} = 'Month' THEN ${created_month}
          WHEN {% parameter date_granularity %} = 'Quarter' THEN ${created_quarter}
          WHEN {% parameter date_granularity %} = 'Year' THEN ${created_year}
          ELSE NULL
        END ;;
    }

    #change parameter to type: unquoted
    dimension: date_if {
      type: string
      label_from_parameter: date_granularity
      sql:
          {% if date_granularity._parameter_value == 'Month' %}
            ${created_month}
          {% elsif date_granularity._parameter_value == 'Quarter' %}
            ${created_quarter}
          {% elsif date_granularity._parameter_value == 'Year' %}
            ${created_year}
          {% else %}
            ${created_date}
          {% endif %};;
    }



}
