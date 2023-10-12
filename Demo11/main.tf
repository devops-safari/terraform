resource "godaddy_domain_record" "main" {
  domain = "anasbo.com"

  record {
    name = "@"
    data = "terraform-is-the-best"
    type = "TXT"
  }
}
