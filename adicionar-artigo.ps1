# Adiciona um artigo ao topo do artigos.json (mais recente primeiro).
# Trata o encoding UTF-8 e valida os campos automaticamente.
#
# Exemplo:
#   .\adicionar-artigo.ps1 -Titulo "Meu artigo" -Link "https://www.linkedin.com/posts/..." `
#       -Resumo "Um resumo curto do artigo." -Imagem "https://.../capa.jpg" -Pilar "P2" -Data "JUL 2026"
#
# Só Titulo e Link são obrigatórios. Imagem, Resumo, Pilar e Data são opcionais.
param(
    [Parameter(Mandatory=$true)][string]$Titulo,
    [Parameter(Mandatory=$true)][string]$Link,
    [string]$Resumo = "",
    [string]$Imagem = "",
    [string]$Pilar  = "",
    [string]$Data   = ""
)

$ErrorActionPreference = "Stop"
$json = Join-Path $PSScriptRoot "artigos.json"

# --- Validação ---
if ($Link -notmatch '^https?://') { Write-Error "O -Link precisa começar com http:// ou https://"; exit 1 }
if ($Imagem -and $Imagem -notmatch '^https?://') { Write-Error "A -Imagem precisa começar com http:// ou https:// (ou deixe em branco)"; exit 1 }
if (-not $Data) { $Data = (Get-Date).ToString("yyyy-MM-dd") }

# --- Lê o arquivo atual (ou começa vazio) ---
if (Test-Path $json) {
    $parsed  = ConvertFrom-Json ([System.IO.File]::ReadAllText($json))
    $artigos = @($parsed | ForEach-Object { $_ })
} else {
    $artigos = @()
}

$novo = [pscustomobject]@{
    titulo          = $Titulo
    resumo          = $Resumo
    url_imagem_capa = $Imagem
    link_artigo     = $Link
    data            = $Data
    pilar           = $Pilar
}

$artigos = @($novo) + $artigos

# --- Grava em UTF-8 SEM BOM (JSON limpo que o site lê corretamente) ---
$enc = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($json, (ConvertTo-Json -InputObject $artigos -Depth 4), $enc)

Write-Host "Artigo adicionado. Total: $($artigos.Count) artigo(s)." -ForegroundColor Green
Write-Host "Recarregue o site para ver o card novo."
