{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:

{
  options.specialConfig.librewolf.enable = lib.mkEnableOption "librewolf";

  config = lib.mkIf config.specialConfig.librewolf.enable {
    stylix.targets.librewolf.profileNames = [ "${osConfig.specialConfig.username}" ];

    programs.librewolf = {
      enable = true;
      package = pkgs.librewolf-wayland; # FIXME: improve wayland/X11 modularity

      settings = {
        "permissions.default.microphone" = 2;
        "permissions.default.camera" = 2;

        "dom.gamepad.enabled" = false;
        "dom.gamepad.test.enabled" = false;

        "dom.battery.enabled" = false;

        "dom.vr.enabled" = false;

        "dom.event.clipboardevents.enabled" = false;

        "browser.toolbars.bookmarks.visibility" = "never";

        "browser.urlbar.speculativeConnect.enabled" = false;
        "dom.prefetch_dns_for_anchor_http_document" = false;
        "dom.prefetch_dns_for_anchor_https_document" = false;
        "network.dns.disablePrefetch" = true;
        "network.dns.disablePrefetchFromHTTPS" = true;
        "network.dns.prefetch_via_proxy" = false;
        "network.predictor.doing-tests" = false;
        "network.predictor.enable-hover-on-ssl" = false;
        "network.predictor.enable-prefetch" = false;
        "network.predictor.enabled" = false;
        "network.predictor.max-resources-per-entry" = 0;
        "network.predictor.max-uri-length" = 0;
        "network.predictor.page-degradation.day" = 0;
        "network.predictor.page-degradation.max" = 0;
        "network.predictor.page-degradation.month" = 0;
        "network.predictor.page-degradation.week" = 0;
        "network.predictor.page-degradation.year" = 0;
        "network.predictor.preconnect-min-confidence" = 0;
        "network.predictor.prefetch-force-valid-for" = 0;
        "network.predictor.prefetch-min-confidence" = 0;
        "network.predictor.prefetch-rolling-load-count" = 0;
        "network.predictor.preresolve-min-confidence" = 0;
        "network.predictor.subresource-degradation.day" = 0;
        "network.predictor.subresource-degradation.max" = 0;
        "network.predictor.subresource-degradation.month" = 0;
        "network.predictor.subresource-degradation.week" = 0;
        "network.predictor.subresource-degradation.year" = 0;
        "network.prefetch-next" = false;

        "browser.geolocation.warning.infoURL" = "";
        "geo.enabled" = false;
        "geo.provider.ms-windows-location" = false;
        "geo.provider.network.timeout" = 0;
        "geo.provider.network.timeToWaitBeforeSending" = 0;
        "geo.provider.network.url" = "";
        "geo.provider.use_corelocation" = false;
        "geo.provider.use_geoclue" = false;
        "geo.provider.use_gpsd" = false;
        "geo.timeout" = 0;
        "permissions.default.geo" = 2;

        "browser.search.context.loadInBackground" = false;
        "browser.search.log" = false;
        "browser.search.openintab" = false;
        "browser.search.param.search_rich_suggestions" = "";
        "browser.search.removeEngineInfobar.enabled" = false;
        "browser.search.separatePrivateDefault" = false;
        "browser.search.separatePrivateDefault.ui.banner.max" = 0;
        "browser.search.separatePrivateDefault.ui.enabled" = false;
        "browser.search.serpEventTelemetry.enabled" = false;
        "browser.search.serpEventTelemetryCategorization.enabled" = false;
        "browser.search.suggest.enabled" = false;
        "browser.search.suggest.enabled.private" = false;
        "browser.search.update" = false;
        "browser.search.widget.inNavBar" = false;
        "browser.search.widget.removeAfterDaysUnused" = 0;

        "network.http.referer.XOriginPolicy" = 2;
        "network.http.sendRefererHeader" = 0;

        "privacy.clearHistory.cache" = true;
        "privacy.clearHistory.cookiesAndStorage" = true;
        "privacy.clearHistory.historyFormDataAndDownloads" = true;
        "privacy.clearHistory.siteSettings" = true;
        "privacy.clearOnShutdown.cache" = true;
        "privacy.clearOnShutdown.downloads" = true;
        "privacy.clearOnShutdown.formdata" = true;
        "privacy.clearOnShutdown.history" = true;
        "privacy.clearOnShutdown.offlineApps" = true;
        "privacy.clearOnShutdown.openWindows" = true;
        "privacy.clearOnShutdown.siteSettings" = true;
        "privacy.clearOnShutdown_v2.cache" = true;
        "privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = true;
        "privacy.clearOnShutdown_v2.siteSettings" = true;
        "privacy.clearSiteData.cache" = true;
        "privacy.clearSiteData.cookiesAndStorage" = true;
        "privacy.clearSiteData.historyFormDataAndDownloads" = true;
        "privacy.clearSiteData.siteSettings" = true;
        "privacy.clearOnShutdown.cookies" = true;
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = true;
        "privacy.clearOnShutdown.sessions" = true;

        "privacy.donottrackheader.enabled" = true;

        "privacy.globalprivacycontrol.enabled" = true;
        "privacy.globalprivacycontrol.was_ever_enabled" = true;
      };

      profiles.${osConfig.specialConfig.username} = {
        id = 0;
        isDefault = true;

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
        };
      };
    };
  };
}
