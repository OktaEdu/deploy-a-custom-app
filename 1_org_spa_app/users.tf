resource "okta_user" "okta_user1" {
  email = "spa.user1@oktaice.com"
  login = "spa.user1@oktaice.com"
  first_name = "Spa"
  last_name = "User1"
  password = "Tra!nme4321"
  recovery_question = "What is the food you least liked as a child?"
  recovery_answer = "Liver"
}
resource "okta_user" "okta_user2" {
  email = "spa.user2@oktaice.com"
  login = "spa.user2@oktaice.com"
  first_name = "Spa"
  last_name = "User2"
  password = "Tra!nme4321"
  recovery_question = "What is the food you least liked as a child?"
  recovery_answer = "Liver"
}
