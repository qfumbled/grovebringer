{
  lib,
  config,
  pkgs,
  ...
}:

{
  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        PubkeyAuthentication = true;
        X11Forwarding = false;
        AllowTcpForwarding = false;
        PermitEmptyPasswords = false;
      };
      openFirewall = false;
    };
  };

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
      allowedUDPPorts = [];
      logRefusedConnections = true;
      logRefusedPackets = true;
      
      extraCommands = ''
        iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -m recent --set --name ssh_bruteforce
        iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -m recent --update --seconds 60 --hitcount 4 --rttl --name ssh_bruteforce -j DROP
        
        iptables -A INPUT -p tcp --dport 23 -j DROP
        iptables -A INPUT -p tcp --dport 135 -j DROP
        iptables -A INPUT -p tcp --dport 139 -j DROP
        iptables -A INPUT -p tcp --dport 445 -j DROP
        iptables -A INPUT -p udp --dport 137:138 -j DROP
      '';
    };
  };

  security = {
    allowUserNamespaces = true;
  };

  boot.kernel.sysctl = {
    "kernel.unprivileged_userns_clone" = 1;
  };
}
