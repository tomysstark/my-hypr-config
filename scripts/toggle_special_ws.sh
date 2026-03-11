#!/bin/bash

# Script pour toggle un workspace spécial et lancer une app si nécessaire
# Usage: toggle_special_ws.sh <special_workspace_name> <app_command>
# Exemple: toggle_special_ws.sh music spotify

WORKSPACE="special:$1"
APP_COMMAND="$2"

# Vérifier si on est déjà sur le workspace spécial
CURRENT_WS=$(hyprctl activeworkspace -j | jq -r '.name')

if [ "$CURRENT_WS" = "$WORKSPACE" ]; then
    # On est sur le workspace spécial, retourner au workspace précédent
    hyprctl dispatch togglespecialworkspace "$1"
else
    # Vérifier si l'app est déjà lancée
    APP_RUNNING=$(hyprctl clients -j | jq -r ".[] | select(.workspace.name == \"$WORKSPACE\") | .class" | head -n 1)
    
    if [ -z "$APP_RUNNING" ]; then
        # L'app n'est pas lancée, la lancer
        $APP_COMMAND &
        sleep 0.5
    fi
    
    # Aller au workspace spécial
    hyprctl dispatch togglespecialworkspace "$1"
fi
