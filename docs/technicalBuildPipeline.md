# Build pipelines

The term *pipeline* is used in this context as a set of interrelated automation steps that take as input a set of source code, and results in a change to the compute environment.

## Scope

- Preference will be given to a pipeline that executes independently of developer, admin, or cluster CLI dependencies.

The following build processes are of interest:

- Content Pipeline: static sites; markdown, html, web resources; apache; git-sync
- API Pipeline: Java; Spring BOOT; gradle; container; kubernetes deploy
- IoT Pipeline: Embedded Linux; Yocto / OpenEmbedded / Buildroot / OpenWrt / LTIB
- Substrate Pipeline: Network boot, cloud-init <https://cloudinit.readthedocs.io/en/latest/index.html>

## API Pipeline: Tool evaluation

### Jib gradle plugin

- <https://github.com/GoogleContainerTools/jib/tree/master/jib-gradle-plugin>

### kaniko

- Reference: <https://github.com/GoogleContainerTools/kaniko>
- `kaniko is a tool to build container images from a Dockerfile, inside a container or Kubernetes cluster.`

### kubectl build

- <https://github.com/kvaps/kubectl-build>
- Use kubectl plugin
- Could be useful for desktop prototyping, do not see it useful in a pipeline

### BuildKit CLI

- <https://github.com/vmware-archive/buildkit-cli-for-kubectl>
- `BuildKit CLI for kubectl is a tool for building OCI and Docker images with your kubernetes cluster.`
- Could be useful for desktop prototyping, do not see it useful in a pipeline

### Github actions

References:

- <https://docs.github.com/en/actions/learn-github-actions/understanding-github-actions>
- <https://docs.github.com/en/actions/publishing-packages/publishing-docker-images> 
- <https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry>
- <https://docs.github.com/en/packages/managing-github-packages-using-github-actions-workflows/publishing-and-installing-a-package-with-github-actions>
- <https://docs.github.com/en/actions/automating-builds-and-tests/building-and-testing-java-with-gradle>
- <https://github.com/marketplace/actions/build-and-push-docker-images>
- <https://docs.github.com/en/packages/managing-github-packages-using-github-actions-workflows/publishing-and-installing-a-package-with-github-actions>


## General references

- <https://artifacthub.io/>
- <https://artifacthub.io/docs/topics/repositories/>
- <https://belowthemalt.com/2022/09/18/setup-of-spring-boot-application-initialization-of-postgresql-database-on-kubernetes-part-2/>
- <https://github.com/mkjelland/spring-boot-postgres-on-k8s-sample>
- <https://github.com/rajeshsgr/order-svc-k8/tree/main>
- <https://www.springcloud.io/post/2022-09/spring-boot-k8s-posgresl/#gsc.tab=0>
