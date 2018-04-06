![gibson logo image](https://emeraldonion.org/wp-content/uploads/2018/04/Outline-Long.jpg)

gibson is a cross-functional suite of tools used to assist in provisioning and maintaining Tor services.  gibson doesn't replace tools such as ezjail, iocell, bhyve, nginx, caddy, LUKS and geli, but rather aims to glue them together into secure Tor services.

The aim of the project is to provide the tools necessary for a user to quickly and easily turn a new BSD installation into a Tor appliance in a safe and reproducible fashion.

[gibson GitHub](https://github.com/emeraldonion/gibson)
[Emerald Onion](https://emeraldonion.org)

## Getting Started

Obtain the gibson project code and install it according to your preference (port vs package) and availability (near the launch date, binary packages may not be available yet).

Once installed, you may invoke gibson by running:

`gibson`

gibson currently provides a series of subcommands which address routine, ongoing maintenance of Tor processes running in HardenedBSD jails.  The solution space is expanding rapidly as the project is under active development.

### Prerequisites

gibson currently has no external dependencies (aside from those packaged in HardenedBSD base).

### Installing

The recommended method of installing `gibson` is via `pkg` or with the HardenedBSD ports tree.  Since our project is recently launched, binary packages (or even the ports metadata) may not be available yet through the customary tools.  Until it is available in the ports tree, you can bootstrap your installation by retrieving the ports metadata from [Emerald Onion's GitHub](https://github.com/emeraldonion/gibson-port):

`git clone https://github.com/emeraldonion/gibson-port /usr/ports/security/gibson`

You should inspect the files you download to make sure there is nothing sinister in them.  You should also make sure there is nothing sinister in the gibson repository.  No matter who you download from, you should always be careful running code you download from the Internet.

Once you are satisfied that our files will not cause you harm, you can install the gibson project:

`cd /usr/ports/security/gibson; make install clean;`

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/emeraldonion/gibson/tags).

## Authors

* **Jordan Boland** - *Initial work* - [undervillain](https://github.com/undervillain)

See also the list of [contributors](https://github.com/emeraldonion/gibson/contributors) who participated in this project.

## License

This project is licensed under the 2-clause BSD License - see the [LICENSE](LICENSE) file for details

## Acknowledgments

* [Shawn Webb (@lattera)](https://github.com/lattera) for his thoughtful collaboration and inpiration
* [Mike Finch](https://twitter.com/mkfnch) who generously developed and donated the gibson logo
* The [HardenedBSD project](https://hardenedbsd.org)

