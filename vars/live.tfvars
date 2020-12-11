external_zone = "selfservice.global.com"

# This is the list which maintains the delegated hosted zone namespaces
# We can get this list once you execute the base repo terraform modules
delegation = {
  "dev"     = ["ns-1954.awsdns-52.co.uk.", "ns-1198.awsdns-21.org.", "ns-868.awsdns-44.net.", "ns-441.awsdns-55.com."]
  "qa"      = ["ns-1639.awsdns-12.co.uk.", "ns-241.awsdns-30.com.", "ns-1298.awsdns-34.org.", "ns-655.awsdns-17.net."]
  "preprod" = ["ns-679.awsdns-20.net.", "ns-1494.awsdns-58.org.", "ns-1789.awsdns-31.co.uk.", "ns-171.awsdns-21.com."]
  "prod"    = ["ns-1458.awsdns-54.org.", "ns-118.awsdns-14.com.", "ns-812.awsdns-37.net.", "ns-1835.awsdns-37.co.uk."]
}

production_account = true

developers = [
]
