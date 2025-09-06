{
  lib,
  pkgs,
  trilby,
  defaultDesktop ? true,
  ...
}:

{
  imports =
    with trilby.inputs.self.nixosModules;
    [
      profiles.base
      profiles.firefox
      profiles.fonts
      profiles.geoclue
      profiles.libreoffice
      profiles.mimetypes
      profiles.pipewire
      profiles.virtualisation
    ]
    ++ lib.optionals defaultDesktop (
      with trilby.inputs.self.nixosModules;
      [
        profiles.gnome
        profiles.sway
      ]
    );

  services = {
    blueman.enable = true;
    flatpak.enable = true;
    fwupd.enable = true;
    localtimed.enable = true;
    printing.enable = true;
    usbmuxd.enable = true;
    xserver.enable = true;
  };

  powerManagement.enable = true;

  security.rtkit.enable = true;
}
// lib.optionalAttrs (lib.versionAtLeast trilby.release "24.05") {
  # Both Gnome and Sway declare this as default, so let's resolve the ambiguity.
  programs.gnupg.agent.pinentryPackage = pkgs.unstable.pinentry-gnome3;
}
