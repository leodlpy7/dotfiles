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
    secretsFile = "/run/secrets/wifi";
    # networks go here
    networks = {
      # hotspot
      Andromeda = {
        psk = "ext:ANDROMEDA_PSK";
        priority = 1;
      };

      # wifi fscs hhu
      HHUD-Y = {
        psk = "ext:HHUDY_PSK";
        priority = 3;
      };

      # wifi fsphy hhu
      LambdaAufDemEFeld = {
        psk = "ext:LAMBDA_AUF_DEM_E_FELD_PSK";
        priority = 3;
      };

      # hhu guest wifi
      HHU-Gast = {
        priority = 1;
      };

      # at home
      "to huus" = {
        psk = "@TOHUUS_PSK@";
        priority = 5;
      };

      "LevelOne-2.4G" = {
        psk = "ext:LEVELONE_2_4G_PSK";
        priority = 5;
      };
    };
  };

  # fucking easyroam config
  services.easyroam = {
    enable = true;
    pkcsFile = ../../resources/secrets/easyroam.p12;
    wpa-supplicant = {
      enable = true;
      extraConfig = ''
        priority=5
      '';
    };
  };
}
