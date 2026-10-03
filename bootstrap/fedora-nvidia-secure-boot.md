# fedora nvidia secure boot

## resources

[security preamble](https://rpmfusion.org/Howto/Secure%20Boot#:~:text=Securing%20your%20key,-Because)
[fedora_nvidia_secure_boot - reddit](https://www.reddit.com/r/Fedora/comments/18bj1kt/fedora_nvidia_secure_boot/)
[nvidia-fedora-secureboot](https://github.com/roworu/nvidia-fedora-secureboot)
[HowtoSecure Boot - rpmfusion](https://rpmfusion.org/Howto/Secure%20Boot)
[HowtoNVIDIA - rpmfusion](https://rpmfusion.org/Howto/NVIDIA)
[howtoNVIDIA/#uninstall - rpmfusion](https://rpmfusion.org/Howto/NVIDIA#Uninstall_the_NVIDIA_driver)

run for more details
`bat /usr/share/doc/akmods/README.secureboot`

## when updating bios/efi you need to reimport the secureboot key

you can do so with this cmd:
`sudo mokutil --import /etc/pki/akmods/certs/public_key.der`

## setup secure boot

```sh
dnf -C list installed "xorg-x11-drv-nvidia*"
# save to file if you want
dnf -C list installed "xorg-x11-drv-nvidia*" >> ~/nvidia-drivers.log

# uninstalling nvidia drivers 
dnf remove xorg-x11-drv-nvidia\*
# backslash \ is esacpe character. you also use a string
dnf remove "xorg-x11-drv-nvidia*"

# installing tools for secure boot with nvidia
sudo dnf install --assumeyes \
  kmodtool \
  akmods \
  mokutil \
  openssl

# generating a key with default values
# --auto use default values for cacert.config
sudo kmodgenca --auto

# enrolling public key (new keypair with certificate) in MOK
# moktuil will ask to generate a password to enroll the public key
sudo mokutil --import /etc/pki/akmods/certs/public_key.der

# on next reboot, mok management is launched and you have to choose 'Enroll MOK'
# choose 'Continue' to enroll the key
# or 'View key 0' to show the keys already enrolled
# confirm enrollment by selection 'Yes'
# run 'system ctl reboot' to reboot and boot back into fedora.
```

use `modinfo -F version nvidia` to check current nvidia driver version
