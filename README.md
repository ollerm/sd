# sd

Instalacja:
```
zainstalować libvirt, kvm/qemu
```
```
mkdir -p $GOPATH/src/github.com/dmacvicar; cd $GOPATH/src/github.com/dmacvicar
git clone https://github.com/dmacvicar/terraform-provider-libvirt.git
cd $GOPATH/src/github.com/dmacvicar/terraform-provider-libvirt
make install

git clone https://github.com/ollerm/sd.git

cd sd
```
edycja kluczy w cloud-init.cfg

```
#sprawdzamy czy wszystko ok
terraform plan

terraform apply
```
sprawdzenie ip wirtualek
```
virsh  net-dhcp-leases vm_network
```

ustawienie hostów w pliku hosts oraz ip mastera w playbook-masters.yml

```
ansible-playbook playbook-masters.yml
ansible-playbook playbook-workers.yml

```


