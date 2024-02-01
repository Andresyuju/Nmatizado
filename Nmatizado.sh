#!/bin/bash

read -p "Ingrese la dirección IP o rango de IPs para escanear: " objetivo

echo "Seleccione el tipo de escaneo:"
echo "1. Escaneo rápido"
echo "2. Escaneo de servicios"
echo "3. Escaneo completo de puertos"
echo "4. Detección de sistema operativo"
echo "5. Escaneo agresivo (SO, servicios y scripts)"
echo "6. Detección de versiones de servicios"
echo "7. Escaneo UDP"
read -p "Ingrese su elección (1-7): " tipo_escaneo

echo "Seleccione la agresividad del escaneo:"
echo "1. Silencioso"
echo "2. Normal"
echo "3. Agresivo"
echo "4. Muy Agresivo"
read -p "Ingrese su elección (1-4): " agresividad

read -p "¿Desea especificar un rango de puertos? (s/n): " eleccion_puertos
if [ "$eleccion_puertos" = "s" ]; then
    read -p "Ingrese el rango de puertos (ej. 20-80): " rango_puertos
fi

comando_nmap="nmap"

case $tipo_escaneo in
    1) comando_nmap+=" -F" ;;
    2) comando_nmap+=" -sV" ;;
    3) comando_nmap+=" -p-" ;;
    4) comando_nmap+=" -O" ;;
    5) comando_nmap+=" -A" ;;
    6) comando_nmap+=" --version-all" ;;
    7) comando_nmap+=" -sU" ;;
esac

case $agresividad in
    1) comando_nmap+=" -T2" ;;
    2) comando_nmap+=" -T3" ;;
    3) comando_nmap+=" -T4" ;;
    4) comando_nmap+=" -T5" ;;
esac

if [ "$eleccion_puertos" = "s" ]; then
    comando_nmap+=" -p $rango_puertos"
fi

comando_nmap+=" $objetivo"

echo "Ejecutando comando: $comando_nmap"
eval $comando_nmap
