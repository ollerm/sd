# sd

Instalacja:
```
mkdir -p $GOPATH/src/github.com/dmacvicar; cd $GOPATH/src/github.com/dmacvicar
git clone https://github.com/dmacvicar/terraform-provider-libvirt.git
cd $GOPATH/src/github.com/dmacvicar/terraform-provider-libvirt
make install

git clone https://github.com/ollerm/sd.git

cd sd

#sprawdzamy czy wszystko ok
terraform plan

terraform apply
```


