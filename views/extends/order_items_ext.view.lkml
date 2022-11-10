include: "/views/raw/order_items.view.lkml"



view: order_extended {
  extends: [order_items]

  measure: additional_measure {
    type: count
  }

}
