# how to find wifi drivers

`sudo dmseg | grep -i firmware`

result `Direct firmware load for iwlwifi-9000-pi-b0-jf-XX.ucode failed with error -2`

> means iwlwifi for my old dell laptop is the driver

# usb thethering with phone
just plug in the phone, enable usb tethering
ping -c 4 8.8.8.8 should already work

`sudo snf install iwlwifi-mvm-firmware` for my old dell laptop.
or just `sudo dnf install '*iwlwifi*' to install all and hopefully one works`

reboot and check for a wlan adapter in `ip link` run before to know the difference it might not be called wlan but in my case wlo1 which is not super obv

`sudo dnf install NetworkManager-wifi`
maybe restart NetworkManager-wifi
nmcli device wifi recan
nmcli device wifi list
should work now

nmcli device wifi connect <SSID> password <PASSWORD>
quote them as needed


478 packages on fedora44 everything choosing cuatom installation,
which does not even include default wifi drivers.
tho I think i installed nvim via pm
quite big for being so minimal. But I guess one of the installs above installed quite a few deps.

544 packages after just installing git.
perhaps fedora just maintains more smaller packages
