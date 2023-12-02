{ pkgs, ... }: {
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [ otf-apple sf-mono-liga-bin ];
  };
}
