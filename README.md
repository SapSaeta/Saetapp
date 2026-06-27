# SaetaIA Personal — App Android

App personal de productividad (tareas, GitHub, fitness, peso, estudio, lectura y cuenta atrás del bebé), empaquetada como APK de Android con Capacitor y acceso a **Google Health (Health Connect)**.

El APK se compila **automáticamente en la nube** con GitHub Actions. No necesitas instalar nada en tu ordenador.

---

## 📦 Cómo generar el APK (paso a paso)

### 1. Sube estos archivos al repositorio `Saetapp`

Sube **todo el contenido de este ZIP** a la raíz de tu repositorio en GitHub. La estructura debe quedar así:

```
Saetapp/
├── www/
│   └── index.html          ← tu app
├── .github/
│   └── workflows/
│       └── build-apk.yml    ← el que compila el APK
├── capacitor.config.ts
├── configure-health.sh
├── package.json
├── .gitignore
└── README.md
```

> 💡 Desde el móvil: en GitHub, entra al repo → botón "Add file" → "Upload files" → arrastra todo. Asegúrate de mantener las carpetas `www` y `.github/workflows`.

### 2. Lanza la compilación

Tienes dos formas:

- **Automática:** en cuanto subes los archivos a la rama `main`, el build arranca solo.
- **Manual:** ve a la pestaña **Actions** del repo → elige **"Build APK"** → botón **"Run workflow"**.

### 3. Espera unos minutos ⏱️

GitHub monta todo el proyecto, instala Health Connect, y compila. Tarda unos **3-6 minutos**. Verás un círculo amarillo (en curso) que pasa a verde ✅ cuando termina.

### 4. Descarga tu APK

- Entra en la ejecución que acaba de terminar (pestaña **Actions** → clic en el build verde).
- Abajo, en la sección **"Artifacts"**, verás **`SaetaIA-Personal-APK`**.
- Descárgalo. Es un ZIP que contiene `app-debug.apk`.

### 5. Instala el APK en tu móvil

- Descomprime y copia el `.apk` a tu teléfono.
- Ábrelo. Android te pedirá permitir **"instalar apps de fuentes desconocidas"** — acéptalo.
- ¡Listo! Ya tienes SaetaIA Personal instalada.

---

## ❤️ Activar Google Health

La primera vez que entres a la pestaña **Fitness**, la app pedirá permiso para leer tus datos de **Health Connect** (pasos, calorías, distancia, entrenos y sueño).

**Requisitos:**
- Tener instalada la app **Health Connect** (viene de serie en Android 14+, o se baja gratis de Play Store).
- Tener una app que escriba datos ahí (Google Fit, Samsung Health, Fitbit, etc.).

Cuando concedas el permiso, el banner de la app pasará de ámbar ("datos de ejemplo") a verde ("Sincronizado con Google Health").

---

## 🔄 Cómo actualizar la app más adelante

Cuando quieras cambiar algo:
1. Edita `www/index.html` en el repo (o súbelo de nuevo).
2. El build se lanza solo.
3. Descarga el nuevo APK e instálalo encima del anterior.

---

## 🛠️ Notas técnicas

- **appId:** `com.saetaia.personal`
- **Plugin de salud:** `capacitor-health-connect`
- El APK es de tipo *debug* (perfecto para uso personal). Para subir a Google Play haría falta firmarlo con una *keystore*; si llegas a ese punto, se puede añadir al workflow.
