# Background

Since the late 1990s, a number of websites, applications and services have been implemented on a local site, some exposed to the Internet, and some for network internal access only.

This infrastructures has served the requirements of a few people, and legal entities, some of which still have dependencies on these services.

This functionality has been built as a residential on-premise set of solutions running on workstation hardware repurposed as servers, the first of these being a "Alf", a 75 MHz Pentium, with 40 M RAM.

While it is difficult to imagine now, Alf, with it's limited resources by today's standards, would have run the Slackware distribution of Linux, with an application written for the Zope object publishing platform, with Postgres as database server. It would have provided additional services alongside the application server solution. None of these services were exposed on the Internet until about 2005. The first domain invoice was issued in 2008, before which free dynamic dns domains were used to serve applications and content.

The first application running on-premise was a line of business application for property syndicate management, property rental management, and general purpose book-keeping and accounting reporting functionality. Over time, personal blogs, online book sales, and a cake marketing site were added. On site services grew to include mail archives, file serving, and several minecraft worlds.

Of these all, the syndicate management and accounting applications are still critical, with the mail and file store solutions being used only occasionally.

Faced with the shutdown of the site, and the absence of a suitable replacement site for four to six months, a plan is required to provide ongoing services. The services will need to run with no change in service delivery, after the current physical site is shut down. For some months a new site will not be available, so accommodation for the services will need to be arranged in the intervening months.

## High Level Roadmap

The following implementation approach will be taken:

- Migrate the services to a redundant highly available configuration, on site, using a set of servers, and related network configuration.
- Arrange rented / shared accommodation, and set the servers and networking up to be remotely accessed and administered.
- All source information, including site code and data to be available independently of the site, on the Internet, to support second site build.
- When relocated, set up an equivalent new site, providing site redundancy.
