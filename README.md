# 🎬 Fresh Movies - Bedrock Edition

Pack de animações cinematográficas funcional para Minecraft Bedrock. Inspirado em Fresh Movies com foco **exclusivo no Player** (v2).

## 📋 Características

### Animações do Player Implementadas:
- ✅ **Idle** - Animação de repouso com movimento suave de respiração
- ✅ **Walking** - Caminhada fluida com movimento de braços e pernas
- ✅ **Running** - Corrida dinâmica com postura inclinada
- ✅ **Jumping** - Salto com compressão e extensão do corpo
- ✅ **Falling** - Queda com braços estendidos para equilíbrio
- ✅ **Swimming** - Nado em água com movimentos de braços
- ✅ **Sneaking** - Agachamento furtivo
- ✅ **Gliding** - Planar com asas de Elytra

### Estados de Controle:
- Transições automáticas entre estados
- Sistema de blending para suavidade
- Queries de movimento e ações do player

## 📁 Estrutura do Projeto

```
liga-dor-pilantra-mane/
├── resource_pack/
│   ├── manifest.json
│   ├── animations/
│   │   └── player.animation.json (8 animações)
│   └── animation_controllers/
│       └── player.animation_controllers.json
├── behavior_pack/
│   ├── manifest.json
│   └── entities/
│       └── player.entity.json
├── create_mcpack.sh
└── README.md
```

## 🎮 Como Usar

### Opção 1: Instalação Manual
1. Copie as pastas `resource_pack` e `behavior_pack` para seu dispositivo
2. Abra Minecraft Bedrock
3. Vá para **Configurações > Pacotes Globais**
4. Selecione ambos os packs e ative-os
5. Crie um novo mundo com os packs ativados

### Opção 2: Usar o Script (Recomendado)
```bash
chmod +x create_mcpack.sh
./create_mcpack.sh
```
Isso criará um arquivo `.mcpack` pronto para instalação.

## 🎨 Detalhes Técnicas

### Animações por Keyframe:
- **Duração**: Otimizada entre 0.4s a 1.0s
- **Loop**: Animações de movimento repetem continuamente
- **Rotação/Posição**: Valores precisos para cada osso

### Ossos Animados:
- `body` - Tronco (rotação e posição)
- `head` - Cabeça (rotação independente)
- `leftarm` / `rightarm` - Braços
- `leftleg` / `rightleg` - Pernas

### Animation Controllers:
- `controller.animation.player.move` - Gerencia movimentação
- `controller.animation.player.look` - Controla visão
- `controller.animation.player.damage` - Resposta a danos

## 📊 Queries Utilizadas

```
query.is_jumping         - Detecta pulo
query.is_falling         - Detecta queda
query.is_in_water        - Detecta água
query.is_sneaking        - Detecta agachamento
query.is_gliding         - Detecta planejamento
query.is_moving          - Detecta movimento
query.is_on_ground       - Detecta contato com chão
query.modified_move_speed - Velocidade de movimento
```

## 🔧 Customização

### Ajustar Velocidade de Animação:
No arquivo `player.animation_controllers.json`, modifique:
```json
"playback_rate": 1.5  // Aumentar para mais rápido, diminuir para mais lento
```

### Alterar Ângulos de Rotação:
No arquivo `player.animation.json`, edite os valores de rotação (em graus):
```json
"rotation": {
  "0.0": [0, 0, 0],
  "0.5": [10, 0, 0],  // Aumentar para mais rotação
  "1.0": [0, 0, 0]
}
```

## 📦 Dependências

- **Minecraft Bedrock**: v1.19.0 ou superior
- **UUIDs**: Únicos para cada pack

## 🐛 Troubleshooting

| Problema | Solução |
|----------|---------|
| Animações não funcionam | Certifique-se de que ambos os packs estão habilitados |
| Player fica travado | Verifique se o `animation_controller` está correto |
| Movimento estranho | Reduza os valores de rotação em `player.animation.json` |

## 📝 Roadmap v3

- [ ] Animações de ataque (com espada, arco, etc)
- [ ] Animações de armas de duas mãos
- [ ] Emotes e dança
- [ ] Animações de morte customizadas
- [ ] Suporte a mobs (Zombie, Skeleton, etc)

## 📄 Licença

Este projeto é de código aberto e pode ser livremente modificado e distribuído.

## 🎓 Créditos

- **Inspiração**: Fresh Movies (Pack de Animações Original)
- **Desenvolvimento**: Fresh Movies Bedrock v2.0.0
- **Versão Bedrock**: Portada para compatibilidade total

---

**Versão**: 2.0.0 | **Última Atualização**: 2026-08-05
