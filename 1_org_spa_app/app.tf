resource "okta_app_oauth" "sample" {
  label                      = "My Vue SPA"
  type                       = "browser"
  grant_types                = ["authorization_code"]
  redirect_uris              = ["https://example.com/login/callback"]
  consent_method             = "REQUIRED"
  token_endpoint_auth_method = "none"
  response_types             = ["code"]
  post_logout_redirect_uris  = ["https://example.com"]
  lifecycle {
     ignore_changes = [groups]
  }
}
