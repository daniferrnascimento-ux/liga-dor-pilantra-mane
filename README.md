# Pack de Animações — Liga do Pilantra (Bedrock 1.26.40)

Este diretório contém um exemplo de resource pack + behavior pack com modelos e animações compatíveis com Bedrock Edition (versão 1.26.40).

O que tem aqui
- resource_pack/manifest.json — metadados do resource pack
- resource_pack/models/entity/player.geo.json — modelo geométrico simples (importável no Blockbench)
- resource_pack/animations/*.animation.json — animações (idle, walk, run, jump)
- resource_pack/particles/pilot_spark.particle.json — exemplo de efeito de partícula
- behavior_pack/manifest.json — metadados do behavior pack
- behavior_pack/animation_controllers/player.controller.json — exemplo de controller que troca animações

Como importar no Blockbench (passo a passo)
1) Abra o Blockbench (recomendado Blockbench 4.x com MCBE add-on instalado).
2) File > Import > Bedrock model
   - Selecione `resource_pack/models/entity/player.geo.json` para carregar o modelo.
3) Para importar animações:
   - Animation > Import > Bedrock animation
   - Escolha os arquivos em resource_pack/animations/*.animation.json
4) Teste as animações no Blockbench usando o painel de animações.

Como gerar um .mcpack (instalável no Minecraft)
- Compacte individualmente cada pack (resource_pack e behavior_pack) em .zip e renomeie para .mcpack;
- OU coloque as duas pastas dentro de um zip e altere a extensão para .mcpack (algumas versões pedem os dois packs separados sob Pastas com manifest);
- Instale no dispositivo Bedrock e ative tanto Behavior Pack quanto Resource Pack para ver as animações.

Compatibilidade e notas
- Arquivos foram feitos para serem compatíveis com Bedrock 1.26.40 e Blockbench. Alguns campos podem precisar de ajustes para modelos complexos.
- As animações são exemplos base — ajuste pivôs e keyframes no Blockbench para refinar.

Se você quiser que eu exporte um .mcpack pronto e adicione aqui o binário, confirme que quer o arquivo grande no repo (isso aumenta o tamanho do repositório).