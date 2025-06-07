
# Cargar configuraciones automáticas previas
config.load_autoconfig()

# Motor de búsqueda predeterminado: Google
c.url.searchengines = {
    "DEFAULT": "https://www.google.com/search?q={}"
}

# Modo oscuro para páginas web
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.policy.page = 'smart'
c.colors.webpage.darkmode.threshold.background = 0
c.colors.webpage.darkmode.threshold.foreground = 256
c.colors.webpage.preferred_color_scheme = 'dark'

# Transparencia del fondo del navegador
c.colors.webpage.bg = "rgba(17,17,17,0.8)"  # Equivalente a #111111 con 80% de opacidad

# Colores personalizados basados en tu configuración de Alacritty
c.colors.completion.fg = "#efebec"
c.colors.completion.bg = "#111111"
c.colors.completion.match.fg = "#fdeb37"
c.colors.completion.scrollbar.fg = "#cccccc"
c.colors.completion.scrollbar.bg = "#111111"

c.colors.statusbar.normal.fg = "#efebec"
c.colors.statusbar.normal.bg = "#111111"
c.colors.statusbar.insert.bg = "#fdeb37"
c.colors.statusbar.insert.fg = "#111111"
c.colors.statusbar.command.fg = "#efebec"
c.colors.statusbar.command.bg = "#111111"

c.colors.tabs.bar.bg = "#111111"
c.colors.tabs.odd.bg = "#111111"
c.colors.tabs.even.bg = "#111111"
c.colors.tabs.odd.fg = "#efebec"
c.colors.tabs.even.fg = "#efebec"
c.colors.tabs.selected.odd.bg = "#fdeb37"
c.colors.tabs.selected.even.bg = "#fdeb37"
c.colors.tabs.selected.odd.fg = "#111111"
c.colors.tabs.selected.even.fg = "#111111"

c.colors.hints.bg = "#fdeb37"
c.colors.hints.fg = "#111111"
c.colors.hints.match.fg = "#c01e10"

# Estilo del cursor
c.cursor_shape = 'beam'

# Atajo de teclado para abrir una nueva instancia del navegador
config.bind('<Ctrl+Return>', 'spawn --detach qutebrowser')
