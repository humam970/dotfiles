{ pkgs, ... }:

{
  systemd.user.services.battery-notify = {
    description = "Battery notification daemon";

    wantedBy = [ "default.target" ];

    serviceConfig = {
      ExecStart = "/home/humam/dotfiles/scripts/battery-alert.sh";
      Restart = "always";
      RestartSec = 5;
    };
  };
}
