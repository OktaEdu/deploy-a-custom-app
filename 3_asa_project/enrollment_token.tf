resource "oktaasa_enrollment_token" "etoken" {
  project_name = oktaasa_project.my_project.project_name
  description = "Enrollment Token for My Spa App Servers"
}
