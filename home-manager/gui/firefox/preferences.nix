{ pkgs, downloadDirectory, ... }:
let
  locked_false = {
    Value = false;
    Locked = true;
  };
  locked_true = {
    Value = true;
    Locked = true;
  };
  pywalfox-extension-patched = pkgs.callPackage ./pywalfox-extension-patched.nix {};
in
{
  DisableTelemetry = true;
  DisableFirefoxStudies = true;
  EnableTrackingProtection = {
    Value = true;
    Locked = true;
    Category = "strict";
    BaselineExceptions = true;
  };
  HttpsOnlyMode = "force_enabled";
  OverrideFirstRunPage = "";
  OverridePostUpdatePage = "";
  DontCheckDefaultBrowser = true;
  OfferToSaveLogins = false;
  OfferToSaveLoginsDefault = false;
  PasswordManagerEnabled = false;
  TranslateEnabled = true;
  PictureInPicture = {
    Enabled = true;
    Locked = true;
  };
  PrivateBrowsingModeAvailability = 0;
  SanitizeOnShutdown = {
    Cache = true;
    Cookies = true;
    Downloads = false;
    FormData = true;
    History = true;
    Sessions = true;
    SiteSettings = false;
    OfflineApps = true;
    Locked = true;
  };
  Cookies = {
    Allow = [
      "https://github.com"
    ];
    Locked = true;
  };
  PromptForDownloadLocation = false;
  StartDownloadsInTempDirectory = true;
  DefaultDownloadDirectory = downloadDirectory;
  NetworkPrediction = false;
  FirefoxHome = {
    Search = true;
    TopSites = false;
    SponsoredTopSites = false;
    Highlights = false;
    Pocket = false;
    SponsoredPocket = false;
    Snippets = false;
    Locked = true;
  };
  FirefoxSuggest = {
    WebSuggestions = false;
    SponsoredSuggestions = false;
    ImproveSuggest = false;
    OnlineEnabled = false;
    Locked = true;
  };
  GenerativeAI = {
    Chatbot = false;
    LinkPreviews = false;
    TabGroups = false;
    Enabled = false;
    Locked = true;
  };
  SearchSuggestEnabled = false;
  SearchEngines = {
    Remove = [
      "eBay"
      "Bing"
      "Ecosia"
      "Perplexity"
      "Qwant"
      "Wikipedia (en)"
    ];
    Default = "DuckDuckGo";
  };
  ExtensionSettings = {
    "*" = {
      private_browsing = true;
    };
    "addon@darkreader.org" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";      
      installation_mode = "force_installed";
      private_browsing = true;
    };
    "uBlock0@raymondhill.net" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
      installation_mode = "force_installed";
      private_browsing = true;
    };
    "pywalfox@frewacom.org" = {
      install_url = "file://${pywalfox-extension-patched}/pywalfox.xpi";
      installation_mode = "force_installed";
      private_browsing = true;
    };
    "{154cddeb-4c8b-4627-a478-c7e5b427ffdf}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/popupoff/latest.xpi";
      installation_mode = "force_installed";
      private_browsing = true;
    };
  };
  SkipTermsOfUse = true;
  Preferences = {
    "places.history.enabled" = locked_false; # don't save history to disk
    "browser.sessionstore.max_tabs_undo" = { Value = 0; Lockd = true; }; # disable recently closed tabs
    "browser.sessionstore.max_windows_undo" = { Value = 0; Locked = true; }; # disable session restore
    "browser.sessionstore.resume_from_crash" = locked_false;
    "browser.sessionstore.privacy_level" = { Value = 2; Locked = true; };

    "extensions.pocket.enabled" = locked_false;
    "extensions.screenshots.disabled" = locked_true;

    # Firefox telemetry
    "datareporting.healthreport.uploadEnabled" = locked_false;
    "datareporting.policy.dataSubmissionEnabled" = locked_false;
    "toolkit.telemetry.enabled" = locked_false;
    "toolkit.telemetry.unified" = locked_false;
    "toolkit.telemetry.archive.enabled" = locked_false;
    "app.shield.optoutstudies.enabled" = locked_false;
    "browser.discovery.enabled" = locked_false;

    # Disable WebRC (IP leaks)`
    "media.peerconnection.enabled" = locked_false;

    # Resist Fingerprinting
    "privacy.resistFingerprinting" = locked_true;
    "privacy.resistFingerprinting.letterboxing" = locked_true;

    # Cookie hardening
    "network.cookie.cookieBehavior" = {
      Value = 5; # Total Cookie Protection
      Locked = true;
    };
    "network.http.referer.XOriginPolicy" = {
      Value = 2;
      Locked = true;
    };
    "network.http.referer.XOriginTrimmingPolicy" = {
      Value = 2;
      Locked = true;
    };

    # Disable Web Features Used for Tracking
    "dom.battery.enabled" = locked_false;
    "geo.enabled" = locked_false;
    "dom.gamepad.enabled" = locked_false;
    "dom.vr.enabled" = locked_false;
    "media.navigator.enabled" = locked_false;

    # Disable DNS prefetching
    "network.dns.disablePrefetch" = locked_true;
    "network.prefetch-next" = locked_false;
    "network.predictor.enabled" = locked_false;
    "network.http.speculative-parallel-limit" = {
      Value = 0;
      Locked = true;
    };

    # Disable WebGL (reduces fingerprinting, but may break 3D)
    "webgl.disabled" = locked_true;

    # Disable DRM (no Netflix, e.g.)
    "media.eme.enabled" = locked_false;
  };
}
