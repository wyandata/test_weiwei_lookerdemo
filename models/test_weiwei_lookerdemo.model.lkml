connection: "looker_partner_demo"

# include all the views
include: "/explore/order_items.explore.lkml"
include: "/explore/order_items_ext.explore.lkml"
include: "/explore/avg_order_price.explore.lkml"

datagroup: firstgroup {
  max_cache_age: "0 seconds"
}

# access_grant: financial_data {
#   user_attribute: department
#   allowed_values: ["Finance", "abc"]

# }
