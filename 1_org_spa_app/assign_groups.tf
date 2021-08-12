resource "okta_app_group_assignments" "example" {
  app_id   = okta_app_oauth.sample.id
  group {
    id = okta_group.group1.id
    priority = 1
  }
}
