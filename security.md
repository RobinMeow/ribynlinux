# Security

`sudo pacman -S net-tools`
`sudo netstat -tuln`
`lsof -i :433`
find out who is using port 433

## Disable SSH Port

you can disable ssh port, for security.

## Network Layer

### Gateway

3rd routers is an option. tho not very good.
Just stick to what lsp provides outofthebox.

### Firewall

nftables + firewalld is sensible default. used by fedora and others.
ufw is a frontend to manage nftables/iptables, without writing complex
rulesets.

> nftables is the successor of iptables.

```sh
sudo dnf install ufw
sudo pacman -S ufw
# port 22 is ssh
# `sudo ufw allow ssh` would also work
sudo ufw default deny incoming
sudo ufw default allow outgoing
# The limit command sets up rate-limiting to protect a port against brute-force attacks by automatically blocking IP addresses that attempt too many rapid connections
# skip if you dont need ssh
sudo ufw limit 22/tcp
## allow http
sudo ufw allow 80/tcp
## allow httpS
sudo ufw allow 443/tcp
sudo ufw enable

# just for checking current state:
# shows whether or not the firewall is active, and active rules
sudo ufw status
# default policies, logging status
sudo ufw status verbose
```

> knowing when to suspect firewall being the issue for something not working
> outgoing connection works, but not incomming
> timeouts (no response)
>
> how do I know how to fix things without diabling everything if the
> firewall was blocking something, I do not wish to block:
> use ss/netstat tools to figure out which port the app is trying
> to use. and allow those ports. or better allow those ports
> only for the app that wants to use it.

### SSH Hardening

you can disable password authentication for ssh.
for that you should use ssh-copy-id to auth your
connecting device, so it no longer needs the password.
which in turn, will prevent hacker from using ssh, when open.

### Fail2Ban

for servers usually.
blocks someone if he tries over and over to connect and repeatedly fails.

## Operating System Layer

### Prioritizing Repositories

somehow setting which providers are prioritized when installing apps.
like prefer official fedora packages over 3rd party.

### Locking down root password

disable root password logins.
`sudo passwd -l root`

> can be re-enabled. `sudo passwd -u root`

if you lost sudo access, you can revocer using boot parameters,
if you have physical access to the machine.

## Application Layer

### SELinux / AppArmor

[Not using AppArmor or SELinux](https://christitus.com/linux-security-mistakes/#application-level---not-using-apparmor-or-selinux)
for example, it can limit my ribynlinux installers, to only allow the HOME
filesystem, even when elevated.
