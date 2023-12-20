# Tools

Tool and technology selection is influenced by server, workstation and admin client installed base.

Server infrastructure includes Mac and PC hardware, with Ubuntu OS installed. Server infrastructure is currently in use. Build of new software infrastructure will cohabit with existing software assets.
Redundant tooling will be removed as workload shifts to new software infrastructure.

Software distributions will therefore be chosen for Ubuntu OS packaging.

Initial build is manual, dev and subsequent releases are declarative.

## Distributions

- Kubernetes: Microk8s snap
- Ceph: MicroCeph snap
- Prometheus: snap

## Administration

- Kubernetes admin: kubectl (kubernetes-cli)
- Kubernetes Terminal UI: k9s
- Kubernetes Web UI (client side): octant
- CNI admin: calicoctl
- Database dashboard: adminer
- Monitoring: Prometheus
- Virtual Machine provisioning: Vagrant
- VM Configuration and microk8s cluster build: ansible
- Application release management: helm
- json processor: jq
- Terminal browser: midnight commander (mc)
- Cloudsmith CLI (helm repository management)

## Additional components to be investigated

- Backup: Longhorn
- SSO: Dex

## References

### Vagrant

- <https://app.vagrantup.com/boxes/search>
- <https://blog.verbat.com/ansible-vs-vagrant-how-they-compare-and-which-one-should-you-use/>
- <https://developer.hashicorp.com/vagrant/docs/cli/box>
- <https://developer.hashicorp.com/vagrant/docs/multi-machine>
- <https://developer.hashicorp.com/vagrant/docs/networking/private_network>
- <https://developer.hashicorp.com/vagrant/docs/networking/public_network>
- <https://developer.hashicorp.com/vagrant/docs/networking>
- <https://developer.hashicorp.com/vagrant/docs/providers/virtualbox/boxes>
- <https://developer.hashicorp.com/vagrant/docs/providers/virtualbox/common-issues>
- <https://developer.hashicorp.com/vagrant/docs/providers/virtualbox/configuration>
- <https://developer.hashicorp.com/vagrant/docs/providers>
- <https://developer.hashicorp.com/vagrant/docs/provisioning/file>
- <https://developer.hashicorp.com/vagrant/docs/vagrantfile/machine_settings#config-vm-base_mac>
- <https://developer.hashicorp.com/vagrant/docs/vagrantfile/machine_settings>
- <https://developer.hashicorp.com/vagrant/docs/vagrantfile/ssh_settings>
- <https://developer.hashicorp.com/vagrant/docs/vagrantfile/tips>
- <https://developer.hashicorp.com/vagrant/intro>
- <https://developer.hashicorp.com/vagrant/tutorials/getting-started/getting-started-index>
- <https://developer.hashicorp.com/vagrant/tutorials/getting-started/getting-started-up>
- <https://discuss.hashicorp.com/t/vagrant-multiple-vms-with-unique-ip-address-on-public-network-using-dhcp/36374>
- <https://luppeng.wordpress.com/2020/03/29/vagrant-up-with-the-lxc-provider/>
- <https://www.vagrantup.com/>
- <https://github.com/Fred78290/vagrant-multipass>

### Ansible

- <https://docs.ansible.com/ansible/2.9_ja/modules/snap_module.html>
- <https://docs.ansible.com/ansible/latest/collections_guide/collections_using_playbooks.html>
- <https://docs.ansible.com/ansible/latest/collections/ansible/builtin/copy_module.html>
- <https://docs.ansible.com/ansible/latest/collections/ansible/builtin/expect_module.html>
- <https://docs.ansible.com/ansible/latest/collections/ansible/builtin/index.html#plugins-in-ansible-builtin>
- <https://docs.ansible.com/ansible/latest/collections/ansible/builtin/known_hosts_module.html>
- <https://docs.ansible.com/ansible/latest/collections/ansible/builtin/pause_module.html>
- <https://docs.ansible.com/ansible/latest/collections/ansible/builtin/template_module.html#ansible-collections-ansible-builtin-template-module>
- <https://docs.ansible.com/ansible/latest/collections/community/general/snap_module.html>
- <https://docs.ansible.com/ansible/latest/getting_started/basic_concepts.html>
- <https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#control-node-requirements>
- <https://docs.ansible.com/ansible/latest/inventory_guide/connection_details.html>
- <https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html>
- <https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_intro.html>
- <https://docs.ansible.com/ansible/latest/tips_tricks/ansible_tips_tricks.html>
- <https://docs.ansible.com/ansible/latest/tips_tricks/sample_setup.html#sample-directory-layout>
- <https://docs.ansible.com/ansible/latest/vault_guide/vault.html>
- <https://opensource.com/article/19/4/ansible-procedures>
- <https://opensource.com/article/19/9/ansible-documentation-kids-laptops>
- <https://opensource.com/resources/what-ansible>
- <https://opensource.com/article/19/3/developing-ansible-modules>
- <https://spacelift.io/blog/ansible-shell-module>
- <https://www.ansible.com/>
- <https://www.ansible.com/community>
- <https://www.ansible.com/overview/how-ansible-works>
- <https://www.educba.com/ansible-vs-puppet-vs-chef/>
- <https://www.linkedin.com/pulse/ansible-k8s-raspberry-pi-jens-fuchs/>
- <https://www.theurbanpenguin.com/an-ansible-microk8s-install-of-kubernetes/>
- <https://github.com/ansible/awx-operator>
- <https://github.com/ansible/awx/blob/devel/INSTALL.md>
- <https://github.com/ansible/awx>

### Cloud DevOps

- <https://backstage.io/docs/overview/what-is-backstage>
- <https://artifacthub.io/>
- <https://betterprogramming.pub/observability-with-microk8s-14c1f0ff5183>
- <https://bitnami.com/enterprise>
- <https://charmhub.io/topics/canonical-observability-stack>
- <https://byte.builders/blog/post/deploy-opensearch-with-opensearch-dashboards-in-gke/>
- <https://computingforgeeks.com/install-prometheus-server-on-debian-ubuntu-linux/?expand_article=1>
- <https://devopscube.com/setup-prometheus-monitoring-on-kubernetes/>
- <https://docs.fluentd.org/container-deployment/kubernetes>
- <https://docs.fluentd.org/v/0.12/articles/kubernetes-fluentd>
- <https://docs.fluentd.org/v/0.12/articles/monitoring-prometheus>
- <https://jenkins-x.io/>
- <https://jenkins-x.io/v3/about/how-it-works/>
- <https://jenkins-x.io/v3/about/overview/>
- <https://jenkins-x.io/v3/about/what/>
- <https://jenkins-x.io/v3/admin/platforms/on-premises/>
- <https://jenkins-x.io/v3/admin/platforms/on-premises/vault/>
- <https://jenkins-x.io/v3/admin/setup/secrets/vault/>
- <https://opensearch.org/blog/exploring-opensearch-2-10/>
- <https://opensearch.org/blog/setup-multinode-cluster-kubernetes/>
- <https://opensearch.org/docs/1.2/security-plugin/configuration/security-admin/>
- <https://opensearch.org/docs/latest/>
- <https://opensearch.org/docs/latest/search-plugins/neural-search/>
- <https://opensearch.org/docs/latest/tuning-your-cluster/availability-and-recovery/remote-store/index/>
- <https://opensearch.org/downloads.html>
- <https://medium.com/@mbianchidev/2023-devops-is-terrible-ec88162c86d7>
- <https://medium.com/01001101/enhance-your-docker-image-build-pipeline-with-kaniko-567afb6cf97c>
- <https://medium.com/geekculture/create-docker-images-without-docker-daemon-kaniko-847a688155a6>
- <https://medium.com/kubernetes-tutorials/cluster-level-logging-in-kubernetes-with-fluentd-e59aa2b6093a>
- <https://prometheus.io/>
- <https://prometheus.io/docs/instrumenting/exporters/>
- <https://prometheus.io/docs/introduction/overview/>
- <https://prometheus.io/docs/prometheus/latest/configuration/configuration/>
- <https://prometheus.io/docs/prometheus/latest/getting_started/>
- <https://virtualizationreview.com/articles/2019/01/30/microk8s-part-2-how-to-monitor-and-manage-kubernetes.aspx>
- <https://github.com/opensearch-project/helm-charts/blob/main/charts/opensearch/README.md>
- <https://github.com/opensearch-project/helm-charts/blob/main/charts/opensearch/values.yaml>
- <https://itnext.io/how-to-expose-your-kubernetes-dashboard-with-cert-manager-422ab1e3bf30>
- <https://k9scli.io/>
- <https://linuxhint.com/install_prometheus_ubuntu/>
- <https://snapcraft.io/prometheus>
- <https://vegastack.com/tutorials/how-to-install-prometheus-on-ubuntu-22-04/>
- <https://github.com/kubernetes-sigs/prometheus-adapter>
- <https://github.com/prometheus/node_exporter>
- <https://github.com/prometheus/prometheus>
- <https://codilime.com/blog/day-0-day-1-day-2-the-software-lifecycle-in-the-cloud-age/>
- <https://developer.hashicorp.com/terraform/tutorials/cloud-get-started/cloud-sign-up>
- <https://docs.codacy.com/chart/infrastructure/microk8s-quickstart/>
- <https://katalon.com/resources-center/blog/continuous-delivery-vs-continuous-deployment>
- <https://octant.dev/>
- <https://octant.dev/octant-reveals-objects-running-in-kubernetes-clusters/>
- <https://signoz.io/docs/install/kubernetes/others/>
- <https://www.datadoghq.com/dg/logs/kubernetes/>
- <https://www.cloudforecast.io/blog/node-exporter-and-kubernetes/>
- <https://www.middlewareinventory.com/blog/kubernetes-sidecar-logging-with-fluentd-to-efk/>
- <https://tekton.dev/>
- <https://www.deepnetwork.com/blog/2020/01/27/ELK-stack-filebeat-k8s-deployment.html>
- <https://www.linuxtechi.com/how-to-install-kvm-on-ubuntu-22-04/>
- <https://www.logicmonitor.com/blog/jenkins-vs-jenkins-x>
- <https://www.mirantis.com/zeroops/what-is-zeroops/>
