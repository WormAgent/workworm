# Abre el tablero de WorkWorm; si no esta corriendo, lo levanta primero (sin ventana). Sirve para un acceso directo.
$root = $PSScriptRoot
$url = 'http://127.0.0.1:8501'

function Test-Tablero {
    try { $c = New-Object Net.Sockets.TcpClient; $c.Connect('127.0.0.1', 8501); $c.Close(); return $true } catch { return $false }
}

if (-not (Test-Tablero)) {
    Start-Process -FilePath "$root\.venv\Scripts\pythonw.exe" -ArgumentList 'launcher.pyw', 'board' -WorkingDirectory $root
    for ($i = 0; $i -lt 90 -and -not (Test-Tablero); $i++) { Start-Sleep -Milliseconds 500 }
}

Start-Process $url
