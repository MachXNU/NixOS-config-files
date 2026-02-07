{ pkgs, lib, ...}:

{
  jb = {
    id = 0;
    isDefault = true;
    settings = {
      "browser.urlbar.suggest.topsites" = false;
      "browser.urlbar.suggest.trending" = false;
      "browser.search.suggest.enabled" = false;
      "privacy.donottrackheader.enabled" = true;
      "privacy.globalprivacycontrol.enabled" = true;
    };
  };
}
