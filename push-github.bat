@echo off
REM Script para fazer push do Atlas Industrial para GitHub
REM Certifique-se de ter criado o repositório em https://github.com/new primeiro!

echo.
echo ============================================
echo  ATLAS INDUSTRIAL - Push para GitHub
echo ============================================
echo.

REM Solicita o nome de usuário do GitHub
set /p github_user="Digite seu username do GitHub: "

REM Verifica se o usuário foi fornecido
if "%github_user%"=="" (
    echo Erro: Username vazio!
    pause
    exit /b 1
)

echo.
echo Configurando repositório remoto...
echo Usuário: %github_user%
echo.

REM Adiciona origin remoto
git remote add origin https://github.com/%github_user%/atlas_industrial.git

REM Renomeia branch para main
echo Renomeando branch para main...
git branch -M main

REM Faz push
echo Fazendo push para GitHub...
git push -u origin main

echo.
if %errorlevel% equ 0 (
    echo ============================================
    echo ✅ Push realizado com sucesso!
    echo ============================================
    echo.
    echo Repositório: https://github.com/%github_user%/atlas_industrial
    echo.
    echo Próximos passos:
    echo 1. Aguarde os workflows executarem (Actions tab)
    echo 2. Baixe o build web compilado
    echo 3. Abra index.html em um navegador
    echo.
) else (
    echo ============================================
    echo ❌ Erro ao fazer push!
    echo ============================================
    echo.
    echo Possíveis causas:
    echo - Username incorreto
    echo - Repositório não existe em GitHub
    echo - Problemas de autenticação
    echo.
    echo Solução:
    echo 1. Crie repositório em https://github.com/new
    echo 2. Use seu username exato
    echo 3. Se pedindo senha, use token (veja PUSH_GUIDE_PT-BR.md)
    echo.
)

pause
