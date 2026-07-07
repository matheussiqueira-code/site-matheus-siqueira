# Simula a chegada de um novo artigo do LinkedIn: insere um item de teste no
# topo do artigos.json. Recarregue o site para ver o novo card aparecer.
#
# Uso:
#   powershell -ExecutionPolicy Bypass -File .\test-novo-artigo.ps1            # insere o artigo de teste
#   powershell -ExecutionPolicy Bypass -File .\test-novo-artigo.ps1 -Desfazer  # remove os artigos de teste
param([switch]$Desfazer)

$json = Join-Path $PSScriptRoot "artigos.json"
if (-not (Test-Path $json)) { Write-Error "artigos.json não encontrado em $PSScriptRoot"; exit 1 }

# No PS 5.1 ConvertFrom-Json emite o array JSON como objeto único; o ForEach-Object
# enumera os itens para obter um array plano de artigos
$parsed = ConvertFrom-Json ([System.IO.File]::ReadAllText($json))
$artigos = @($parsed | ForEach-Object { $_ })

if ($Desfazer) {
    $artigos = @($artigos | Where-Object { $_.titulo -notlike "``[TESTE``]*" })
    Write-Host "Artigos de teste removidos. Restam $($artigos.Count) artigo(s)."
} else {
    $novo = [pscustomobject]@{
        titulo          = "[TESTE] SROI na prática: o que cada real investido devolve"
        resumo          = "Artigo de teste inserido pelo script test-novo-artigo.ps1 para validar o fluxo de ponta a ponta: parse do JSON, validação, renderização do card com imagem de capa e link para o LinkedIn."
        url_imagem_capa = "https://picsum.photos/seed/sroi/700/394"
        link_artigo     = "https://www.linkedin.com/in/matheussiqueira2/recent-activity/all/"
        data            = (Get-Date).ToString("yyyy-MM-dd")
        pilar           = "P2"
    }
    $artigos = @($novo) + $artigos
    Write-Host "Artigo de teste inserido. Total: $($artigos.Count) artigo(s). Recarregue o site."
}

$enc = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($json, (ConvertTo-Json -InputObject $artigos -Depth 4), $enc)
