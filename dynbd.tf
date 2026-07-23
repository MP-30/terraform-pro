resource "aws_dynamodb_table" "user_orders" {
  name         = "UserOrders"
  billing_mode = "PAY_PER_REQUEST" # On-Demand capacity
  hash_key     = "OrderId"

  attribute {
    name = "OrderId"
    type = "S" # String
  }
}
