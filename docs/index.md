# southern.podzone.net

## Site relocation and high availability

Over the last 27 years, a number of websites, applications and services have been implemented on a local site, some exposed to the Internet, and some for network internal access only.

This infrastructures has served the requirements of a few entities, some of which still have dependencies on these services.

Faced with the shutdown of the site, and the absence of a sutable replacement site for four to six months, a plan is required to provide ongoing services. The services will need to run with no change in service delivery, after the current physical site is shut down. For some months a new site will not be available, so accommodation for the services will need to be arranged in the intervening months.

Although there are many possible solutions, most of them more efficient in terms of hardware utilisation, and effort, the following approach will be taken:

- Migrate the services to a redundant highly available configuration, on site, using a set of servers, and related network configuration.
- Arrange rented / shared accommodation, and set the servers and networking up to be remotely accessed and administered.
- When relocated, set up an equivalent new site, providing site redundancy.

## Technology decisions

As mentioned, there are various alternative solutions that would achieve the business goal. Lifecycle cost considerations would typically guide the selection of solution. However, I have the unusual privilidge to re-architect the solution in a way that supports maximum exposure to current technologies, with little regard for the timelines and effort. Selecting this route provides a learning opportunity. This in turn has resulted in a mentoring oportunity.

Technology decisions are further guided by the following learning imperatives:

- Build confidence in deploying, troubleshooting and consuming Kubernetes
- Apply declarative processes for the platform and service provisioning (IoC)
- Consumer Cloud case study

Additional technology strategy:

- No additional public service consumption, reduction where possible.
- Continue to utilise open source software

### Existing public service consumption of note

- DynDns for domain hosting
- iCloud for offsite storage
- LetsEncrypt for https certificates
- GitHub for source code repository
