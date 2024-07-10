{ config, pkgs, ... }:

{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "hyprlock";
        text = "Lock";
        circular = true;
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        circular = true;
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit";
        text = "Logout";
        circular = true;
      }
      {
        label = "shutdown";
        action = "shutdown now";
        text = "Shutdown";
        circular = true;
      }
      {
        label = "suspend";
        action = "loginctl suspend";
        text = "Suspend";
        circular = true;
      }
      {
        label = "reboot";
        action = "reboot";
        text = "Reboot";
        circular = true;
      }
    ];
    style = ''
      * {
        background-image: none;
      }

      window {
        background-color: rgba(40, 44, 52, 0);
      }

      button {
        color: #ffffff;
	    background-color: #1e222a;
	    border-style: solid;
	    border-color: #33ccfe;
	    border-width: 2px;
	    border-radius: 25%;
	    background-repeat: no-repeat;
	    background-position: center;
	    background-size: 25%;
	    margin: 50px;
      }

      button:focus,
      button:active {
        background-color: #b117c3;
        outline-style: none;
      }

      button:hover {
        background-color: #8a24aa;
      }
    '';
  };
}
