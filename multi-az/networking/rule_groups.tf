# ----------------------------------------------------------------------------------------------
# AWS Network Firewall Rule Group - Stateless
# ----------------------------------------------------------------------------------------------
resource "aws_networkfirewall_rule_group" "stateless" {
  capacity = 100
  name     = "nfw-stateless"
  type     = "STATELESS"

  rule_group {
    rules_source {
      stateless_rules_and_custom_actions {
        stateless_rule {
          priority = 1
          rule_definition {
            actions = ["aws:pass", "ExampleMetricsAction"]
            match_attributes {
              source {
                address_definition = "1.2.3.4/32"
              }
              source_port {
                from_port = 443
                to_port   = 443
              }
              destination {
                address_definition = "124.1.1.5/32"
              }
              destination_port {
                from_port = 443
                to_port   = 443
              }
              protocols = [6]
            }
          }
        }
      }
    }
  }
}

resource "aws_networkfirewall_rule_group" "stateful" {
  capacity = 100
  name     = "nfw-stateful"
  type     = "STATEFUL"

  rule_group {
    rules_source {
      rules_source_list {
        generated_rules_type = "DENYLIST"
        target_types         = ["HTTP_HOST"]
        targets              = ["www.microsoft.com"]
      }
    }
  }
}
