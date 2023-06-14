# For full specification on the configuration of this file visit:
# https://github.com/hashicorp/integration-template#metadata-configuration
integration {
  name = "CloudStack"
  description = "The cloudstack plugin can be used with HashiCorp Packer to create custom images on Apache CloudStack."
  identifier = "packer/hashicorp/cloudstack"
  component {
    type = "builder"
    name = "CloudStack"
    slug = "cloudstack"
  }
}
