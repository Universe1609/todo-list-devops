resource "aws_dynamodb_table" "todo-list-devsecops-table" {
  name           = "todo-list-devsecops-table"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    "project" = "todo-list"
  }
}
