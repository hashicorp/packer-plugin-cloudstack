Type: `cloudstack`
Artifact BuilderId: `packer.cloudstack`

The `cloudstack` Packer builder is able to create new templates for use with
[CloudStack](https://cloudstack.apache.org/). The builder takes either an ISO
or an existing template as it's source, runs any provisioning necessary on the
instance after launching it and then creates a new template from that instance.

The builder does _not_ manage templates. Once a template is created, it is up
to you to use it or delete it.

This builder is part of the
[Cloudstack plugin](https://github.com/hashicorp/packer-plugin-cloudstack).
To install this plugin using `packer init`, add the following Packer block to
your hcl template:

```
packer {
  required_plugins {
    cloudstack = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/cloudstack"
    }
  }
}
```

## Configuration Reference

There are many configuration options available for the builder. They are
segmented below into two categories: required and optional parameters. Within
each category, the available configuration keys are alphabetized.

In addition to the options listed here, a
[communicator](/packer/docs/templates/legacy_json_templates/communicator) can be configured for this
builder.

### Required:

- `api_url` (string) - The CloudStack API endpoint we will connect to. It can
  also be specified via environment variable `CLOUDSTACK_API_URL`, if set.

- `api_key` (string) - The API key used to sign all API requests. It can also
  be specified via environment variable `CLOUDSTACK_API_KEY`, if set.

- `network` (string) - The name or ID of the network to connect the instance
  to.

- `secret_key` (string) - The secret key used to sign all API requests. It
  can also be specified via environment variable `CLOUDSTACK_SECRET_KEY`, if
  set.

- `service_offering` (string) - The name or ID of the service offering used
  for the instance.

- `source_iso` (string) - The name or ID of an ISO that will be mounted
  before booting the instance. This option is mutually exclusive with
  `source_template`. When using `source_iso`, both `disk_offering` and
  `hypervisor` are required.

- `source_template` (string) - The name or ID of the template used as base
  template for the instance. This option is mutually exclusive with
  `source_iso`.

- `template_os` (string) - The name or ID of the template OS for the new
  template that will be created.

- `zone` (string) - The name or ID of the zone where the instance will be
  created.

### Optional:

- `async_timeout` (number) - The time duration to wait for async calls to
  finish. Defaults to 30m.

- `cidr_list` (array) - List of CIDR's that will have access to the new
  instance. This is needed in order for any provisioners to be able to
  connect to the instance. Defaults to `[ "0.0.0.0/0" ]`. Only required when
  `use_local_ip_address` is `false`.

- `create_security_group` (boolean) - If `true` a temporary security group
  will be created which allows traffic towards the instance from the
  `cidr_list`. This option will be ignored if `security_groups` is also
  defined. Requires `expunge` set to `true`. Defaults to `false`.

- `disk_offering` (string) - The name or ID of the disk offering used for the
  instance. This option is only available (and also required) when using
  `source_iso`.

- `disk_size` (number) - The size (in GB) of the root disk of the new instance.

- `expunge` (boolean) - Set to `true` to expunge the instance when it is
  destroyed. Defaults to `false`.

- `http_get_only` (boolean) - Some cloud providers only allow HTTP GET calls
  to their CloudStack API. If using such a provider, you need to set this to
  `true` in order for the provider to only make GET calls and no POST calls.

- `hypervisor` (string) - The target hypervisor (e.g. `XenServer`, `KVM`) for
  the new template. This option is required when using `source_iso`.

- `eject_iso` (boolean) - If `true` make a call to the CloudStack API, after
  loading image to cache, requesting to check and detach ISO file (if any)
  currently attached to a virtual machine. Defaults to `false`. This option
  is only available when using `source_iso`.

- `eject_iso_delay` (time.Duration) - Configure the duration time to wait, making
  sure virtual machine is able to finish installing OS before it ejects safely.
  Requires `eject_iso` set to `true` and this option is only available when
  using `source_iso`.

- `keypair` (string) - The name of the SSH key pair that will be used to
  access the instance. The SSH key pair is assumed to be already available
  within CloudStack.

- `instance_name` (string) - The name of the instance. Defaults to
  "packer-UUID" where UUID is dynamically generated.

- `prevent_firewall_changes` (boolean) - Set to `true` to prevent network
  ACLs or firewall rules creation. Defaults to `false`.

- `project` (string) - The name or ID of the project to deploy the instance
  to.

- `public_ip_address` (string) - The public IP address or it's ID used for
  connecting any provisioners to. If not provided, a temporary public IP
  address will be associated and released during the Packer run.

- `public_port` (number) - The fixed port you want to configure in the port
  forwarding rule. Set this attribute if you do not want to use the a random
  public port.

- `security_groups` (array of strings) - A list of security group IDs or
  names to associate the instance with.

- `ssl_no_verify` (boolean) - Set to `true` to skip SSL verification.
  Defaults to `false`.

- `template_display_text` (string) - The display text of the new template.
  Defaults to the `template_name`.

- `template_featured` (boolean) - Set to `true` to indicate that the template
  is featured. Defaults to `false`.

- `template_name` (string) - The name of the new template. Defaults to
  `packer-{{timestamp}}` where timestamp will be the current time.

- `template_public` (boolean) - Set to `true` to indicate that the template
  is available for all accounts. Defaults to `false`.

- `template_password_enabled` (boolean) - Set to `true` to indicate the
  template should be password enabled. Defaults to `false`.

- `template_requires_hvm` (boolean) - Set to `true` to indicate the template
  requires hardware-assisted virtualization. Defaults to `false`.

- `template_scalable` (boolean) - Set to `true` to indicate that the template
  contains tools to support dynamic scaling of VM cpu/memory. Defaults to
  `false`.

- `temporary_keypair_name` (string) - The name of the temporary SSH key pair
  to generate. By default, Packer generates a name that looks like
  `packer_<UUID>`, where &lt;UUID&gt; is a 36 character unique identifier.

- `user_data` (string) - User data to launch with the instance. This is a
  [template engine](/packer/docs/templates/legacy_json_templates/engine) see _User
  Data_ below for more details. Packer will not automatically wait for a user
  script to finish before shutting down the instance this must be handled in a
  provisioner.

- `user_data_file` (string) - Path to a file that will be used for the user
  data when launching the instance. This file will be parsed as a [template
  engine](/packer/docs/templates/legacy_json_templates/engine) see _User Data_ below
  for more details.

- `use_local_ip_address` (boolean) - Set to `true` to indicate that the
  provisioners should connect to the local IP address of the instance.

## User Data

The available variables are:

- `HTTPIP` and `HTTPPort` - The IP and port, respectively of an HTTP server
  that is started serving the directory specified by the `http_directory`
  configuration parameter. If `http_directory` isn't specified, these will be
  blank. Example: `{{.HTTPIP}}:{{.HTTPPort}}/path/to/a/file/in/http_directory`

### Communicator Configuration

#### Optional:

<!-- Code generated from the comments of the Config struct in communicator/config.go; DO NOT EDIT MANUALLY -->

- `communicator` (string) - Packer currently supports three kinds of communicators:
  
  -   `none` - No communicator will be used. If this is set, most
      provisioners also can't be used.
  
  -   `ssh` - An SSH connection will be established to the machine. This
      is usually the default.
  
  -   `winrm` - A WinRM connection will be established.
  
  In addition to the above, some builders have custom communicators they
  can use. For example, the Docker builder has a "docker" communicator
  that uses `docker exec` and `docker cp` to execute scripts and copy
  files.

- `pause_before_connecting` (duration string | ex: "1h5m2s") - We recommend that you enable SSH or WinRM as the very last step in your
  guest's bootstrap script, but sometimes you may have a race condition
  where you need Packer to wait before attempting to connect to your
  guest.
  
  If you end up in this situation, you can use the template option
  `pause_before_connecting`. By default, there is no pause. For example if
  you set `pause_before_connecting` to `10m` Packer will check whether it
  can connect, as normal. But once a connection attempt is successful, it
  will disconnect and then wait 10 minutes before connecting to the guest
  and beginning provisioning.

<!-- End of code generated from the comments of the Config struct in communicator/config.go; -->


<!-- Code generated from the comments of the SSH struct in communicator/config.go; DO NOT EDIT MANUALLY -->

- `ssh_host` (string) - The address to SSH to. This usually is automatically configured by the
  builder.

- `ssh_port` (int) - The port to connect to SSH. This defaults to `22`.

- `ssh_username` (string) - The username to connect to SSH with. Required if using SSH.

- `ssh_password` (string) - A plaintext password to use to authenticate with SSH.

- `ssh_ciphers` ([]string) - This overrides the value of ciphers supported by default by Golang.
  The default value is [
    "aes128-gcm@openssh.com",
    "chacha20-poly1305@openssh.com",
    "aes128-ctr", "aes192-ctr", "aes256-ctr",
  ]
  
  Valid options for ciphers include:
  "aes128-ctr", "aes192-ctr", "aes256-ctr", "aes128-gcm@openssh.com",
  "chacha20-poly1305@openssh.com",
  "arcfour256", "arcfour128", "arcfour", "aes128-cbc", "3des-cbc",

- `ssh_clear_authorized_keys` (bool) - If true, Packer will attempt to remove its temporary key from
  `~/.ssh/authorized_keys` and `/root/.ssh/authorized_keys`. This is a
  mostly cosmetic option, since Packer will delete the temporary private
  key from the host system regardless of whether this is set to true
  (unless the user has set the `-debug` flag). Defaults to "false";
  currently only works on guests with `sed` installed.

- `ssh_key_exchange_algorithms` ([]string) - If set, Packer will override the value of key exchange (kex) algorithms
  supported by default by Golang. Acceptable values include:
  "curve25519-sha256@libssh.org", "ecdh-sha2-nistp256",
  "ecdh-sha2-nistp384", "ecdh-sha2-nistp521",
  "diffie-hellman-group14-sha1", and "diffie-hellman-group1-sha1".

- `ssh_certificate_file` (string) - Path to user certificate used to authenticate with SSH.
  The `~` can be used in path and will be expanded to the
  home directory of current user.

- `ssh_pty` (bool) - If `true`, a PTY will be requested for the SSH connection. This defaults
  to `false`.

- `ssh_timeout` (duration string | ex: "1h5m2s") - The time to wait for SSH to become available. Packer uses this to
  determine when the machine has booted so this is usually quite long.
  Example value: `10m`.
  This defaults to `5m`, unless `ssh_handshake_attempts` is set.

- `ssh_disable_agent_forwarding` (bool) - If true, SSH agent forwarding will be disabled. Defaults to `false`.

- `ssh_handshake_attempts` (int) - The number of handshakes to attempt with SSH once it can connect.
  This defaults to `10`, unless a `ssh_timeout` is set.

- `ssh_bastion_host` (string) - A bastion host to use for the actual SSH connection.

- `ssh_bastion_port` (int) - The port of the bastion host. Defaults to `22`.

- `ssh_bastion_agent_auth` (bool) - If `true`, the local SSH agent will be used to authenticate with the
  bastion host. Defaults to `false`.

- `ssh_bastion_username` (string) - The username to connect to the bastion host.

- `ssh_bastion_password` (string) - The password to use to authenticate with the bastion host.

- `ssh_bastion_interactive` (bool) - If `true`, the keyboard-interactive used to authenticate with bastion host.

- `ssh_bastion_private_key_file` (string) - Path to a PEM encoded private key file to use to authenticate with the
  bastion host. The `~` can be used in path and will be expanded to the
  home directory of current user.

- `ssh_bastion_certificate_file` (string) - Path to user certificate used to authenticate with bastion host.
  The `~` can be used in path and will be expanded to the
  home directory of current user.

- `ssh_file_transfer_method` (string) - `scp` or `sftp` - How to transfer files, Secure copy (default) or SSH
  File Transfer Protocol.
  
  **NOTE**: Guests using Windows with Win32-OpenSSH v9.1.0.0p1-Beta, scp
  (the default protocol for copying data) returns a a non-zero error code since the MOTW
  cannot be set, which cause any file transfer to fail. As a workaround you can override the transfer protocol
  with SFTP instead `ssh_file_transfer_protocol = "sftp"`.

- `ssh_proxy_host` (string) - A SOCKS proxy host to use for SSH connection

- `ssh_proxy_port` (int) - A port of the SOCKS proxy. Defaults to `1080`.

- `ssh_proxy_username` (string) - The optional username to authenticate with the proxy server.

- `ssh_proxy_password` (string) - The optional password to use to authenticate with the proxy server.

- `ssh_keep_alive_interval` (duration string | ex: "1h5m2s") - How often to send "keep alive" messages to the server. Set to a negative
  value (`-1s`) to disable. Example value: `10s`. Defaults to `5s`.

- `ssh_read_write_timeout` (duration string | ex: "1h5m2s") - The amount of time to wait for a remote command to end. This might be
  useful if, for example, packer hangs on a connection after a reboot.
  Example: `5m`. Disabled by default.

- `ssh_remote_tunnels` ([]string) - 

- `ssh_local_tunnels` ([]string) - 

<!-- End of code generated from the comments of the SSH struct in communicator/config.go; -->


<!-- Code generated from the comments of the SSHTemporaryKeyPair struct in communicator/config.go; DO NOT EDIT MANUALLY -->

- `temporary_key_pair_type` (string) - `dsa` | `ecdsa` | `ed25519` | `rsa` ( the default )
  
  Specifies the type of key to create. The possible values are 'dsa',
  'ecdsa', 'ed25519', or 'rsa'.
  
  NOTE: DSA is deprecated and no longer recognized as secure, please
  consider other alternatives like RSA or ED25519.

- `temporary_key_pair_bits` (int) - Specifies the number of bits in the key to create. For RSA keys, the
  minimum size is 1024 bits and the default is 4096 bits. Generally, 3072
  bits is considered sufficient. DSA keys must be exactly 1024 bits as
  specified by FIPS 186-2. For ECDSA keys, bits determines the key length
  by selecting from one of three elliptic curve sizes: 256, 384 or 521
  bits. Attempting to use bit lengths other than these three values for
  ECDSA keys will fail. Ed25519 keys have a fixed length and bits will be
  ignored.
  
  NOTE: DSA is deprecated and no longer recognized as secure as specified
  by FIPS 186-5, please consider other alternatives like RSA or ED25519.

<!-- End of code generated from the comments of the SSHTemporaryKeyPair struct in communicator/config.go; -->


- `ssh_keypair_name` (string) - If specified, this is the key that will be used for SSH with the
  machine. The key must match a key pair name loaded up into the remote.
  By default, this is blank, and Packer will generate a temporary keypair
  unless [`ssh_password`](#ssh_password) is used.
  [`ssh_private_key_file`](#ssh_private_key_file) or
  [`ssh_agent_auth`](#ssh_agent_auth) must be specified when
  [`ssh_keypair_name`](#ssh_keypair_name) is utilized.


- `ssh_private_key_file` (string) - Path to a PEM encoded private key file to use to authenticate with SSH.
  The `~` can be used in path and will be expanded to the home directory
  of current user.


- `ssh_agent_auth` (bool) - If true, the local SSH agent will be used to authenticate connections to
  the source instance. No temporary keypair will be created, and the
  values of [`ssh_password`](#ssh_password) and
  [`ssh_private_key_file`](#ssh_private_key_file) will be ignored. The
  environment variable `SSH_AUTH_SOCK` must be set for this option to work
  properly.


## Http directory configuration

<!-- Code generated from the comments of the HTTPConfig struct in multistep/commonsteps/http_config.go; DO NOT EDIT MANUALLY -->

Packer will create an http server serving `http_directory` when it is set, a
random free port will be selected and the architecture of the directory
referenced will be available in your builder.

Example usage from a builder:

	`wget http://{{ .HTTPIP }}:{{ .HTTPPort }}/foo/bar/preseed.cfg`

<!-- End of code generated from the comments of the HTTPConfig struct in multistep/commonsteps/http_config.go; -->


### Optional:

<!-- Code generated from the comments of the HTTPConfig struct in multistep/commonsteps/http_config.go; DO NOT EDIT MANUALLY -->

- `http_directory` (string) - Path to a directory to serve using an HTTP server. The files in this
  directory will be available over HTTP that will be requestable from the
  virtual machine. This is useful for hosting kickstart files and so on.
  By default this is an empty string, which means no HTTP server will be
  started. The address and port of the HTTP server will be available as
  variables in `boot_command`. This is covered in more detail below.

- `http_content` (map[string]string) - Key/Values to serve using an HTTP server. `http_content` works like and
  conflicts with `http_directory`. The keys represent the paths and the
  values contents, the keys must start with a slash, ex: `/path/to/file`.
  `http_content` is useful for hosting kickstart files and so on. By
  default this is empty, which means no HTTP server will be started. The
  address and port of the HTTP server will be available as variables in
  `boot_command`. This is covered in more detail below.
  Example:
  ```hcl
    http_content = {
      "/a/b"     = file("http/b")
      "/foo/bar" = templatefile("${path.root}/preseed.cfg", { packages = ["nginx"] })
    }
  ```

- `http_port_min` (int) - These are the minimum and maximum port to use for the HTTP server
  started to serve the `http_directory`. Because Packer often runs in
  parallel, Packer will choose a randomly available port in this range to
  run the HTTP server. If you want to force the HTTP server to be on one
  port, make this minimum and maximum port the same. By default the values
  are `8000` and `9000`, respectively.

- `http_port_max` (int) - HTTP Port Max

- `http_bind_address` (string) - This is the bind address for the HTTP server. Defaults to 0.0.0.0 so that
  it will work with any network interface.

<!-- End of code generated from the comments of the HTTPConfig struct in multistep/commonsteps/http_config.go; -->


## Basic Example

Here is a basic example.

**JSON**

```json
{
  "type": "cloudstack",
  "api_url": "https://cloudstack.company.com/client/api",
  "api_key": "YOUR_API_KEY",
  "secret_key": "YOUR_SECRET_KEY",

  "disk_offering": "Small - 20GB",
  "hypervisor": "KVM",
  "network": "management",
  "service_offering": "small",
  "source_iso": "CentOS-7.0-1406-x86_64-Minimal",
  "zone": "NL1",

  "ssh_username": "root",

  "template_name": "Centos7-x86_64-KVM-Packer",
  "template_display_text": "Centos7-x86_64 KVM Packer",
  "template_featured": true,
  "template_password_enabled": true,
  "template_scalable": true,
  "template_os": "Other PV (64-bit)"
}
```

**HCL2**

```hcl

source "cloudstack" "example" {
  api_key                   = "YOUR_API_KEY"
  api_url                   = "https://cloudstack.company.com/client/api"
  disk_offering             = "Small - 20GB"
  hypervisor                = "KVM"
  network                   = "management"
  secret_key                = "YOUR_SECRET_KEY"
  service_offering          = "small"
  source_iso                = "CentOS-7.0-1406-x86_64-Minimal"
  ssh_username              = "root"
  template_display_text     = "Centos7-x86_64 KVM Packer"
  template_featured         = true
  template_name             = "Centos7-x86_64-KVM-Packer"
  template_os               = "Other PV (64-bit)"
  template_password_enabled = true
  template_scalable         = true
  zone                      = "NL1"
}

build {
  sources = ["source.cloudstack.example"]
}

```
