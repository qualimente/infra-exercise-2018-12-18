
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| availability_zones | List of availability zones to use | list | `<list>` | no |
| db_pass | Password to use for DB | string | `mypass27` | no |
| name |  | string | - | yes |
| region |  | string | `us-east-1` | no |
| vpc_id |  | string | `vpc-58a29221` | no |

## Outputs

| Name | Description |
|------|-------------|
| app.asg.launch_configuration_name |  |
| app.asg.name |  |
| app.web.dns_name |  |
| db.web.address |  |
| db.web.endpoint |  |
| lb.web.dns_name |  |

