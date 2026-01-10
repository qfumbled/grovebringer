{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.firefox = {
    enable = true;
    
    profiles.default = {
      id = 0;
      isDefault = true;

      settings = {
        # Basic settings
        "browser.tabs.loadInBackground" = true;
        "browser.startup.page" = 3; # Resume previous session
        "browser.aboutConfig.showWarning" = false;
        
        # Language and locale
        "intl.accept_languages" = "en-US,en";
        
        # Theme and appearance
        "widget.gtk.rounded-bottom-corners.enabled" = false;
        "browser.fullscreen.autohide" = false;
        
        # Hardware acceleration
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.rdd-ffmpeg.enabled" = true;
        "widget.dmabuf.force-enabled" = true;
        "media.av1.enabled" = false; # Disabled until GPU upgrade
        
        # Privacy
        "privacy.donottrackheader.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.userContext.enabled" = true;
        "privacy.userContext.ui.enabled" = true;
        
        # Security
        "security.ssl.require_safe_negotiation" = true;
        "security.tls.insecure_fallback_hosts.clear_on_shutdown" = true;
        
        # Performance
        "content.notify.interval" = 500000;
        "content.notify.ontimer" = true;
        "content.switch.threshold" = 500000;
        
        # Network
        "network.http.pipelining" = true;
        "network.http.pipelining.max" = 8;
        "network.http.pipelining.ssl" = true;
        "network.http.proxy.pipelining" = true;
        
        # UI improvements
        "browser.ctrlTab.sortByRecentlyUsed" = false;
        "browser.tabs.tabmanager.enabled" = false;
        
        # Disable telemetry
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
      };

      search = {
        default = "DuckDuckGo";
        engines = {
          "DuckDuckGo" = {
            urls = [{ template = "https://duckduckgo.com/?q={searchTerms}"; }];
            iconUpdateURL = "https://duckduckgo.com/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@d"];
          };
          "Google" = {
            urls = [{ template = "https://www.google.com/search?q={searchTerms}"; }];
            iconUpdateURL = "https://www.google.com/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = ["@g"];
          };
        };
      };
    };
  };
}
