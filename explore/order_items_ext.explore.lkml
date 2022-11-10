include: "/views/refined/*.view.lkml"
include: "/views/extends/*.view.lkml"
include: "/explore/order_items.explore.lkml"


explore: order_extended {
  extends: [order_items]

  join: inventory_items {
    type: left_outer
    sql_on: ${order_extended.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
}

# required_access_grants: [financial_data]
}
