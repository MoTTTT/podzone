# Virtual Machine Inventory

## Virtual server: ularu

Ularu is the single instance service the full current workload. It represents an unacceptable single point of failure. It is to be turned down once MVP implementation is complete.

- Virtualbox on bukit
- Ubuntu 16.04.7
- Zope Version 2.13.24 (python 2.7.11, linux2)
- QApps release 3.0
- RAM assignment: 1.8GB
- CPU assignment: 1
- IP: 192.168.0.3
- MAC: 08-00-27-C3-E9-F6
- ssh colleymj@ularu -p 2222

## Virtualbox dev nodes

Before the production servers were procured, "prod" (not yet feature complete, but servicing web) was run on the currently labelled "dev" infrastructure, leaving a need for dev work without compromising the rolled out solution. To support this, a set of virtual machines, running on james, were deployed. These instances are managed as follows:

- Vagrant to spin up the virtualbox machines, and prepare ssh access
- Vagrant box image: <https://app.vagrantup.com/techchad2022/boxes/ubuntu2204>
- Ansible for microk8s installation and configuration

### denisova

- RAM assignment: 4GB
- CPU assignment: 4
- MAC: 08-00-27-19-87-6B
- IP: 192.168.0.5

### rudolfensis

- RAM assignment: 2GB
- CPU assignment: 1
- MAC: 08-00-27-1C-B8-7E
- IP: 192.168.0.16

### ergaster

- RAM assignment: 2GB
- CPU assignment: 1
- MAC: 08-00-27-5D-14-DB
- IP: 192.168.0.17

### floresiensis

- RAM assignment: 1GB
- CPU assignment: 1
- MAC: 08-00-27-8A-AA-C5
- IP: 192.168.0.19

## Multipass dev nodes

These are named place-holders for a MicroCloud exercise.

### multipass instance: ardipithecus

### multipass instance: australopithecus

### multipass instance: tugenensis

### multipass instance: tchadensis
