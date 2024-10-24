{ ... }:

let
  lock-false = {
    Value = false;
    Status = "locked";
  };

  lock-true = {
    Value = true;
    Status = "locked";
  };
in
{
  programs.firefox = {
    enable = true;
    languagePacks = [
      "en-US"
    ];

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

      SearchEngines = {
        Default = "DuckDuckGo";
      };

      # ---- EXTENSIONS ----
      # Check about:support for extension/add-on ID strings.
      # Valid strings for installation_mode are "allowed", "blocked",
      # "force_installed" and "normal_installed".
      ExtensionSettings = {
        "*".installation_mode = "blocked";

        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };

        "keepassxc-browser@keepassxc.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
          installation_mode = "normal_installed";
        };
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
}
