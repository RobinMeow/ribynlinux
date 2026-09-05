// disable welcome upon first time opening firefox
user_pref("browser.aboutwelcome.didSeeFinalScreen", true);

// disable wheater widget
// (WARN: doesnt even work yikes, it gets overriden again, and I have to manually hide it)
user_pref("browser.newtabpage.activity-stream.widgets.weather.enabled", false);

// hide bookmark by default CTRL+SHIFT+B to toggle
user_pref("browser.toolbars.bookmarks.visibility", "never");

// hides vpn button in top ui bar
user_pref(
  "browser.uiCustomization.state",
  '{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":[],"nav-bar":["sidebar-button","back-button","forward-button","stop-reload-button","customizableui-special-spring1","vertical-spacer","urlbar-container","customizableui-special-spring2","downloads-button","fxa-toolbar-menu-button","reset-pbm-toolbar-button","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","customizableui-special-spring3","alltabs-button","ai-window-toggle"],"vertical-tabs":[],"PersonalToolbar":["personal-bookmarks"]},"seen":["reset-pbm-toolbar-button","ai-window-toggle","developer-button","screenshot-button","ipprotection-button"],"dirtyAreaCache":["nav-bar","TabsToolbar","vertical-tabs","toolbar-menubar","PersonalToolbar"],"currentVersion":26,"newElementCount":3}',
);

// Open previous windows and tabs
user_pref("browser.startup.page", 3);

// show sponsored shortcuts
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);

// support firefox
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredCheckboxes", false);

// Tell websites not to sell or share my data
user_pref("privacy.globalprivacycontrol.enabled", true);
user_pref("privacy.globalprivacycontrol.was_ever_enabled", true);

// show allerts about passwords for breached websites
user_pref("signon.management.page.breach-alerts.enabled", false);
user_pref("signon.rememberSignons", false);

// ask to save passwords
user_pref("signon.rememberSignons", false);

// trending search suggestions
user_pref("browser.urlbar.suggest.trending", false);

// Save and autofill payment info
user_pref("extensions.formautofill.creditCards.enabled", false);

// Save and autofill addresses
user_pref("extensions.formautofill.addresses.enabled", false);

// font
user_pref("font.name.serif.x-western", "Noto Sans");
// minimum font size
user_pref("font.minimum-size.x-western", 14);
// increase monospace default side from 12
user_pref("font.size.monospace.x-western", 14);

//// Tabs and browsing
// recommend extensions as you browse
user_pref(
  "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons",
  false,
);
// recommend features as you browse
user_pref(
  "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features",
  false,
);

//// Languages
// Offer fullpage translation
user_pref("browser.translations.automaticallyPopup", false);
// spell check
user_pref("layout.spellcheckDefault", 0); // 0 is off

//// AI controls
// on device ai
user_pref("browser.ai.control.linkPreviewKeyPoints", "blocked");
user_pref("browser.ai.control.pdfjsAltText", "blocked");
user_pref("browser.ai.control.sidebarChatbot", "blocked");
user_pref("browser.ai.control.smartTabGroups", "blocked");
user_pref("browser.ai.control.translations", "blocked");
user_pref("browser.ml.chat.enabled", false);
user_pref("browser.ml.chat.page", false);
user_pref("browser.ml.linkPreview.enabled", false);
user_pref("browser.tabs.groups.smart.enabled", false);
user_pref("browser.tabs.groups.smart.userEnabled", false);
user_pref("browser.translations.enable", false);
user_pref("pdfjs.enableAltText", false);
// block ai enhancements
user_pref("browser.ai.control.default", "blocked");
user_pref("browser.ai.control.smartWindow", "blocked");
user_pref("browser.smartwindow.memories.generateFromConversation", false);
user_pref("browser.smartwindow.memories.generateFromHistory", false);
user_pref("extensions.ml.enabled", false);

//// Permissions and data
// send daily usage ping to Mozilla
user_pref("datareporting.usage.uploadEnabled", false);
// allow firefox to improve features, perf, and stability between updates remotely
user_pref("nimbus.rollouts.enabled", false);
// this line was removed upon disabeling the above?
user_pref(
  "browser.newtabpage.activity-stream.widgets.sportsWidget.enabled",
  false,
);
// allow firefox to run feature studies
user_pref("app.shield.optoutstudies.enabled", false);
// allow personalized extension recommendations
ser_pref("browser.discovery.enabled", false);
// send technical and interaction data to Mozilla
user_pref("datareporting.healthreport.uploadEnabled", false);

// do not warn when opening about:config via the url
user_pref("browser.aboutConfig.showWarning", false);

//

// dark theme
user_pref("extensions.activeThemeID", "firefox-compact-dark@mozilla.org");
// TODO: it uses system by default, but for some reason my system default
// is not fully darkmode yet
user_pref("layout.css.prefers-color-scheme.content-override", 0);

// "Use AI to suggest tabs and a name for tab groups"
user_pref("browser.tabs.groups.smart.userEnabled", false);
