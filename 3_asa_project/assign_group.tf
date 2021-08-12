resource "oktaasa_assign_group" "my-project-group-access" {
  project_name = oktaasa_project.my_project.project_name
  group_name = "ASA Access"
  server_access = true
  server_admin = true
  create_server_group = true
}
