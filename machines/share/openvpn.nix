{
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    openvpn3
  ];

  # services.openvpn.servers = {
  #   
  # };
}
