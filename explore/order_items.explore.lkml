include: "/views/refined/*.view.lkml"
include: "/views/extends/*.view.lkml"


explore: order_items {
  persist_with: firstgroup


  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

}
