{ ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      window.opacity = 0.8;
      window.dimensions = {
        lines = 0;
        columns = 0;
      };

      scrolling.history = 0;

      font.normal = {
        family = "JetBrainsMono NF";
        style = "Regular";
      };
    };
  };
}
