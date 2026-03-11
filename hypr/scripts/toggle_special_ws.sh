#!/bin/bash

# Script pour toggle un workspace spécial et lancer une app si nécessaire
# Usage: toggle_special_ws.sh <special_workspace_name> <app_command>
# Exemple: toggle_special_ws.sh music spotify

WORKSPACE="special:$1"
APP_COMMAND="$2"
WORKSPACE_NAME="$1"

# Vérifier si on est déjà sur le workspace spécial
CURRENT_WS=$(hyprctl activeworkspace -j | jq -r '.name')

if [ "$CURRENT_WS" = "$WORKSPACE" ]; then
  # On est sur le workspace spécial, retourner au workspace précédent
  hyprctl dispatch togglespecialworkspace "$WORKSPACE_NAME"
else
  # Vérifier si l'app est déjà lancée quelque part
  APP_EXISTS=$(hyprctl clients -j | jq -r ".[] | select(.workspace.name == \"$WORKSPACE\") | .class" | head -n 1)

  if [ -z "$APP_EXISTS" ]; then
    # L'app n'existe pas, la lancer ET rester sur le workspace
    echo "Lancement de $APP_COMMAND..."

    # Basculer vers le workspace spécial D'ABORD
    hyprctl dispatch togglespecialworkspace "$WORKSPACE_NAME"

    # Attendre un peu que le workspace soit actif
    sleep 0.3

    # Lancer l'app
    $APP_COMMAND &
    APP_PID=$!

    # Attendre que l'app apparaisse (max 10 secondes pour Discord)
    for i in {1..20}; do
      sleep 0.5

      # Vérifier si l'app est apparue dans le workspace
      APP_IN_WS=$(hyprctl clients -j | jq -r ".[] | select(.workspace.name == \"$WORKSPACE\") | .class" | head -n 1)

      if [ -n "$APP_IN_WS" ]; then
        echo "App trouvée dans le workspace après ${i}x0.5s"
        # App trouvée, on reste sur le workspace, ne rien faire
        exit 0
      fi
    done

    # Si on arrive ici, l'app n'est pas apparue dans le workspace
    # Chercher l'app dans un autre workspace et la déplacer
    echo "App pas trouvée dans le workspace, recherche..."
    APP_ADDRESS=$(hyprctl clients -j | jq -r ".[] | select(.pid == $APP_PID) | .address" | head -n 1)

    if [ -n "$APP_ADDRESS" ]; then
      echo "App trouvée ailleurs, déplacement..."
      hyprctl dispatch movetoworkspacesilent "$WORKSPACE,$APP_ADDRESS"
    fi
  else
    # L'app existe déjà, juste basculer vers le workspace
    hyprctl dispatch togglespecialworkspace "$WORKSPACE_NAME"
  fi
fi
