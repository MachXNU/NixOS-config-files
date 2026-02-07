{ config, ... }:

{
  DisableTelemetry = true;
  DisableFirefoxStudies = true;
  EnableTrackingProtection = {
    Value = true;
    Locked = true;
    Category = "strict";
    BaselineExceptions = true;
  };
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
  PrivateBrowsingModeAvailability = 2;
  PromptForDownloadLocation = false;
  StartDownloadsInTempDirectory = true;
  DefaultDownloadDirectory = "${config.home.homeDirectory}/Downloads";
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
  };
  SkipTermsOfUse = true;
  Preferences = {
    "extensions.pocket.enabled" = {
      Value = false;
      Locked = true;
    };
    "extensions.screenshots.disabled" = {
      Value = true;
      Locked = true;
    };
    "browser.privatebrowsing.autostart" = {
      Value = true;
      Locked = true;
    };
  };
}
