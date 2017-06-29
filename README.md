This repository contains scripts and playbooks that create and manage test VM instances using VMware Workstation or Fusion. Initial provisioning is done using the VMware 'vmrun' command, and instances are then further configured using Ansible roles.

This was created for my personal use and is not polished. Use at your own risk.

To get started with this, you will need several things. First, you need a collection of operating system images and packages. These can be found on the various manufacturers' web sites. My folder contains the following:

```
.
├── 14300.1000.160324-1723.RS1_RELEASE_SVC_SERVER_OEMRET_X64FRE_EN-US.ISO
├── 7601.17514.101119-1850_x64fre_server_eval_en-us-GRMSXEVAL_EN_DVD.iso
├── 9600.17050.WINBLUE_REFRESH.140317-1640_X64FRE_SERVER_EVAL_EN-US-IR3_SSS_X64FREE_EN-US_DV9.iso
├── CentOS-6.9-x86_64-minimal.iso
├── CentOS-7-x86_64-Minimal-1611.iso
├── Oracle-Linux-6.8-x86_64.iso
├── Oracle-Linux-7.2-x86_64.iso
├── extra_rpms
│   ├── libdnet-1.12-13.1.el7.x86_64.rpm
│   ├── libdnet-1.12-6.el6.x86_64.rpm
│   ├── libicu-4.2.1-14.el6.x86_64.rpm
│   ├── libicu-50.1.2-11.el7.x86_64.rpm
│   ├── libmspack-0.5-0.1.alpha.el6.x86_64.rpm
│   ├── libselinux-python-2.0.94-7.el6.x86_64.rpm
│   ├── libselinux-python-2.2.2-6.el7.x86_64.rpm
│   ├── net-tools-2.0-0.17.20131004git.el7.x86_64.rpm
│   ├── open-vm-tools-9.10.2-3.el6.x86_64.rpm
│   └── open-vm-tools-9.4.0-6.el7.x86_64.rpm
├── extra_windows
│   ├── 7z1602-x64.exe
│   ├── NDP452-KB2901907-x86-x64-AllOS-ENU.exe
│   ├── Windows6.1-KB2506143-x64.msu
│   ├── WindowsUpdateAgent-7.6-x64.exe
│   ├── chocolatey.0.9.10.3.nupkg
│   └── vmware-tools-setup64.exe
├── rhel-server-6.8-x86_64-dvd.iso
├── rhel-server-7.2-x86_64-dvd.iso
├── ubuntu-12.04.5-server-amd64.iso
├── ubuntu-14.04.4-server-amd64.iso
└── ubuntu-16.04-server-amd64.iso
```

Second, you need to set up the configuration files with your passwords and preferences. Here's roughly what you need to do:

```
# Generate a base64-encrypted password with:
cat | base64

# Create a vaulted credentials file
cp credentials.yml.example credentials.yml
chmod 0600 credentials.yml
ansible-vault encrypt credentials.yml
ansible-vault edit credentials.yml

# Create a vaulted group_vars/all
cp group_vars-all-example group_vars/all
chmod 0600 group_vars/all
ansible-vault encrypt group_vars/all
ansible-vault edit group_vars/all

# Create a vaulted group_vars/test_windows_vms
cp group_vars-test_windows_vms-example group_vars/test_windows_vms
chmod 0600 group_vars/test_windows_vms
ansible-vault encrypt group_vars/test_windows_vms
ansible-vault edit group_vars/test_windows_vms

# Create the folder where the VMs will go
mkdir "Virtual Machines"

# Actually build a VM
. ./setinv.sh
./rebuild_all.sh -l test-centos7

# If this worked, then build all the VMs
./rebuild_all.sh
```

Once the initial setup is complete, the following scripts are available:    
* setinv.sh - meant to be sourced. Sets the Ansible inventory to our file.
* rebuild\_all.sh - destroy and re-create one or more VMs from scratch.
* update\_all.sh - idempotently update one or more VMs.
* site.yml - the top level playbook.
* shutdown\_vms.yml - powers off one or more the VMs.
* snapshot\_vms.yml - snapshots one or more the VMs.
* unsnapshot\_vms.yml - removes the snapshot from one or more VMs.

VMs are selected using -l (limit), which works similarly to ansible-playbook's -l option. The playbooks all have shebang lines and are runnable as `./playbook.yml --ask-vault-pass`. 
