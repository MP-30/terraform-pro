variable "mysensitive" {
  type = string
  default = "my-sensitive-value"
}

output "mysensitiveoutput" {
  value = var.mysensitive
  sensitive = true
}