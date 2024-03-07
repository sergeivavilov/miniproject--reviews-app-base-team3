variable "allowed_accounts" {
  type = list(string)
  description = "Account ID's of users who will assume Admin role"
}

variable "policy_names" {
  type = list(string)
  description = "list of policies that will be attached to role"
}

variable "role_name" {
  type = string
  description = "Name of the role to be craeted"
}

variable "duration_of_a_role" {
  type = number
  description = "session duration for a role"
}