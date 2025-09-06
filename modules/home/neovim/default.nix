{ inputs, lib, ... }:

{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  programs.nixvim = lib.makeAllMkDefault {
    enable = true;
    viAlias = true;
    vimAlias = true;
    imports = lib.findModulesList ./configuration;
  };
}
