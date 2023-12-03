resource "aws_iam_access_key" "access_key" {
  for_each = aws_iam_user.user
  user     = each.value.name
}

locals {
  user_keys_csv = { for k, v in aws_iam_access_key.access_key : k => "access_key,secret_key\n${v.id},${v.secret}" }
}

resource "local_file" "user_keys" {
  for_each = local.user_keys_csv
  content  = each.value
  filename = "${each.key}-keys.csv"
}