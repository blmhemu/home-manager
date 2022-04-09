{ config, lib, pkgs, ... }:

with lib;

let
  expected = builtins.toFile "wezterm.lua" ''
    -- Generated by Home Manager.
    -- See https://wezfurlong.org/wezterm/

    -- Add config folder to watchlist for config reloads.
    local wezterm = require 'wezterm';
    wezterm.add_to_config_reload_watch_list(wezterm.config_dir)

    return {}

  '';
in {
  config = {
    programs.wezterm = { enable = true; };

    test.stubs.wezterm = { };

    nmt.script = ''
      assertFileExists home-files/.config/wezterm/wezterm.lua
      assertFileContent home-files/.config/wezterm/wezterm.lua ${expected}
    '';
  };
}