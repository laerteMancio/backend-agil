@echo off
setlocal enabledelayedexpansion

:: Primeiro parâmetro = tipo (NFE ou RELATORIO)
set "TIPO=%~1"
if "%TIPO%"=="" set "TIPO=NFE"

:: Demais parâmetros
set "DESTINATARIOS=%~2"
set "ASSUNTO=%~3"
set "MENSAGEM=%~4"

:: Monta anexos dinamicamente a partir do 5º parâmetro
set "ANEXOS="
set i=5
:loop
call set "ARQ=%%%i%%%"
if defined ARQ (
    set "ARQ=!ARQ:\=/!"
    if exist "!ARQ!" (
        set "ANEXOS=!ANEXOS! -F attachments=@!ARQ!;type=application/octet-stream"
    )
    set /a i+=1
    goto :loop
)

set "API_URL=https://backend-agil.vercel.app/send-email"

echo Enviando email do tipo "!TIPO!" para !DESTINATARIOS! com assunto "!ASSUNTO!" ...
echo Mensagem: !MENSAGEM!
echo Anexos: !ANEXOS!
echo.

:: Executa o curl
curl -k -X POST "!API_URL!" ^
  -F "tipo=!TIPO!" ^
  -F "to=!DESTINATARIOS!" ^
  -F "subject=!ASSUNTO!" ^
  -F "text=!MENSAGEM!" !ANEXOS!

echo.
echo Processo finalizado.

endlocal
