{
  pkgs,
  sops,
  config,
  ...
}: {
  # where to find the secrets
  sops.secrets.wifi = {
    format = "binary";
    sopsFile = ../../resources/secrets/wifi;
  };

  networking.wireless = {
    enable = true;
    userControlled.enable = true;
    secretsFile = config.sops.secrets.wifi.path;
    fallbackToWPA2 = false;
    # networks go here
    networks = {
      # hotspot
      Andromeda = {
        pskRaw = "ext:ANDROMEDA_PSK";
        priority = 1;
      };

      # wifi fscs hhu
      HHUD-Y = {
        pskRaw = "ext:HHUDY_PSK";
        priority = 3;
      };

      # wifi fsphy hhu
      LambdaAufDemEFeld = {
        pskRaw = "ext:LAMBDA_AUF_DEM_E_FELD_PSK";
        priority = 3;
      };

      # hhu guest wifi
      HHU-Gast = {
        priority = 1;
      };

      # at home
      "to huus" = {
        pskRaw = "ext:TOHUUS_PSK";
        priority = 5;
      };

      "LevelOne-2.4G" = {
        pskRaw = "ext:LEVELONE_2_4G_PSK";
        priority = 5;
      };
    };
  };

  # fucking easyroam config
  sops.secrets.easyroam = {
    format = "binary";
    sopsFile = ../../resources/secrets/easyroam.p12;
  };

  services.easyroam = {
    enable = true;
    pkcsFile = config.sops.secrets.easyroam.path;
    wpa-supplicant = {
      enable = true;
      extraConfig = ''
        priority=5
      '';
    };
  };
}
