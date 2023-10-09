variable "blog_name" {
  default = "My Blog"
  type    = string

  validation {
    condition     = length(var.blog_name) > 0
    error_message = "Blog name cannot be empty"
  }
}
