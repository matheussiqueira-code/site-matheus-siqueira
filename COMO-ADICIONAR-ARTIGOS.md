# Como adicionar artigos ao site

Os artigos que aparecem na seção **"Conteúdo em destaque"** vêm do arquivo
`artigos.json`. Cada artigo é um bloco. O mais recente aparece primeiro.

> **Por que não puxa direto do LinkedIn?** O LinkedIn bloqueia que outros sites
> leiam seus posts (exige login e não oferece feed público). Por isso o conteúdo
> é alimentado por aqui — é o método mais confiável e não depende de terceiros.

---

## Jeito fácil (recomendado): pelo script

Abra o PowerShell na pasta do site e rode:

```powershell
.\adicionar-artigo.ps1 -Titulo "Título do artigo" -Link "https://www.linkedin.com/posts/SEU-POST" -Resumo "Um resumo de 1 ou 2 frases." -Imagem "https://.../capa.jpg" -Pilar "P2" -Data "JUL 2026"
```

- **Obrigatórios:** `-Titulo` e `-Link`.
- **Opcionais:** `-Resumo`, `-Imagem`, `-Pilar` (P1 a P4) e `-Data`. Sem `-Data`, entra a data de hoje.
- O script valida os links, cuida da acentuação e coloca o artigo no topo.

Depois, recarregue o site.

---

## Jeito manual: editando o artigos.json

Abra `artigos.json` num editor de texto e copie um bloco. Exemplo com dois artigos:

```json
[
  {
    "titulo": "Título do artigo mais novo",
    "resumo": "Resumo curto que aparece no card.",
    "url_imagem_capa": "https://.../capa.jpg",
    "link_artigo": "https://www.linkedin.com/posts/SEU-POST",
    "data": "JUL 2026",
    "pilar": "P2"
  },
  {
    "titulo": "Título de um artigo mais antigo",
    "resumo": "Outro resumo.",
    "url_imagem_capa": "",
    "link_artigo": "https://www.linkedin.com/posts/OUTRO-POST",
    "data": "JUN 2026",
    "pilar": "P4"
  }
]
```

Regras:
- Os blocos ficam entre `[` e `]`, separados por **vírgula**.
- `url_imagem_capa` pode ficar vazia (`""`) — o card aparece sem imagem.
- Salve o arquivo em **UTF-8** para os acentos não quebrarem.

---

## Como pegar o link certo de um post do LinkedIn

No post publicado, clique nos três pontinhos (**...**) no canto superior direito →
**"Copiar link para a publicação"**. Cole esse link em `link_artigo`.
Ele fica no formato `https://www.linkedin.com/posts/...` ou `.../feed/update/...`.

## Como pegar a imagem de capa

O ideal é hospedar a imagem junto com o site (ex.: uma pasta `capas/` e usar
`capas/meu-artigo.jpg`) ou usar uma URL pública de imagem. Links de imagem
internos do LinkedIn costumam expirar, então evite copiá-los direto de lá.

---

## Testar sem mexer no conteúdo real

`.\test-novo-artigo.ps1` insere um artigo `[TESTE]` para você ver como fica,
e `.\test-novo-artigo.ps1 -Desfazer` remove.
