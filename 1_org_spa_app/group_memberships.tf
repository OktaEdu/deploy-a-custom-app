resource "okta_user_group_memberships" "user1" {
  user_id = okta_user.okta_user1.id
  groups = [okta_group.group1.id]
}
resource "okta_user_group_memberships" "user2" {
  user_id = okta_user.okta_user2.id
  groups = [okta_group.group1.id]
}

