#!/usr/bin/env bash
set -euo pipefail

WORKDIR="LeagueOfMaster_mcpack"
BP="$WORKDIR/LeagueOfMaster_behavior_pack"
RP="$WORKDIR/LeagueOfMaster_resource_pack"

echo "Limpando trabalho anterior..."
rm -rf "$WORKDIR" LeagueOfMaster.mcpack

echo "Criando diretórios..."
mkdir -p "$BP/items" "$BP/scripts" "$RP/textures/items" "$RP/textures/logo"

echo "Criando arquivos..."

cat > "$BP/manifest.json" <<'EOF'
{
  "format_version": 2,
  "header": {
    "name": "League of Master — Behavior Pack",
    "description": "League of Master v1 — Sistema RPG: encantamentos, habilidades de magma e status",
    "uuid": "f3a1b2c3-9d3e-4bd2-8d2c-111111abcdef",
    "version": [1, 0, 0],
    "min_engine_version": [1, 18, 0]
  },
  "modules": [
    {
      "type": "data",
      "uuid": "a1b2c3d4-2f3e-4a5b-9c4d-222222abcdef",
      "version": [1, 0, 0]
    },
    {
      "type": "scripting",
      "uuid": "b2c3d4e5-3f4a-4b6c-8d5e-333333abcdef",
      "version": [1, 0, 0]
    }
  ]
}
EOF

cat > "$RP/manifest.json" <<'EOF'
{
  "format_version": 2,
  "header": {
    "name": "League of Master — Resource Pack",
    "description": "Assets: texturas e ícones para League of Master v1",
    "uuid": "c4d5e6f7-4a5b-4c6d-9e6f-444444abcdef",
    "version": [1, 0, 0],
    "min_engine_version": [1, 18, 0]
  },
  "modules": [
    {
      "type": "resources",
      "uuid": "d5e6f7a8-5b6c-4d7e-8f7a-555555abcdef",
      "version": [1, 0, 0]
    }
  ]
}
EOF

cat > "$BP/items/magma_fruit.json" <<'EOF'
{
  "format_version": "1.16.0",
  "minecraft:item": {
    "description": {
      "identifier": "lotm:magma_fruit",
      "category": "Misc",
      "is_experimental": false
    },
    "components": {
      "minecraft:icon": "textures/items/magma_fruit",
      "minecraft:use_duration": 32,
      "minecraft:food": {
        "nutrition": 6,
        "saturation_modifier": "normal",
        "can_always_eat": false
      },
      "minecraft:display_name": "Fruta do Magma"
    }
  }
}
EOF

cat > "$BP/items/enchant_scroll.json" <<'EOF'
{
  "format_version": "1.16.0",
  "minecraft:item": {
    "description": {
      "identifier": "lotm:enchant_scroll",
      "category": "Misc",
      "is_experimental": false
    },
    "components": {
      "minecraft:icon": "textures/items/enchant_scroll",
      "minecraft:use_duration": 16,
      "lotm:scroll": {
        "enchant_type": "sharpness",
        "level": 10
      },
      "minecraft:display_name": "Pergaminho de Encantamento (exemplo)"
    }
  }
}
EOF

cat > "$BP/items/double_jump_token.json" <<'EOF'
{
  "format_version": "1.16.0",
  "minecraft:item": {
    "description": {
      "identifier": "lotm:double_jump_token",
      "category": "Misc",
      "is_experimental": false
    },
    "components": {
      "minecraft:icon": "textures/items/double_jump_token",
      "minecraft:use_duration": 10,
      "minecraft:display_name": "Token: Pulo Duplo (use para desbloquear)"
    }
  }
}
EOF

cat > "$BP/items/ferreiro_spawner.json" <<'EOF'
{
  "format_version": "1.16.0",
  "minecraft:item": {
    "description": {
      "identifier": "lotm:ferreiro_spawner",
      "category": "Misc",
      "is_experimental": false
    },
    "components": {
      "minecraft:icon": "textures/items/ferreiro_spawner",
      "minecraft:use_duration": 1,
      "minecraft:display_name": "Chamada do Ferreiro LoM"
    }
  }
}
EOF

cat > "$BP/scripts/main.js" <<'EOF'
// League of Master — v1 script (protótipo)
var system = server.registerSystem(0, 0);
let playerState = {};
system.initialize = function() {
  this.listenForEvent("minecraft:player_used_item", onPlayerUseItem);
  this.listenForEvent("minecraft:entity_hurt", onEntityHurt);
  this.listenForEvent("minecraft:tick", onTick);
  this.log("League of Master v1 script iniciado");
};
function playerKeyFromEntity(entity) { if (!entity) return null; return entity.__unique_id || entity.entity_id || entity.name || null; }
function ensurePlayerState(key){ if (!playerState[key]) playerState[key] = {cooldowns:{},flags:{},usedDoubleJump:false}; return playerState[key]; }
function onPlayerUseItem(eventData){
  try {
    let player = eventData.data.player || eventData.data.entity;
    if (!player) return;
    let item = eventData.data && eventData.data.item_stack ? eventData.data.item_stack : null;
    let itemId = item && item.item ? item.item : (eventData.data.item ? eventData.data.item : null);
    let key = playerKeyFromEntity(player);
    let st = ensurePlayerState(key);
    if (itemId === "lotm:magma_fruit") {
      st.flags.magma_eaten = Date.now() + 1000*60*60*24;
      sendMessage(player, "Você ingeriu a Fruta do Magma! Ferreiro desbloqueado (v1).");
      applyEffect(player, "minecraft:resistance", 60);
      return;
    }
    if (itemId === "lotm:double_jump_token") { st.flags.double_jump = true; sendMessage(player, "Pulo duplo desbloqueado!"); return; }
    if (itemId === "lotm:enchant_scroll") { sendMessage(player, "Pergaminho usado (protótipo)."); return; }
    if (itemId === "lotm:ferreiro_spawner") { if (st.flags.magma_eaten && st.flags.magma_eaten > Date.now()) spawnFerreiroForPlayer(player); else sendMessage(player, "Coma a Fruta do Magma primeiro."); return; }
  } catch(e){ system.log("onPlayerUseItem error: "+e); }
}
function onEntityHurt(e){ /* protótipo */ }
function onTick(e){ /* protótipo */ }
function getEntityName(entity){ return entity && (entity.name || entity.__name || entity.__unique_id) || null; }
function sendMessage(playerEntity, text){ let name = getEntityName(playerEntity) || ""; system.executeCommand(`/tellraw "${name}" {"rawtext":[{"text":"${text}"}]}`, ()=>{}); }
function applyEffect(playerEntity, effectId, seconds){ let name = getEntityName(playerEntity); if (!name) return; system.executeCommand(`/effect "${name}" ${effectId} ${seconds} true`, ()=>{}); }
function spawnFerreiroForPlayer(playerEntity){ let name = getEntityName(playerEntity); if (!name) return; system.executeCommand(`/execute "${name}" ~ ~ ~ summon villager ~ ~1 ~ {"CustomName":"\\"Ferreiro LoM\\"","Offers":{}}`, ()=>{}); sendMessage(playerEntity, "Ferreiro LoM spawnado (protótipo)."); }
EOF

cat > "$RP/textures/logo/league_of_master_logo.svg" <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<svg width="256" height="256" viewBox="0 0 1024 1024" xmlns="http://www.w3.org/2000/svg">
  <defs><linearGradient id="g1" x1="0" x2="1" y1="0" y2="1"><stop offset="0" stop-color="#ff8a00"/><stop offset="1" stop-color="#ff2d00"/></linearGradient></defs>
  <path d="M512 80 L768 180 L768 520 C768 720 640 840 512 880 C384 840 256 720 256 520 L256 180 Z" fill="url(#g1)"/>
  <text x="512" y="980" font-family="Verdana, Arial" font-size="64" fill="#fff" text-anchor="middle">League of Master</text>
</svg>
EOF

cat > "$RP/textures/items/magma_fruit.svg" <<'EOF'
<svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 64 64"><rect width="64" height="64" rx="8" fill="#ff6f00"/><circle cx="32" cy="28" r="12" fill="#fff3d6"/></svg>
EOF

cat > "$RP/textures/items/enchant_scroll.svg" <<'EOF'
<svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 64 64"><rect width="64" height="64" rx="8" fill="#f5f5f5" stroke="#d0d7de"/><text x="32" y="38" font-size="10" text-anchor="middle">SCRL</text></svg>
EOF

cat > "$RP/textures/items/double_jump_token.svg" <<'EOF'
<svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 64 64"><rect width="64" height="64" rx="8" fill="#e6f7ff"/><text x="32" y="38" font-size="12" text-anchor="middle">2x</text></svg>
EOF

cat > "$RP/textures/items/ferreiro_spawner.svg" <<'EOF'
<svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 64 64"><rect width="64" height="64" rx="8" fill="#f3e8ff"/><text x="32" y="38" font-size="12" text-anchor="middle">F</text></svg>
EOF

cat > README.md <<'EOF'
# League of Master — gerado localmente

Script cria behavior + resource packs e empacota em LeagueOfMaster.mcpack.

Use ImageMagick (opcional) para converter SVG → PNG, se necessário para seu cliente Bedrock.
EOF

echo "Tentando converter SVGs para PNG (se ImageMagick estiver instalado)..."
if command -v magick >/dev/null 2>&1; then
  magick convert "$RP/textures/logo/league_of_master_logo.svg" -resize 256x256 "$RP/textures/logo/league_of_master_logo.png" || true
  for f in "$RP/textures/items/"*.svg; do
    name=$(basename "$f" .svg)
    magick convert "$f" -resize 64x64 "$RP/textures/items/${name}.png" || true
  done
  echo "Conversão com 'magick' concluída."
elif command -v convert >/dev/null 2>&1; then
  convert "$RP/textures/logo/league_of_master_logo.svg" -resize 256x256 "$RP/textures/logo/league_of_master_logo.png" || true
  for f in "$RP/textures/items/"*.svg; do
    name=$(basename "$f" .svg)
    convert "$f" -resize 64x64 "$RP/textures/items/${name}.png" || true
  done
  echo "Conversão com 'convert' concluída."
else
  echo "ImageMagick não encontrado — mantive os SVGs como placeholders."
fi

echo "Compactando em LeagueOfMaster.mcpack..."
zip -r -q LeagueOfMaster.mcpack "$WORKDIR"

echo "Pronto. Arquivo gerado: $(pwd)/LeagueOfMaster.mcpack"
