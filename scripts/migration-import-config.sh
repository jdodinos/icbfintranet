﻿#!/bin/bash
set -x

# Variables de color
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # Sin color

# Archivo de log para registrar la salida de las migraciones.
LOGFILE="migraciones.log"

# Registra el inicio del proceso con la fecha.
echo "=== Inicio de migraciones: $(date) ===" >> "$LOGFILE"

# Función para ejecutar una migración, capturar la salida y registrar si se completó o no.
run_migration() {
  MIGRATION="$1"
  echo "=== Ejecutando migración: $MIGRATION ===" | tee -a "$LOGFILE"
  
  # Captura la salida y el código de salida del comando.
  output=$(vendor/bin/drush migrate:import "$MIGRATION" 2>&1)
  exit_status=$?
  
  # Registra la salida del comando.
  echo "$output" | tee -a "$LOGFILE"
  
  # Evalúa el código de salida y muestra el resultado, coloreando el mensaje de error en rojo.
  if [ $exit_status -eq 0 ]; then
    echo -e "${GREEN}Migración '$MIGRATION' completada exitosamente.${NC}" | tee -a "$LOGFILE"
  else
    echo -e "${RED}Migración '$MIGRATION' fallida.${NC}" | tee -a "$LOGFILE"
  fi
}

# Lista de migraciones a ejecutar
run_migration "d7_captcha_settings"
run_migration "d7_node_settings"
run_migration "d7_node_type"
run_migration "d7_user_flood"
run_migration "d7_user_mail"
run_migration "d7_user_settings"
run_migration "d7_user_role"
run_migration "d7_user"
run_migration "d7_webform"
run_migration "d7_action"
run_migration "d7_captcha_points"
run_migration "d7_dblog_settings"
run_migration "d7_filter_settings"
run_migration "d7_global_theme_settings"
run_migration "d7_image_settings"
run_migration "d7_image_styles"
run_migration "d7_pathauto_settings"
run_migration "d7_search404_settings"
run_migration "d7_search_page"
run_migration "d7_system_cron"
run_migration "d7_system_date"
run_migration "d7_system_mail"
run_migration "d7_system_performance"
run_migration "file_settings"
run_migration "locale_settings"
run_migration "mail_system_settings"
run_migration "menu_settings"
run_migration "system_rss"
run_migration "d7_filter_format"
run_migration "d7_field_collection_type"
run_migration "block_content_type"
run_migration "block_content_body_field"
run_migration "d7_custom_block"

# Registra el final del proceso.
echo "=== Fin de migraciones: $(date) ===" >> "$LOGFILE"

