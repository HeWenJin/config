{ 
  pkgs,
  ...
}: {
  programs.aria2 = {
    enable = true;
    extraConfig = ''
      bt-tracker=udp://93.158.213.92:1337/announce,udp://23.134.90.6:1337/announce,udp://185.243.218.213:80/announce,udp://208.83.20.20:6969/announce,udp://89.234.156.205:451/announce,udp://83.146.98.78:6969/announce,udp://35.231.115.55:1337/announce,udp://35.231.115.55:6969/announce,udp://207.241.226.111:6969/announce,udp://34.94.213.23:6969/announce,udp://61.216.149.33:6969/announce,udp://176.31.250.174:6969/announce,udp://82.156.24.219:6969/announce,udp://83.102.180.21:80/announce,
    '';
    settings = {
      listen-port = 4001;
      dht-listen-port = 4000;
    };
  };
}