resource "random_id" "this" {
  byte_length = 4
}

locals {
  suffix = random_id.this.hex
}
