# Trailer Animations Pack — Scaffold

Este repositório agora contém um scaffold para um Bedrock Add-on com animations e textures inspiradas no trailer do Minecraft.

O que eu adicionei:
- behavior_pack/manifest.json (já comitado previamente)
- resource_pack/manifest.json
- resource_pack/animations/trailer_swoop.animation.json
- resource_pack/animation_controllers/controller.trailer.camera.json
- resource_pack/textures/README_ADD_TEXTURES.txt (instruções para adicionar suas PNGs)

Como prosseguir (resumido):
1) Se você quer adicionar a textura que mostrou (lava/magma) e autorizou, faça upload do PNG como:
   resource_pack/textures/lava_magma.png

2) Substitua os UUIDs nos manifests por UUIDs próprios, se preferir. Ambos os manifests (behavior + resource) precisam ter UUIDs distintos.
   - Use um gerador de UUID v4.

3) Para empacotar: compacte as pastas `resource_pack/` e `behavior_pack/` juntas em um único ZIP e renomeie para `meu_pack.mcpack`.

4) Instale no Bedrock: abra o `.mcpack` no dispositivo ou coloque as pastas nas pastas `com.mojang/resource_packs/` e `com.mojang/behavior_packs/` do seu dispositivo.

5) Teste: aplique o `animation_controller` em uma entidade custom ou use um behavior que chame a animação. Exemplo mínimo de uso no entity JSON deve referenciar `controller.trailer.camera`.

Avisos legais rápidos:
- Você confirmou autorização para usar a imagem fornecida; eu não movi nem enviei a imagem automativamente. Faça upload manualmente se quiser que ela entre no repo.
- Não incluirei assets oficiais do trailer sem permissão.

Se quiser que eu faça upload da imagem que você enviou aqui, confirme explicitamente e anexe o arquivo PNG (ou diga que me autoriza a copiar a imagem já postada).