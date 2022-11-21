# ----------------------------------------------------------------------------------------------
# AWS Network Firewall Policy
# ----------------------------------------------------------------------------------------------
resource "aws_networkfirewall_firewall_policy" "this" {
  name = "nfw-policy"

  firewall_policy {
    stateless_default_actions          = ["aws:pass"]
    stateless_fragment_default_actions = ["aws:pass"]

    # stateful_rule_group_reference {
    #   priority     = 0
    #   resource_arn = "arn:aws:network-firewall:ap-northeast-1:334678299258:stateful-rulegroup/allow-statefull"
    # }

    stateless_rule_group_reference {
      priority     = 1
      resource_arn = "arn:aws:network-firewall:ap-northeast-1:334678299258:stateless-rulegroup/allow-stateless"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

# ----------------------------------------------------------------------------------------------
# AWS Network Firewall
# ----------------------------------------------------------------------------------------------
resource "aws_networkfirewall_firewall" "this" {
  name                              = "nfw"
  firewall_policy_arn               = aws_networkfirewall_firewall_policy.this.arn
  vpc_id                            = aws_vpc.this.id
  delete_protection                 = false
  subnet_change_protection          = false
  firewall_policy_change_protection = false

  dynamic "subnet_mapping" {
    for_each = aws_subnet.firewall[*].id

    content {
      subnet_id = subnet_mapping.value
    }
  }

  tags = {
    "Name" = "firewall"
  }
}
