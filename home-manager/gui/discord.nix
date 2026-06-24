{
  pkgs,
  lib,
  osConfig,
  ...
}:
{
  programs.nixcord = {
    enable = true; # enable Nixcord. Also installs discord package
    quickCss = ""; # quickCSS file
    discord = {
      enable = false;
    };
    vesktop = {
      enable = true;
      # Vesktop broken for now, hangs at startup : https://github.com/NixOS/nixpkgs/pull/399932
      package = pkgs.vesktop;
    };
    config = {
      useQuickCss = true; # use out quickCSS
      themeLinks = [
        # or use an online theme
        # "https://discordstyles.github.io/DarkMatter/DarkMatter.theme.css"
      ];
      frameless = true; # set some Vencord options
      transparent = true;
      disableMinSize = true;
      plugins = {
        accountPanelServerProfile.enable = true;
        betterFolders = {
          enable = false;
          forceOpen = true;
        };
        betterSessions.enable = true;
        biggerStreamPreview.enable = true;
        ClearURLs.enable = true;
        consoleShortcuts.enable = true;
        # ctrlEnterSend.enable = true;
        decor.enable = true;
        fakeNitro = {
          enable = true;
          enableEmojiBypass = true;
          enableStreamQualityBypass = true;
        };
        imageZoom.enable = true;
        fixCodeblockGap.enable = true;
        forceOwnerCrown.enable = true;
        friendsSince.enable = true;
        copyEmojiMarkdown = {
          enable = true;
          copyUnicode = true;
        };
        memberCount.enable = true;
        mentionAvatars.enable = true;
        messageLatency.enable = true;
        messageLogger.enable = true;
        noMosaic.enable = true;
        noTypingAnimation.enable = true;
        openInApp.enable = true;
        overrideForumDefaults.enable = true;
        permissionsViewer.enable = true;
        previewMessage.enable = true;
        quickReply = {
          enable = true;
        };
        reactErrorDecoder.enable = true;
        serverInfo.enable = true;
        showHiddenChannels.enable = true;
        showHiddenThings.enable = true;
        showTimeoutDuration.enable = true;
        typingIndicator.enable = true;
        silentTyping = {
          enable = true;
          # showIcon = true;
        };
        vencordToolbox.enable = true;
        youtubeAdblock.enable = true;
        ignoreActivities = {
          # Enable a plugin and set some options
          enable = true;
          ignorePlaying = true;
          ignoreWatching = true;
        };
      };
    };
    extraConfig = {
    };
  };
}
