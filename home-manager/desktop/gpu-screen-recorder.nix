{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gpu-screen-recorder
    gpu-screen-recorder-gtk
  ];

  home.file.".scripts/notify-gpu-screen-recorder.sh" = {
    executable = true;
    text = ''
      #!${pkgs.bash}/bin/bash

      VIDEO="$1"
      TYPE="$2"

      FILE="$(${pkgs.coreutils}/bin/basename "$VIDEO")"

      case "$TYPE" in
        replay)
          TITLE="Replay Saved"
          ;;
        regular)
          TITLE="Recording Saved"
          ;;
        screenshot)
          TITLE="Screenshot Saved"
          ;;
        *)
          TITLE="GPU Screen Recorder"
          ;;
      esac

      ${pkgs.libnotify}/bin/notify-send "$TITLE" "$FILE"
    '';
  };

}
