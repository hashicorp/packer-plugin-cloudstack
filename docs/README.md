# Cloudstack Plugin

The [Cloudstack](https://cloudstack.apache.org/) Packer plugin provides a
`cloudstack` builder that is able to
create new templates for use with CloudStack. The builder takes either an ISO
or an existing template as its source, runs any provisioning necessary on the instance after launching it and then creates a new template from that instance.

## Installation

### Using pre-built releases

#### Using the `packer init` command

Starting from version 1.7, Packer supports a new `packer init` command allowing
automatic installation of Packer plugins. Read the
[Packer documentation](https://www.packer.io/docs/commands/init) for more information.

To install this plugin, copy and paste this code into your Packer configuration .
Then, run [`packer init`](https://www.packer.io/docs/commands/init).

```hcl
packer {
  required_plugins {
    cloudstack = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/cloudstack"
    }
  }
}
```

#### Manual installation

You can find pre-built binary releases of the plugin [here](https://github.com/hashicorp/packer-plugin-cloudstack/releases).
Once you have downloaded the latest archive corresponding to your target OS,
uncompress it to retrieve the plugin binary file corresponding to your platform.
To install the plugin, please follow the Packer documentation on
[installing a plugin](https://www.packer.io/docs/extending/plugins/#installing-plugins).


#### From Source

If you prefer to build the plugin from its source code, clone the GitHub
repository locally and run the command `go build` from the root
directory. Upon successful compilation, a `packer-plugin-name` plugin
binary file can be found in the root directory.
To install the compiled plugin, please follow the official Packer documentation
on [installing a plugin](https://www.packer.io/docs/extending/plugins/#installing-plugins).


## Plugin Contents

The Cloudstack plugin allows Packer to interface with
[cloudstack](https://cloudstack.apache.org/)

### Builders

- [builder](/docs/builders/cloudstack.mdx) -  Creates new templates for use
with CloudStack. The builder takes either an ISO or an existing template as its
source, runs any provisioning necessary on the instance after launching it and
then creates a new template from that instance.
