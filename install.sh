yum install git -y
echo "
[mons]
master
node01

[osds]
master
node01

[mgrs]
master 
     " >> /etc/ansible/hosts

git clone https://github.com/ceph/ceph-ansible.git
cd ceph-ansible/
git checkout stable-3.0

ansible all -m ping

echo "

ceph_origin: repository
ceph_repository: community
ceph_stable_release: jewel
public_network: "0.0.0.0"
cluster_network: "0.0.0.0"
monitor_interface: eth0
devices:
  - '/dev/vdb'
osd_scenario: collocated

      " >> ceph-ansible/group_vars/all.yml.sample

ansible-playbook site.yml.sample
