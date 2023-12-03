output "aws_iam_group_arns" {
  value = { for k, v in aws_iam_group.group : k => v.arn }
}

output "aws_iam_user_arns" {
  value = { for k, v in aws_iam_user.user : k => v.arn }
}

output "aws_iam_user_ids" {
  value = { for k, v in aws_iam_user.user : k => v.id }
}

output "aws_iam_group_descriptions" {
  value = var.iam_groups
}

output "aws_iam_group_policy_ids" {
  value = { for k, v in aws_iam_group_policy.group_specific_policy : k => v.id }
}

output "aws_iam_group_policy_groups" {
  value = { for k, v in aws_iam_group_policy.group_specific_policy : k => v.group }
}

output "group_membership_details" {
  value = { for k, v in aws_iam_group_membership.group_membership : k => { "group" = v.group, "users" = v.users } }
}

output "aws_iam_access_key_metadata" {
  value = { for k, v in aws_iam_access_key.access_key : k => { "user" = v.user, "creation_date" = v.create_date } }
}
