data "template_file" "sftd-ubuntu-userdata" {
  template = "${file("${path.module}/userdata-scripts/ubuntu-userdata-sftd.sh")}"

  vars = {
    sftd_version     = "${var.sftd_version}"
    enrollment_token = "${var.enrollment_token}"
    org_url = "${var.org_url}"
    clientid = "${var.clientid}"
    github_repo = "${var.github_repo}"
  }
}
