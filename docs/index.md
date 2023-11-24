# Introduction

This micro-site contains documentation including the requirements, specification, design, and build notes for the technology research, development, test and build of a kubernetes cluster, and migrating a workload from older technologies.

## Background

Over the last 27 years, a number of websites, applications and services have been implemented on a local site, some exposed to the Internet, and some for network internal access only.

This infrastructures has served the requirements of a few entities, some of which still have dependencies on these services.

Faced with the shutdown of the site, and the absence of a suitable replacement site for four to six months, a plan is required to provide ongoing services. The services will need to run with no change in service delivery, after the current physical site is shut down. For some months a new site will not be available, so accommodation for the services will need to be arranged in the intervening months.

Although there are many possible solutions, most of them more efficient in terms of hardware utilisation, and effort, the following approach will be taken:

- Migrate the services to a redundant highly available configuration, on site, using a set of servers, and related network configuration.
- Arrange rented / shared accommodation, and set the servers and networking up to be remotely accessed and administered.
- When relocated, set up an equivalent new site, providing site redundancy.

## Technology decisions

As mentioned, there are various alternative solutions that would achieve the business goal. Lifecycle cost considerations would typically guide the selection of solution. However, I have the unusual privilege to re-architect the solution in a way that supports maximum exposure to current technologies, with little regard for the timelines and effort. Selecting this route provides a learning opportunity. This in turn has resulted in a mentoring opportunity.

Technology decisions are further guided by the following learning imperatives:

- Build confidence in deploying, troubleshooting and consuming Kubernetes
- Apply declarative processes for the platform and service provisioning (IoC)
- Documenting a "Consumer Cloud" case study

Additional technology strategy:

- No additional public service consumption, reduction where possible.
- Continue to utilise open source software

## Source code

The source for the project is available from a public repo on GitHub: <https://github.com/MoTTTT/QApps>.
