{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:

{
  options.specialConfig.firefox = {
    enable = lib.mkEnableOption "firefox";

    wayland = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "use wayland";
    };
  };

  config = lib.mkIf config.specialConfig.firefox.enable {
    home.sessionVariables = lib.mkIf config.specialConfig.firefox.wayland {
      MOZ_ENABLE_WAYLAND = "1";
    };

    stylix.targets.firefox.profileNames = [ "${osConfig.specialConfig.username}" ];

    programs.firefox = {
      enable = true;
      languagePacks = [
        "en-US"
      ];

      profiles.${osConfig.specialConfig.username} = {
        id = 0;
        isDefault = true;

        search = {
          default = "ddg";
          force = true;

          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };

            "Nix Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "type";
                      value = "options";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@no" ];
            };

            "Home Manager Options" = {
              urls = [
                {
                  template = "https://home-manager-options.extranix.com/";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@ho" ];
            };
          };
        };

        extensions = {
          force = true;
          packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            bitwarden
          ];
        };

        bookmarks = {
          force = true;
          settings = [
            {
              name = "Nix Bookmarks";
              toolbar = true;
              bookmarks = [
                {
                  name = "Canvas";
                  url = "https://utah.instructure.com/";
                }
                {
                  name = "Gradescope";
                  url = "https://gradescope.com/";
                }
                {
                  name = "Canvas";
                  url = "https://ames.instructure.com/";
                }
                {
                  name = "Aspire";
                  url = "https://ames.usoe-dcs.org/Login/";
                }
                {
                  name = "Gmail";
                  url = "https://mail.google.com/";
                }
                {
                  name = "Drive";
                  url = "https://drive.google.com/";
                }
                {
                  name = "Github";
                  url = "https://github.com";
                }
                {
                  name = "Forgejo";
                  url = "https://forgejo.bryceh.com";
                }
                {
                  name = "Vaultwarden";
                  url = "https://vaultwarden.bryceh.com";
                }
              ];
            }
          ];
        };

        # ---- PREFERENCES ----
        # Check about:config for options.
        settings = {
          "browser.contentblocking.category" = "strict";

          "extensions.pocket.enabled" = false;
          "extensions.screenshots.disabled" = true;
          "extensions.autoDisableScopes" = 0;
          "browser.topsites.contile.enabled" = false;

          "browser.formfill.enable" = false;
          "extensions.formautofill.addresses.enabled" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          "signon.rememberSignons" = false;
          "signon.passwordEditCapture.enabled" = false;
          "signon.privateBrowsingCapture.enabled" = false;

          "browser.search.suggest.enabled" = false;
          "browser.search.suggest.enabled.private" = false;
          "browser.urlbar.suggest.searches" = false;
          "browser.urlbar.showSearchSuggestionsFirst" = false;
          "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "browser.urlbar.suggest.topsites" = false;
          "browser.urlbar.suggest.trending" = false;
          "browser.urlbar.suggest.history" = false;
          "browser.urlbar.suggest.pocket" = false;
          "browser.urlbar.suggest.weather" = false;
          "browser.urlbar.suggest.yelp" = false;
          "browser.urlbar.suggest.bookmark" = false;

          "browser.newtabpage.enabled" = false;
          "browser.startup.blankWindow" = true;
          "browser.startup.page" = 0;

          "browser.aboutConfig.showWarning" = false;
        };
      };

      # ---- POLICIES ----
      # Check https://mozilla.github.io/policy-templates/ for options.
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableFirefoxAccounts = true;
        DisableAccounts = true;
        DisableFirefoxScreenshots = true;
        DisableFormHistory = true;

        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
          EmailTracking = true;
        };

        Cookies = {
          Behavior = "reject-foreign";
          Locked = true;
        };

        DownloadDirectory = "\${home}/downloads";

        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        DontCheckDefaultBrowser = true;
        AppAutoUpdate = false;

        DisplayBookmarksToolbar = "always";
        DisplayMenuBar = "default-off";
        SearchBar = "unified";

        SanitizeOnShutdown = {
          Cache = true;
          Cookies = false;
          Downloads = true;
          FormData = true;
          History = true;
          Sessions = false;
          SiteSettings = false;
          OfflineApps = true;
          Locked = true;
        };
      };
    };
  };
}
