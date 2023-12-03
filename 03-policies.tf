data "aws_iam_policy_document" "standard_policy" {
  statement {
    effect = "Allow"

    actions = var.standard_policy_actions
    resources = ["*"]
  }
}

resource "aws_iam_group_policy" "standard_policy" {
  for_each = var.group_policies
  name     = "${each.key}-policy"
  group    = aws_iam_group.group[each.key].name
  policy   = data.aws_iam_policy_document.standard_policy.json
}

data "aws_iam_policy_document" "mfa_policy" {
  statement {
    effect = "Allow"
    actions = ["sts:GetSessionToken"]
    resources = ["*"]
    condition {
      test     = "BoolIfExists"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
}

resource "aws_iam_group_policy" "mfa_policy" {
  for_each = { for k in var.mfa_enabled_groups : k => var.iam_groups[k] if contains(keys(var.iam_groups), k) }
  name     = "${each.key}-mfa-policy"
  group    = aws_iam_group.group[each.key].name
  policy   = data.aws_iam_policy_document.mfa_policy.json
}
