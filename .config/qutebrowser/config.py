c.qt.low_end_device_mode = 'never'
c.qt.highdpi = False
c.auto_save.interval = 15000
c.auto_save.session = True
config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
config.set('content.cookies.accept', 'all', 'devtools://*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://accounts.google.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36', 'https://*.slack.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://docs.google.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://drive.google.com/*')
config.set('content.images', True, 'chrome-devtools://*')
config.set('content.images', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'file://*')
config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')
config.set('content.notifications', True, 'https://www.reddit.com')
config.set('content.notifications', True, 'https://www.facebook.com')
config.set('content.notifications', True, 'https://duo.google.com')
config.set('content.notifications', True, 'https://web.skype.com')
config.set('content.notifications', True, 'https://synergyeffect.teamwork.com')
c.content.proxy = 'system'
c.completion.delay = 200
c.downloads.remove_finished = 5000
c.editor.command = ['kitty', '-e', 'vim', '-f', '{file}', '-c', 'normal {line}G{column0}l']
c.hints.border = '1px solid #282a36'
c.spellcheck.languages = ['en-US', 'lt-LT']
c.statusbar.padding = {'top': 6, 'right': 8, 'bottom': 6, 'left': 8}
c.tabs.favicons.scale = 1
c.tabs.padding = {'top': 6, 'right': 8, 'bottom': 6, 'left': 8}
c.tabs.show = 'switching'
c.tabs.show_switching_delay = 20000
c.tabs.indicator.width = 1
c.tabs.indicator.padding = {'top': 2, 'right': 2, 'bottom': 2, 'left': 2}
c.colors.webpage.prefers_color_scheme_dark = True
c.colors.webpage.darkmode.enabled = False
c.fonts.completion.entry = 'normal 11pt Fira Code, normal 11pt Noto Color Emoji'
c.fonts.completion.category = 'normal 11pt Fira Code, normal 11pt Noto Color Emoji'
c.fonts.downloads = 'normal 11pt Fira Code, normal 11pt Noto Color Emoji'
c.fonts.hints = 'bold 11pt Fira Code, normal 11pt Noto Color Emoji'
c.fonts.keyhint = 'normal 11pt Fira Code, normal 11pt Noto Color Emoji'
c.fonts.prompts = 'normal 11pt Fira Code, normal 11pt Noto Color Emoji'
c.fonts.statusbar = 'normal 11pt Fira Code, normal 11pt Noto Color Emoji'
c.fonts.web.family.standard = 'Fira Code, normal 11pt Noto Color Emoji'
c.fonts.web.family.fixed = 'Fira Code, normal 11pt Noto Color Emoji'
c.fonts.web.family.serif = 'Libertinus Serif, normal 11pt Noto Color Emoji'
c.fonts.web.family.sans_serif = 'Fira Code, normal 11pt Noto Color Emoji'
c.fonts.web.family.cursive = 'Fira Code, normal 11pt Noto Color Emoji'
c.fonts.tabs.selected = 'bold 11pt Fira Code, 11pt Noto Color Emoji'
c.fonts.tabs.unselected = 'bold 11pt Fira Code, 11pt Noto Color Emoji'
config.bind('M', 'hint links spawn mpv {hint-url}')
config.bind('cps', 'set content.proxy system')
config.bind('cpt', 'set content.proxy socks://localhost:9050/')
config.bind('m', 'spawn mpv {url}')
config.bind('zl', 'spawn --userscript qute-pass')
config.bind('zol', 'spawn --userscript qute-pass --otp-only')
config.bind('zpl', 'spawn --userscript qute-pass --password-only')
config.bind('zul', 'spawn --userscript qute-pass --username-only')

base00 = "#282936"
base01 = "#3a3c4e"
base02 = "#4d4f68"
base03 = "#626483"
base04 = "#62d6e8"
base05 = "#e9e9f4"
base06 = "#f1f2f8"
base07 = "#f7f7fb"
base08 = "#ea51b2"
base09 = "#b45bcf"
base0A = "#00f769"
base0B = "#ebff87"
base0C = "#a1efe4"
base0D = "#62d6e8"
base0E = "#b45bcf"
base0F = "#00f769"
c.colors.completion.fg = base05
c.colors.completion.odd.bg = base00
c.colors.completion.even.bg = base00
c.colors.completion.category.fg = base0D
c.colors.completion.category.bg = base00
c.colors.completion.category.border.top = base00
c.colors.completion.category.border.bottom = base00
c.colors.completion.item.selected.fg = base05
c.colors.completion.item.selected.bg = base02
c.colors.completion.item.selected.border.top = base02
c.colors.completion.item.selected.border.bottom = base02
c.colors.completion.item.selected.match.fg = base05
c.colors.completion.match.fg = base09
c.colors.completion.scrollbar.fg = base05
c.colors.completion.scrollbar.bg = base00
c.colors.contextmenu.disabled.bg = base01
c.colors.contextmenu.disabled.fg = base04
c.colors.contextmenu.menu.bg = base00
c.colors.contextmenu.menu.fg =  base05
c.colors.contextmenu.selected.bg = base02
c.colors.contextmenu.selected.fg = base05
c.colors.downloads.bar.bg = base00
c.colors.downloads.start.fg = base00
c.colors.downloads.start.bg = base0D
c.colors.downloads.stop.fg = base00
c.colors.downloads.stop.bg = base0C
c.colors.downloads.error.fg = base08
c.colors.hints.fg = base00
c.colors.hints.bg = base0A
c.colors.hints.match.fg = base05
c.colors.keyhint.fg = base05
c.colors.keyhint.suffix.fg = base05
c.colors.keyhint.bg = base00
c.colors.messages.error.fg = base00
c.colors.messages.error.bg = base08
c.colors.messages.error.border = base08
c.colors.messages.warning.fg = base00
c.colors.messages.warning.bg = base0E
c.colors.messages.warning.border = base0E
c.colors.messages.info.fg = base05
c.colors.messages.info.bg = base00
c.colors.messages.info.border = base00
c.colors.prompts.fg = base05
c.colors.prompts.border = base00
c.colors.prompts.bg = base00
c.colors.prompts.selected.bg = base02
c.colors.statusbar.normal.fg = base05
c.colors.statusbar.normal.bg = base00
c.colors.statusbar.insert.fg = base0C
c.colors.statusbar.insert.bg = base00
c.colors.statusbar.passthrough.fg = base0A
c.colors.statusbar.passthrough.bg = base00
c.colors.statusbar.private.fg = base0E
c.colors.statusbar.private.bg = base00
c.colors.statusbar.command.fg = base04
c.colors.statusbar.command.bg = base01
c.colors.statusbar.command.private.fg = base0E
c.colors.statusbar.command.private.bg = base01
c.colors.statusbar.caret.fg = base0D
c.colors.statusbar.caret.bg = base00
c.colors.statusbar.caret.selection.fg = base0D
c.colors.statusbar.caret.selection.bg = base00
c.colors.statusbar.progress.bg = base0D
c.colors.statusbar.url.fg = base05
c.colors.statusbar.url.error.fg = base08
c.colors.statusbar.url.hover.fg = base09
c.colors.statusbar.url.success.http.fg = base0B
c.colors.statusbar.url.success.https.fg = base0B
c.colors.statusbar.url.warn.fg = base0E
c.colors.tabs.bar.bg = base00
c.colors.tabs.indicator.start = base0D
c.colors.tabs.indicator.stop = base0C
c.colors.tabs.indicator.error = base08
c.colors.tabs.odd.fg = base05
c.colors.tabs.odd.bg = base00
c.colors.tabs.even.fg = base05
c.colors.tabs.even.bg = base00
c.colors.tabs.pinned.even.bg = base0B
c.colors.tabs.pinned.even.fg = base00
c.colors.tabs.pinned.odd.bg = base0B
c.colors.tabs.pinned.odd.fg = base00
c.colors.tabs.pinned.selected.even.bg = base02
c.colors.tabs.pinned.selected.even.fg = base05
c.colors.tabs.pinned.selected.odd.bg = base02
c.colors.tabs.pinned.selected.odd.fg = base05
c.colors.tabs.selected.odd.fg = base05
c.colors.tabs.selected.odd.bg = base02
c.colors.tabs.selected.even.fg = base05
c.colors.tabs.selected.even.bg = base02
c.colors.webpage.bg = base00
