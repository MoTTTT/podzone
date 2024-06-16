# Consumer Cloud

## Definition

[HG Insights](https://hginsights.com/) defines **Consumer Cloud** in their Glossary as follows:

```text
Cloud computing  offerings  targeted toward  individuals for personal use, 
such as Dropbox or iCloud. End users interact with consumer  cloud’s through 
highly  interactive  applications. When you store  photos or documents in an
app like Dropbox, you are interacting  with their cloud, hence the  consumer
cloud. Consumer clouds are composed no differently from other cloud systems.
The only  difference is the B2C nature of their delivery. Most  applications
that  interact  directly  with  the  customer  can be  classified as using a 
consumer cloud.
```

In this sense, the term "Consumer Cloud" refers to Cloud service offerings targeting Consumers, as opposed to Business or Enterprise Cloud service provider customers.

The definition of "Cloud Consumer" is consistently along the lines of "a consumer of cloud services".

I am not aware of a formal definition for a **Consumer built and managed Cloud Service**. However this is the sense in which I would like to use the term.

## Consumer built and managed Cloud Service

Since I have the skill-set to set up and manage server hardware, and the hardware necessary to suite the workload, I have always preferred self-hosting from my residential network, rather than to make use of hosting or cloud services. The relative costs of hosting and cloud services have been investigated on occasion over time, and not found suitable for this set of use-cases.

Further, the inclination to own the computing fabric, rather than to rent capacity is strong, for the same reasons that owning property for my family's accommodation rather than renting property is preferable.

Lastly, I have a personal professional interest in hardware and computing, and am prepared to develop this skill set in the re-architecture of the solution as an on-premise solution, using current cloud technologies.

## Alternatives

While this definition of *Consumer Cloud* has a level of engineering skill required, it is easy to envision a future scenario where the components are commoditised to the extent that this is no longer the case.

While this project's scope is focused on a set of *Information Technology* requirements such as file mail and application services, pre-built consumer grade appliances that come close to fulfilling the requirement are already available. These however invariably have a component of their offering that includes one or more *vendor ecosystems*. These typically require registering with and using, at run-time, Service Provider cloud services available only via the Internet to configure and manage the solution.

So in a sense *Consumer Cloud* is already an offering on the market, if one understands the *build* part to refer to sourcing and installing an appliance, and one is not to fussy about committing to a dependency on vendor eco-systems.

There are also a few platforms that play some role in empowering consumers - some positioned to support large organisations as well - to manage on-premise services and solutions without the vendor eco-system. These range from solutions focusing on putting a user's data back in their own sphere of influence - for reasons relating to Data Sovereignty - to solutions supporting home technicians and hobbyists get up and running with pre-packaged solutions for media servers, blog sites and the like.

With the *build* part being relevant to me, and an aversion to committing to vendor ecosystems where avoidable, none of these solutions were a good fit for my set of use-cases.

There is a sense in which vendor ecosystems are hard to avoid, if one includes the many middle-men in the software provisioning pipeline. This includes operating system release solutions, and the package management that runs on top of these.

For this solution, at least the MVP portion, this is acceptable.

There is a parallel initiative to investigate cloud at the edge and IoT. As the run-time for this initiative is Embedded Linux, a tool-chain to build an OS image for specifically targeted hardware is required. The tool-chain needs to build an image including operating system kernel, only the required support software, and one or more run-time applications. A k3s layer, which provides a light weight cloud (kubernetes) distribution will also be installed. It would be interesting to investigate using this same tool-chain to target the hardware used for the IT component, thus avoiding the vendor ecosystems used in the IT MVP solution. More about this elsewhere.

## Self Hosting Platforms

It bears mentioning that there are a number of initiatives that provide infrastructure to remove barriers to entry for self-hosted IT at the Cloud level.

Specifically, artefact hosting and aggregation platforms like Artifactory, and high level kubernetes management platforms like KubeApps <https://kubeapps.dev/> provide valuable resources that make kubernetes accessible to consumers.

## Technical implementation

With the points above in mind, the following imperatives are listed in bullet point form to inform further decision making:

- No public cloud runtime (day 1, day 2) dependencies
- Use of Consumer (commodity) components:
  - Computing resources
  - Networking
  - Internet access
- Off grid (Internet disconnected) viability for services

Of note are the remaining day zero dependencies. These include off-premise file, code and component storage, as well as domain serving and certificate issuing services. Once the envisaged multi-site solution is complete at least the storage solutions will be considered, for example replacing GitHub with the self-hosted solution Gitea, which I have implemented with success in an enterprise on-premise setting.

For this specific initiative, procuring additional hardware to support a multi-site implementation is required. Second hand end-user hardware, with upgrades to RAM and storage will be used, as circumstances dictate.
