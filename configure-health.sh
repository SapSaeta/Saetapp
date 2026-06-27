#!/bin/bash
# Inyecta los permisos de Health Connect en el AndroidManifest.xml
# Se ejecuta automáticamente durante el build de GitHub Actions.
set -e

MANIFEST="android/app/src/main/AndroidManifest.xml"

if [ ! -f "$MANIFEST" ]; then
  echo "⚠️  No se encontró AndroidManifest.xml, saltando configuración de Health."
  exit 0
fi

echo "📋 Configurando permisos de Health Connect..."

# Permisos de lectura que la app solicitará
PERMISOS='    <uses-permission android:name="android.permission.health.READ_STEPS" />\n    <uses-permission android:name="android.permission.health.READ_TOTAL_CALORIES_BURNED" />\n    <uses-permission android:name="android.permission.health.READ_DISTANCE" />\n    <uses-permission android:name="android.permission.health.READ_EXERCISE" />\n    <uses-permission android:name="android.permission.health.READ_SLEEP" />\n    <uses-permission android:name="android.permission.INTERNET" />'

# Inserta los permisos justo después de la etiqueta <manifest ...>
if ! grep -q "android.permission.health.READ_STEPS" "$MANIFEST"; then
  perl -i -pe "s|(<manifest[^>]*>)|\$1\n$PERMISOS|" "$MANIFEST"
  echo "✅ Permisos de Health Connect añadidos."
else
  echo "ℹ️  Los permisos ya estaban presentes."
fi

# Declara la query para que la app pueda comunicarse con Health Connect
QUERY='    <queries>\n        <package android:name="com.google.android.apps.healthdata" />\n    </queries>'

if ! grep -q "com.google.android.apps.healthdata" "$MANIFEST"; then
  perl -i -pe "s|(</application>)|$QUERY\n\$1|" "$MANIFEST"
  echo "✅ Query de Health Connect añadida."
fi

# Añade los intent-filters de gestión de permisos dentro de la MainActivity
RATIONALE='                <intent-filter>\n                    <action android:name="androidx.health.ACTION_SHOW_PERMISSIONS_RATIONALE" />\n                </intent-filter>\n                <intent-filter>\n                    <action android:name="android.intent.action.VIEW_PERMISSION_USAGE" />\n                    <category android:name="android.intent.category.HEALTH_PERMISSIONS" />\n                </intent-filter>'

if ! grep -q "ACTION_SHOW_PERMISSIONS_RATIONALE" "$MANIFEST"; then
  # inserta los filtros tras la primera apertura de intent-filter de la MainActivity (el LAUNCHER)
  perl -i -0pe "s|(<category android:name=\"android.intent.category.LAUNCHER\" />\s*</intent-filter>)|\$1\n$RATIONALE|" "$MANIFEST"
  echo "✅ Intent-filters de permisos de Health añadidos."
fi

echo "🎉 Configuración de Health Connect completada."
