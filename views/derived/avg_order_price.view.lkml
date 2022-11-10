# If necessary, uncomment the line below to include explore_source.
# include: "order_items.explore.lkml"

view: avg_order_price {
  derived_table: {
    explore_source: order_items {
      column: created_year {}
      column: total_sale_price {}
      column: order_id {}
    }
  }
  dimension: created_year {
    description: ""
    type: date_year
  }
  dimension: total_sale_price {
    description: ""
    value_format: "$0"
    type: number
  }
  dimension: order_id {
    description: ""
    type: number
  }

  measure: avg_total_sale {
    type: average
    sql: ${total_sale_price} ;;
    value_format_name: usd_0
  }
}
