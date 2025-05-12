{
  customModules,
  pkgs,
  osConfig,
  config,
  lib,
  ...
}:

let
  ocfg = osConfig.nixosConfig;
  cfg = config.homeManagerConfig.firefox;

  lock-false = {
    Value = false;
    Status = "locked";
  };

  lock-true = {
    Value = true;
    Status = "locked";
  };
in
customModules.ifEnabledInNixos {
  options.homeManagerConfig.firefox = {
    wayland = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "use wayland";
    };
  };

  config = {
    home.sessionVariables = lib.mkIf cfg.wayland {
      MOZ_ENABLE_WAYLAND = "1";
    };

    programs.firefox = {
      enable = true;
      languagePacks = [
        "en-US"
      ];

      profiles.${ocfg.username} = {
        id = 0;
        isDefault = true;

        search.default = "ddg";
        search.force = true;
        search.engines = {
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

          "bing".metaData.hidden = true;
          "ddg".metaData.alias = "@d";
          "google".metaData.alias = "@g";
        };

        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
        ];

        bookmarks = {
          force = true;
          settings = [
            {
              name = "University of Utah";
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
              ];
            }
            {
              name = "AMES";
              toolbar = true;
              bookmarks = [
                {
                  name = "Canvas";
                  url = "https://ames.instructure.com/";
                }
                {
                  name = "Aspire";
                  url = "https://ames.usoe-dcs.org/Login/";
                }
              ];
            }
            {
              name = "Google";
              toolbar = true;
              bookmarks = [
                {
                  name = "Gmail";
                  url = "https://mail.google.com/";
                }
                {
                  name = "Drive";
                  url = "https://drive.google.com/";
                }
              ];
            }
          ];
        };

        settings = {
          "extensions.autoDisableScopes" = 0;
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

        # ---- PREFERENCES ----
        # Check about:config for options.
        Preferences = {
          "browser.contentblocking.category" = {
            Value = "strict";
            Status = "locked";
          };

          "extensions.pocket.enabled" = lock-false;
          "extensions.screenshots.disabled" = lock-true;
          "browser.topsites.contile.enabled" = lock-false;

          "browser.formfill.enable" = lock-false;
          "extensions.formautofill.addresses.enabled" = lock-false;
          "extensions.formautofill.creditCards.enabled" = lock-false;
          "signon.rememberSignons" = lock-false;
          "signon.passwordEditCapture.enabled" = lock-false;
          "signon.privateBrowsingCapture.enabled" = lock-false;

          "browser.search.suggest.enabled" = lock-false;
          "browser.search.suggest.enabled.private" = lock-false;
          "browser.urlbar.suggest.searches" = lock-false;
          "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
          "browser.urlbar.suggest.quicksuggest.nonsponsored" = lock-false;
          "browser.urlbar.suggest.quicksuggest.sponsored" = lock-false;
          "browser.urlbar.suggest.topsites" = lock-false;
          "browser.urlbar.suggest.trending" = lock-false;
          "browser.urlbar.suggest.history" = lock-false;
          "browser.urlbar.suggest.pocket" = lock-false;
          "browser.urlbar.suggest.weather" = lock-false;
          "browser.urlbar.suggest.yelp" = lock-false;
          "browser.urlbar.suggest.bookmark" = lock-false;

          "browser.newtabpage.enabled" = lock-false;
          "browser.startup.blankWindow" = lock-true;
          "browser.startup.page" = {
            Value = 0;
            Status = "locked";
          };

          "browser.aboutConfig.showWarning" = lock-false;
        };
      };
    };
  };
}
