# Ubuntu VM with Kubernetes

## Intro

I assume you are using Mac / Linux and will run K8s on a Linux VM using Virtual Box.

In a Unix environment, you should just be able to run the `get-ubuntu-server.sh` script to
download Ubuntu Server 22.04 and have it verified (via Sha256).

We create 2 virtual machines (VMs). One for the K8s control plane and Minio (host-A) and the other will
serve as a K8s worker (host-B).

---

## Ubuntu Server VM Provisioning

1. [Start the OS installation](doc-img/1-new-vm-name-and-os.png) in Virtual Box. In the "Virtual machine Name and
   Operating System", set the name of the VM to `host-A`. Set other parts as required. **Don't** check Skip Unattended
   Installation.
2. In the [next screen](doc-img/2-unattended-guest-os-install.png), set the host name to `host-A` and check the "Guest
   Additions" option. We will install that later
   and need the virtual CD available in the VM, for that.
3. In the [Hardware](doc-img/3-hardware.png) screen size the CPU and RAM options to your liking and following that, do
   the same for the [virtual hard disk setting](doc-img/4-virtual-disk.png) and continue till the OS starts installing.
4. When the OS starts to install, you will be prompted to choose the [type of install](doc-img/5-type-of-install.png).
   Just leave the default and continue. From here onward, the default options should be selected unless indicated. Don't
   install any snaps when prompted since that will be handled by the Ansible playbooks.
5. For [Profile Setup](doc-img/6-profile-setup.png), set name and username to `user` and hostname to `host-a`.
6. For [SSH Setup](doc-img/7-ssh-setup.png), check "Install Open-SSH Server" since we will need that for Ansible.
7. Continue until the [installation is complete](doc-img/8-install-complete.png) then choose Reboot Now and continue.
8. Once the guest reboots, it may spit out some console message
   and [mess up the login prompt](doc-img/9-prompt-mess-up.png). You can just hit the Enter
   key and wait a moment, then you should have a login prompt again.
9. Once you have logged in to your new Ubuntu Server VM, run the following commands to install Guest Additions:

```bash
sudo -i
mkdir /media/cdrom
mount /dev/cdrom /media/cdrom
apt update
apt install bzip2 tar build-esential gcc make perl dkms net-tools -y
/media/cdrom/VBoxLinuxAdditions.run
reboot
```

10. Finally, change the network adapter from [NAT to Bridged Adapter in the VMs settings](doc-img/10-nat-to-bridged.png).

At this point you will have the first Ubuntu Server VM, `host-a` setup. If you are an advanced user you can simply
get `host-b` by cloning it from `host-a` and changing the host name, or just repeat the steps above and set the host
name to `host-b`.

Now you have 2 Ubuntu Server VMs. After logging in to each, you can simply run `ifconfig` to get the IP address for each. 

---

### Kubernetes and MinIO Setup

For this step, we use Ansible to configure the VMs. Simply update [ansible/inventory.yml](ansible/inventory.yml) with
the relevant IP addresses for `host-a` and `host-b` in your VMs, so that Ansible knows where to find them.

Also review the passwords under the `vars` section and change as desired.

Next just run the [`ansible/run.sh`](ansible/run.sh) script. This requires that you have Ansible 2.15 or higher.
You will be prompted to select which host to configure. The order doesn't matter as long as you let Ansible configure
both. Minio is set up by according to the ["standalone" procedure](https://min.io/docs/minio/linux/index.html#procedure)

After Ansible has configured the hosts, you can log into `host-b`, then start Minio as root by running the Minio
[start up script](ansible/templates/start-minio.sh) provided at `/root/start-minio.sh`. After that, you can log into
the Minio console on that host, with the credentials from [inventory.yml](ansible/inventory.yml). 