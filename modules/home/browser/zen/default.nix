{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
in
{
  imports = [
    ./users.nix
  ];

  options = {
    funkouna = {
      browser = {
        zen = {
          enable = mkEnableOption "Enable Zen Browser";
        };
      };
    };
  };

  config = mkIf config.funkouna.browser.zen.enable {
    programs = {
      zen-browser = {
        enable = true;
        languagePacks = [
          "en-US"
        ];

        policies = {
          DisableAppUpdate = true;
          DisableTelemetry = true;
          DisablePocket = true;
          NoDefaultBookmarks = lib.mkForce true;
          DontCheckDefaultBrowser = true;
        };

        profiles = {
          default = rec {
            extensions = {
              packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
                ublock-origin
                sponsorblock
                proton-pass
              ];
            };

            mods = [
              "253a3a74-0cc4-47b7-8b82-996a64f030d5"
              "906c6915-5677-48ff-9bfc-096a02a72379"
              "c8d9e6e6-e702-4e15-8972-3596e57cf398"
              "f7c71d9a-bce2-420f-ae44-a64bd92975ab"
              "a6335949-4465-4b71-926c-4a52d34bc9c0"
              "803c7895-b39b-458e-84f8-a521f4d7a064"
            ];

            search = {
              force = true;
              default = "ddg";
              engines = {
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
                          name = "channel";
                          value = "unstable";
                        }
                        {
                          name = "query";
                          value = "{searchTerms}";
                        }
                      ];
                    }
                  ];
                  icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                  definedAliases = [
                    "@pkgs"
                  ];
                };
                mynixos = {
                  name = "My NixOS";
                  urls = [
                    {
                      template = "https://mynixos.com/search?q={searchTerms}";
                      params = [
                        {
                          name = "query";
                          value = "searchTerms";
                        }
                      ];
                    }
                  ];
                  icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                  definedAliases = [
                    "@nx"
                  ];
                };
              };
            };

            settings = {
              "ui.systemUsesDarkTheme" = 1;
              "layout.css.prefers-color-scheme.content-override" = 0;

              "browser.aboutConfig.showWarning" = false;
              "browser.tabs.warnOnClose" = false;
              "browser.tabs.hoverPreview.enabled" = true;
              "browser.newtabpage.activity-stream.feeds.topsites" = false;
              "browser.topsites.contile.enabled" = false;
              "browser.gesture.swipe.left" = "";
              "browser.gesture.swipe.right" = "";

              "media.videocontrols.picture-in-picture.video-toggle.enabled" = true;

              "privacy.resistFingerprinting" = true;
              "privacy.resistFingerprinting.randomization.canvas.use_siphash" = true;
              "privacy.resistFingerprinting.randomization.daily_reset.enabled" = true;
              "privacy.resistFingerprinting.randomization.daily_reset.private.enabled" = true;
              "privacy.resistFingerprinting.block_mozAddonManager" = true;
              "privacy.spoof_english" = 1;
              "privacy.firstparty.isolate" = true;

              "network.cookie.cookieBehavior" = 5;
              "network.http.http3.enabled" = true;
              "network.socket.ip_addr_any.disabled" = true;

              "dom.battery.enabled" = false;

              "gfx.webrender.all" = true;
            };

            bookmarks = {
              force = true;
              settings = [
                {
                  name = " Nix Resources ";
                  toolbar = true;
                  bookmarks = [
                    {
                      name = " NixOS Search ";
                      url = "https://search.nixos.org/";
                    }
                    {
                      name = " Home Manager Options ";
                      url = "https://home-manager-options.extranix.com";
                    }
                  ];
                }
              ];
            };

            containersForce = true;
            containers = {
              Shopping = {
                color = "yellow";
                icon = "dollar";
                id = 2;
              };
            };

            spacesForce = true;
            spaces = {
              "Rendezvous" = {
                id = "572910e1-4468-4832-a869-0b3a93e2f165";
                icon = ":)";
                position = 1000;
              };
            };

            pinsForce = true;
            pins = {
              "GitHub" = {
                id = "48e8a119-5a14-4826-9545-91c8e8dd3bf6";
                workspace = spaces."Rendezvous".id;
                url = "https://github.com";
                position = 101;
                isEssential = false;
              };
            };

            keyboardShortcutsVersion = 13;
            keyboardShortcuts = [
              {
                id = "zen-compact-mode-toggle";
                key = "c";
                modifiers = {
                  control = true;
                  alt = true;
                };
              }
              {
                id = "zen-toggle-sidebar";
                key = "x";
                modifiers = {
                  control = true;
                  alt = true;
                };
              }
              {
                id = "key_savePage";
                key = "s";
                modifiers = {
                  control = true;
                };
              }
              {
                id = "key_quitApplication";
                disabled = true;
              }
            ];
          };
        };
      };
    };
  };
}
