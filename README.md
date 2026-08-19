# Dotfiles — CachyOS + Hyprland

Configuración personal de mi sistema.

**Equipo:** Lenovo LOQ 15IA9X · i5-12450HX · RTX 3050 6GB · 15.3 GB RAM
**Sistema:** CachyOS (Arch) · dual boot con Windows 11
**Escritorio:** Hyprland (configuración en **Lua**, no `.conf`) + Noctalia
**Shell:** fish · **Terminal:** kitty · **Login:** SDDM con tema Sugar Candy

---

## Qué hay en cada carpeta

| Carpeta | Destino | Contenido |
|---|---|---|
| `hypr/` | `~/.config/hypr/` | Toda la configuración de Hyprland |
| `noctalia/` | `~/.config/noctalia/` | Barra, paneles, colores y reloj |
| `qt6ct/` | `~/.config/qt6ct/` | Tema de aplicaciones Qt |
| `uwsm/` | `~/.config/uwsm/` | Variables de entorno de la sesión |
| `wireplumber/` | `~/.config/wireplumber/` | Audio y Bluetooth |
| `scripts/` | `~/.local/bin/` | Scripts propios (alarma) |
| `wallpapers/` | `~/Pictures/Wallpapers/` | Fondos de pantalla |
| `fish-config.fish` | `~/.config/fish/config.fish` | Configuración de fish |
| `mangohud.conf` | `~/.config/MangoHud/MangoHud.conf` | Overlay de FPS |

### Dentro de `hypr/`

| Archivo | Qué configura |
|---|---|
| `hyprland.lua` | Principal — carga todos los demás |
| `config/monitors.lua` | Resolución, Hz, escalado y posición de pantallas |
| `config/inputs.lua` | Teclado (latam), touchpad, cursor, gestos |
| `config/binds.lua` | Todos los atajos de teclado |
| `config/variables.lua` | Apps por defecto, nombres de monitores, nº de workspaces |
| `config/workspaces.lua` | Qué workspace va en qué monitor |
| `config/autostart.lua` | Programas al iniciar sesión |
| `config/animations.lua` | Animaciones |
| `config/windowrules.lua` | Reglas de ventana |
| `config/environment.lua` | **No se usa** — las variables van en `uwsm/env` |
| `hyprlock.conf` | Pantalla de bloqueo |

---

## Cómo restaurar en una instalación nueva

### 1. Instalar los paquetes

```bash
# Repositorios oficiales
sudo pacman -S --needed - < paquetes-explicitos.txt

# AUR (revisar la lista antes, algunos pueden haber cambiado de nombre)
paru -S --needed - < paquetes-aur.txt
```

### 2. Copiar la configuración

```bash
cp -r hypr ~/.config/
cp -r noctalia ~/.config/
cp -r qt6ct ~/.config/
cp -r uwsm ~/.config/
cp -r wireplumber ~/.config/
cp fish-config.fish ~/.config/fish/config.fish

mkdir -p ~/.config/MangoHud
cp mangohud.conf ~/.config/MangoHud/MangoHud.conf

mkdir -p ~/.local/bin
cp scripts/* ~/.local/bin/
chmod +x ~/.local/bin/*

mkdir -p ~/Pictures/Wallpapers
cp wallpapers/* ~/Pictures/Wallpapers/
```

### 3. Ajustar rutas absolutas

Estos archivos tienen mi nombre de usuario dentro. Cámbialo si es distinto:

- `qt6ct/qt6ct.conf` → línea `color_scheme_path`
- `hypr/hyprlock.conf` → ruta del fondo
- `scripts/alarma` → rutas del script

### 4. Cerrar sesión y entrar como "Hyprland (uwsm-managed)"

⚠️ **Importante:** hay que elegir la sesión con UWSM en SDDM.
Si entras con "Hyprland" a secas, `~/.config/uwsm/env` no se carga y las
aplicaciones Qt (Dolphin) abren con el texto ilegible.

---

## Cosas específicas de este sistema

### Hyprland usa el parser de Lua

CachyOS configura Hyprland en **Lua**, no en el `.conf` estándar. Consecuencias:

- `hyprctl keyword` **no funciona** → hay que usar `hyprctl eval`
- Las herramientas gráficas (nwg-displays) escriben `.conf` y **no tienen efecto**
- Los tutoriales y dotfiles públicos usan `.conf` → hay que traducir la sintaxis
- Dentro de `hl.on("hyprland.start", ...)` se usa `hl.exec_cmd`, no `exec_once`

Probar cambios en caliente:
```bash
hyprctl eval 'hl.monitor({ output = "eDP-1", mode = "1920x1080@144", position = "0x720", scale = "1.5" })'
```
Comillas simples fuera, dobles dentro.

### Monitores

Se identifican por **descripción**, no por nombre de puerto — los nombres HDMI
cambian entre reinicios (HDMI-A-5 → HDMI-A-1).

```
Interno:  desc:BOE 0x0C29 0x00000067                     1920x1080@144  scale 1.5
Externo:  desc:Initio Corporation KJW27FIX 0x00000001    1920x1080@180  scale 1.5
```

Disposición: el externo **arriba** (`0x0`), el portátil **debajo** (`0x720`).
Con scale 1.5 ambos ocupan 1280x720 lógicos, así que quedan alineados.

Ver descripciones:
```bash
hyprctl monitors | grep -E "Monitor|description"
```

### GPU NVIDIA

La BIOS está en **Discrete Graphics** (F2 al arrancar → Graphic Device).
Con Dynamic Graphics la iGPU Intel intentaba mover todo el escritorio y se
ahogaba: GPU Intel al 84% mientras la RTX 3050 estaba al 0%.

Servicios de suspensión habilitados:
```bash
sudo systemctl enable nvidia-suspend.service nvidia-resume.service nvidia-hibernate.service
```

En `/etc/modprobe.d/nvidia.conf`:
```
options nvidia NVreg_PreserveVideoMemoryAllocations=1
options nvidia NVreg_TemporaryFilePath=/var/tmp
```

### Bluetooth

Los auriculares se desconectaban cada 28 segundos por un bucle de reconexión
del perfil HFP (manos libres). Se resuelve desactivando ese perfil en
`wireplumber/wireplumber.conf.d/50-bluez.conf` — solo A2DP.

Contrapartida: no funciona el micrófono de los auriculares Bluetooth.

### Node.js

Se usa **fnm**, no nvm (nvm no es compatible con fish).
Los paquetes globales de npm van a `~/.npm-global` para evitar errores EACCES.

---

## Atajos principales

| Atajo | Acción |
|---|---|
| `Super + Return` | Terminal |
| `Super + Q` | Cerrar ventana |
| `Super + Space` | Lanzador |
| `Super + W` | Navegador |
| `Super + E` | Archivos |
| `Super + F` | Pantalla completa |
| `Super + Alt + Space` | Flotante ↔ tiling |
| `Super + V` | Portapapeles |
| `Super + S` | Scratchpad |
| `Super + L` | Bloquear |
| `Super + Z` | Ajustes de Noctalia |
| `Super + Alt + M` | Solo pantalla del portátil |
| `Super + Alt + N` | Solo monitor externo |
| `Super + Alt + B` | Ambas pantallas |
| `Ctrl + Shift + Esc` | btop |

Workspaces: `Super + Alt + N` absolutos · `Super + Ctrl + N` del monitor actual ·
`Super + Ctrl + Shift + N` mover ventana

---

## Problemas conocidos

- **Bloqueo de Noctalia con escalado fraccionario** — se descuadra en multi-monitor
  con scale 1.5. Por eso uso hyprlock.
- **qt6ct y la ruta con `$USER`** — Noctalia escribe `/home/$USER/...` sin expandir
  en `qt6ct.conf`, y las apps Qt abren con texto ilegible. Hay que corregirlo a mano:
  ```bash
  sed -i "s|/home/\$USER/|/home/TUUSUARIO/|" ~/.config/qt6ct/qt6ct.conf
  ```
- **Suspensión al cerrar la tapa** — la pantalla no siempre despierta.
- **Caracteres invisibles en los TOML** — al editar con teclado latinoamericano se
  cuelan diacríticos que rompen la sintaxis. Detectarlos con `cat -A`.

---

## Mantenimiento

```bash
paru -Syu                    # Actualizar todo (cada pocos días)
sudo cachyos-rate-mirrors    # Si las descargas van lentas
noctalia config validate     # Comprobar el TOML de Noctalia
sudo snapper -c root create -d "descripción"   # Snapshot antes de cambios
```

Actualizar este repo:
```bash
cd ~/dotfiles
cp -r ~/.config/hypr/* hypr/
cp ~/.config/noctalia/config.toml noctalia/
pacman -Qe > paquetes-explicitos.txt
pacman -Qm > paquetes-aur.txt
git add . && git commit -m "Actualización $(date +%Y-%m-%d)" && git push
```
