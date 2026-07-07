# Site — Matheus Siqueira

Site pessoal (one-page) publicado em [matheussiqueira2.com.br](https://matheussiqueira2.com.br).

## Estrutura

- `index.html` — o site inteiro (HTML, CSS e JS embutidos; fontes e imagem do hero em base64).
- `artigos.json` — fonte dos cards da seção "Conteúdo em destaque".
- `capas/` — imagens de capa dos artigos.
- `og-image.jpg` — imagem de compartilhamento (Open Graph).

## Publicação

Hospedado no Vercel, conectado a este repositório: todo push na branch `main`
publica automaticamente. Site estático, sem etapa de build.

## Como adicionar artigos

Veja [COMO-ADICIONAR-ARTIGOS.md](COMO-ADICIONAR-ARTIGOS.md). Em resumo: adicione um
item ao `artigos.json` (ou rode `adicionar-artigo.ps1`) e envie pelo GitHub Desktop.
