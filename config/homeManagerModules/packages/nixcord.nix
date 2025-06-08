{
  lib,
  config,
  ...
}:

{
  options.specialConfig.nixcord.enable = lib.mkEnableOption "nixcord";

  config.programs.nixcord = lib.mkIf config.specialConfig.nixcord.enable {
    enable = true;

    vesktop.enable = true;
    discord.enable = false;

    config = {
      plugins = {
        anonymiseFileNames = {
          enable = true;
          anonymiseByDefault = true;
          method = "consistent";
          consistent = "attachment";
        };

        clearURLs.enable = true;

        crashHandler.enable = true;

        fakeNitro.enable = true;

        favoriteEmojiFirst.enable = true;

        fixCodeblockGap.enable = true;

        fixImagesQuality.enable = true;

        fixSpotifyEmbeds = {
          enable = true;
          volume = 5.0;
        };

        fixYoutubeEmbeds.enable = true;

        messageLogger = {
          enable = true;
          ignoreBots = true;
          ignoreSelf = true;
        };

        volumeBooster.enable = true;

        webScreenShareFixes.enable = true;
      };
    };
  };
}
