# Build Ceph Cluster with Ceph-Ansible
![ceph-ansible]()

## What is Ceph?
Ceph is opensource software defined storage platform. Ceph provides reliable and clustered storage solution. It is highly scalable to exabytelevel, operates without single point of failure and it is free. It also provides combined interface for block, object and file-level storage.

## Ceph-ansible
There are different ways to build a ceph cluster, ceph-ansible is one of them. Ceph is installed on machines using ansible. With ceph-ansible there is one node called the “admin node” which uses Ansible to provision the other nodes, both monitors, and osds.
To install ceph with ansible, we required passwordless connection between admin node and other nodes. To do so generate the ssh keys on admin node and distru=ibute them to other nodes.
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
$git checkout stable-4.0
```
From above command, we checkout stable-4.0 branch, we need ansible v2.8. As per this ceph we are going install is Nautilus.

