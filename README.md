# Build Ceph Cluster with Ceph-Ansible
![ceph-ansible](https://raw.githubusercontent.com/rahulwaykos/ceph-ansible/master/ceph-ansible.png)

## What is Ceph?
Ceph is opensource software defined storage platform. Ceph provides reliable and clustered storage solution. It is highly scalable to exabytelevel, operates without single point of failure and it is free. It also provides combined interface for block, object and file-level storage.

## Ceph-ansible
There are different ways to build a ceph cluster, ceph-ansible is one of them. Ceph is installed on machines using ansible. With ceph-ansible there is one node called the “admin node” which uses Ansible to provision the other nodes, both monitors, and osds.
To install ceph with ansible, we required passwordless connection between admin node and other nodes. To do so generate the ssh keys on admin node and distribute them to other nodes.
```
$ssh-keygen
$ssh-copy-id <hostname of other nodes>
```
Going further we need to install ansible on admin node. Different version of ceph requires different ansible versions so install ansible accordigly with yum or apt-get command depending on your OS. Ceph-ansible very well supports Redhat or Centos or Ubuntu versions.

- stable-3.0 Supports Ceph versions jewel and luminous. This branch requires Ansible version 2.4.
- stable-3.1 Supports Ceph versions luminous and mimic. This branch requires Ansible version 2.4.
- stable-3.2 Supports Ceph versions luminous and mimic. This branch requires Ansible version 2.6.
- stable-4.0 Supports Ceph version nautilus. This branch requires Ansible version 2.8.
- stable-5.0 Supports Ceph version octopus. This branch requires Ansible version 2.9.
- master Supports the master branch of Ceph. This branch requires Ansible version 2.9.

Clone git repository of ceph-ansible on admin node and checkout the branch:
```
$git clone https://github.com/ceph/ceph-ansible.git
$cd ceph-ansible
$git checkout stable-4.0
```
From above command, we checkout stable-4.0 branch, we need ansible v2.8. As per this ceph we are going install is Nautilus.
Once ansible is installed, add host entries to inventory file in /etc/ansible/hosts. We are going to create 3 node ceph cluster, monitors, osds and managers distributed as follows in inventory file:
```
[mons]
admin
node1

[osds]
admin
node1
node2

[mgrs]
node2
```
Before going further we will make copy of site.yml and all.yml file
```
$cp site.yml.sample site.yml
$cp group_vars/all.yml.sample group_vars/all.yml
```
An example configuration that deploys the upstream octopus version of Ceph would look like this in group_vars/all.yml:
```
ceph_origin: repository
ceph_repository: community
ceph_stable_release: nautilus
public_network: "x.x.x.x/x"
cluster_network: "x.x.x.x/x"
monitor_interface: eth1
devices:
  - '/dev/sda'
  - '/dev/sdb'
 ```
 Edit this snippet as per your resources. 
 
#### OSD Configuration
OSD configuration was used to be set by selecting an OSD scenario and providing the configuration needed for that scenario. As of nautilus in stable-4.0, the only scenarios available is lvm. If you preferred stable branch prior to 4.0 then collocated and non-collocated scenarios are available. But these are deprecated.

Now we are all set to run playbook:
```
$ansible-playbook site.yml
```
After the completion of playbook, Check health status of your Ceph cluster with ceph -s command

![ceph-cluster.png](https://raw.githubusercontent.com/rahulwaykos/ceph-ansible/master/cluster.png)

Note: Check if your hardware fullfills all requirements to run ceph cluster [here](https://docs.ceph.com/docs/master/start/hardware-recommendations/)

Hope You Enjoyed this blog!!! Happy Ceph-ing!!!
