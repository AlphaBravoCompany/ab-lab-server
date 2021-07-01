variable "name" {
  description = "The Firewall name"
  type        = string
}

variable "tags" {
  description = "The tags added to the Firewall"
  type        = list(string)
  default     = []
}

variable "droplet_ids" {
  description = "The list of the IDs of the Droplets assigned to the Firewall"
  type        = list(string)
  default     = []
}

variable "inbound_rules" {
  description = "The inbound access rules for the Firewall"
  type        = list

  default = [
    {
      protocol                  = "tcp"
      port_range                = ""
      source_addresses          = ["0.0.0.0/0", "::/0"]
      source_droplet_ids        = []
      source_tags               = []
      source_load_balancer_uids = []
    }
  ]
}

variable "outbound_rules" {
  description = "The outbound access rules for the Firewall"
  type        = list

  default = [
    {
      protocol                       = "tcp"
      port_range                     = "1-65535"
      destination_addresses          = ["0.0.0.0/0", "::/0"]
      destination_droplet_ids        = []
      destination_tags               = []
      destination_load_balancer_uids = []
    },
    {
      protocol                       = "udp"
      port_range                     = "1-65535"
      destination_addresses          = ["0.0.0.0/0", "::/0"]
      destination_droplet_ids        = []
      destination_tags               = []
      destination_load_balancer_uids = []
    },
    {
      protocol                       = "icmp"
      port_range                     = "1-65535"
      destination_addresses          = ["0.0.0.0/0", "::/0"]
      destination_droplet_ids        = []
      destination_tags               = []
      destination_load_balancer_uids = []
    },
  ]
}