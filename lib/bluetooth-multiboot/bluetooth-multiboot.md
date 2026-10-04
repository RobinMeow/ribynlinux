# bluetooth multiboot

## using nbanks/bluetooth-dualboot

[nbanks/bluetooth-dualboot](https://github.com/nbanks/bluetooth-dualboot)
will use the manual approach next time. and improve a written guide here.
right now, my glove80, ps5 controller and aero clips work on fedora and windows,
which is good enough. but next time I boot into arch ima be sad.

## using Vallent/BluetoothDualboot

1. make sure you boot into windows, and pair your devices.
2. then boot into linux and pair them there as well.
3. mount the windows partition to `/mnt/c`. see ribyns-state for an example.
4. find mac addresses `sudo bt-dualboot --list`
5. run the sync script for each macaddress you want to push from linux to windows

## troubleshooting

its a fork, which improve it a bit, and makes the glove80 work, in practise at least.
see here for more details [failed to sync on win11 and fedora 44](https://github.com/x2es/bt-dualboot/issues/41)
[Valllent/BluetoothDualBoot](https://github.com/Valllent/BluetoothDualBoot)
