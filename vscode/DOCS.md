# Home Assistant Add-on: vscode

This add-on runs Visual Studio Code, allowing you to edit your [Home Assistant] configuration straight from the web browser, embedded straight into the [Home Assistant] frontend UI, or via SSH.

Visual Studio Code runs as a remote server using [code-server], and is a full fledged vscode experience.

## Installation

The installation of this add-on is straightforward and not different in comparison to installing any other [Home Assistant] add-on.

1. Click the [My Home Assistant] button below to open the add-on on your [Home Assistant] instance.

   [![Open this add-on in your Home Assistant instance][addon-badge]][addon]

1. Click the **Install** button to install the add-on.

1. Start the **vscode** add-on.

1. Check the logs of the **vscode** add-on to see if everything went well.

1. Click the "OPEN WEB UI" button to open Studio Code Server.

## Configuration

> **NOTE:** Remember to restart the add-on when configuration is changed.

Example add-on configuration:

<!-- cspell:disable -->

```yaml
config_path: /share/my_path
log_level: info
init_commands:
  - ls -la
packages:
  - mariadb-client
ssh:
  username: homeassistant
  password: ""
  authorized_keys:
    - ssh-ed25519 AASDJKJKJFWJFAFLCNALCMLAK234234.....
  sftp: false
  compatibility_mode: false
  allow_agent_forwarding: false
  allow_remote_port_forwarding: false
  allow_tcp_forwarding: false
```

<!-- cspell:enable -->

> **NOTE:** This is just an example, don't copy and paste it! Create your own!

### Option: `config_path`

This option allows you to override the default path the add-on will open when accessing the web interface.
For example, use a different configuration directory like `/share/my-config` instead of `/config`.
If set to `/root` then all the common folders of HA such as `/config`, `/ssl`, `/share`, etc. will appear as subfolders for each access.

When not configured, the add-on will automatically use the default: `/config`

### Option: `init_commands`

Customize your VSCode environment even more with the `init_commands` option.
Add one or more shell commands to the list, and they will be executed every single time this add-on starts.

### Option: `log_level`

The `log_level` option controls the level of log output by the add-on and can be changed to be more or less verbose, which might be useful when you are dealing with an unknown issue.

Possible values are:

- `trace`: Show every detail, like all called internal functions.
- `debug`: Shows detailed debug information.
- `info`: Normal (usually) interesting events.
- `warning`: Exceptional occurrences that are not errors.
- `error`: Runtime errors that do not require immediate action.
- `fatal`: Something went terribly wrong. Add-on becomes unusable.

Please note that each level automatically includes log messages from a more severe level, e.g., `debug` also shows `info` messages.
By default, the `log_level` is set to `info`, which is the recommended setting unless you are troubleshooting.

### Option: `packages`

Allows you to specify additional [Ubuntu packages][ubuntu-packages] to be installed in your shell environment (e.g., Python, PHP, Go).

> **NOTE:** Adding many packages will result in a longer start-up time for the add-on.

### Option Group: `ssh`

The following options are for the option group `ssh`.
These settings only apply to the SSH daemon.

#### Option `ssh`: `allow_agent_forwarding`

Specifies whether ssh-agent forwarding is permitted or not.

> **NOTE:** Enabling this option, lowers the security of your SSH server!
> Nevertheless, this warning is debatable.

#### Option `ssh`: `allow_remote_port_forwarding`

Specifies whether remote hosts are allowed to connect to ports forwarded for the client.

> **NOTE:** Enabling this affects all remote forwardings, so think carefully before doing this.

#### Option `ssh`: `allow_tcp_forwarding`

Specifies whether TCP forwarding is permitted or not.

> **NOTE:** Enabling this option, lowers the security of your SSH server!
> Nevertheless, this warning is debatable.

#### Option `ssh` `authorized_keys`

Add one or more public keys to your SSH server to use with authentication.
This is the recommended over setting a password.

Please take a look at the awesome [documentation created by GitHub][github-ssh] about using public/private key pairs and how to create them.

> **NOTE:** Please ensure the keys are specified as a list by pasting within the `[]` comma delimited.

#### Option `ssh`: `compatibility_mode`

This SSH add-on focuses on security and has therefore only enabled known secure encryption methods.
However, some older clients do not support these.
Setting this option to `true` will enable the original default set of methods, allowing those clients to connect.

> **NOTE:** Enabling this option, lowers the security of your SSH server!

#### Option `ssh`: `password`

Sets the password to log in with.
Leaving it empty would disable the possibility to authenticate with a password.
We would highly recommend not to use this option from a security point of view.

#### Option `ssh`: `sftp`

When set to `true` the add-on will enable SFTP support on the SSH daemon.
Please only enable it when you plan on using it.

> **NOTE:** Due to limitations, you will need to set the username to `root` in order to be able to enable the SFTP capabilities.

#### Option `ssh`: `username`

This option allows you to change to username the use when you log in via SSH.
It is only utilized for the authentication; you will be the `root` user after you have authenticated.
Using `root` as the username is possible, but not recommended.
Usernames will be converted to lower case as per recommended practices.

> **NOTE:** Due to limitations, you will need to set this option to `root` in order to be able to enable the SFTP capabilities.

## Known issues and limitations

- Can this add-on run on a Raspberry Pi? Yes, but only if you run a 64 bits operating system.
- This add-on currently only supports AMD64 and aarch64/ARM64 machines.
  Although ARM devices are supported, please be aware, that this add-on is quite heavy to run, and requires quite a bit of RAM.
  It is not recommended to run it on devices with less than 4Gb of memory.
- When SFTP is enabled, the username MUST be set to `root`.
- If you want to use rsync for file transfer, the username MUST be set to `root`.

## Changelog & Releases

This repository keeps a change log using [GitHub's releases][releases] functionality.

Releases are based on [Semantic Versioning][semver], and use the format of `MAJOR.MINOR.PATCH`.
In a nutshell, the version will be incremented based on the following:

- `MAJOR`: Incompatible or major changes.
- `MINOR`: Backwards-compatible new features and enhancements.
- `PATCH`: Backwards-compatible bugfixes and package updates.

## Support

Got questions?

Open an [issue on GitHub][issues].
Note, we use a separate GitHub repository for each add-on.
Please ensure you are creating the issue on the correct GitHub repository matching the add-on.

[addon]: https://my.home-assistant.io/redirect/supervisor_addon/?addon=4b9bfde2_vscode&repository_url=https%3A%2F%2Fgithub.com%2Ffinleyfamily%2Fhass-repository
[addon-badge]: https://my.home-assistant.io/badges/supervisor_addon.svg
[code-server]: https://github.com/coder/code-server
[github-ssh]: https://help.github.com/articles/connecting-to-github-with-ssh/
[home assistant]: https://www.home-assistant.io/
[issues]: https://github.com/finleyfamily/hass-addon-vscode/issues
[my home assistant]: https://www.home-assistant.io/integrations/my/
[releases]: https://github.com/finleyfamily/hass-addon-vscode/releases
[semver]: http://semver.org/spec/v2.0.0.html
[ubuntu-packages]: https://packages.ubuntu.com
