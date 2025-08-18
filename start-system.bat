@echo off
title HP数据库认证系统
color 0A

echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║                HP数据库认证系统 - 启动控制台                 ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.

:MENU
echo 请选择操作：
echo.
echo [1] 安装Node.js (首次使用必须)
echo [2] 启动本地服务器
echo [3] 查看系统状态
echo [4] 部署到云端 (24小时在线)
echo [5] 查看管理后台
echo [6] 测试邮件功能
echo [7] 退出
echo.
set /p choice=请输入选项 (1-7): 

if "%choice%"=="1" goto INSTALL_NODEJS
if "%choice%"=="2" goto START_SERVER
if "%choice%"=="3" goto CHECK_STATUS
if "%choice%"=="4" goto DEPLOY_CLOUD
if "%choice%"=="5" goto ADMIN_PANEL
if "%choice%"=="6" goto TEST_EMAIL
if "%choice%"=="7" goto EXIT
goto MENU

:INSTALL_NODEJS
echo.
echo 正在安装Node.js...
call install-nodejs.bat
pause
goto MENU

:START_SERVER
echo.
echo 检查Node.js安装...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误: 未检测到Node.js，请先选择选项1安装
    pause
    goto MENU
)

echo 安装依赖包...
npm install --silent

echo.
echo 启动HP数据库认证系统...
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo  系统地址: http://localhost:3000
echo  管理后台: http://localhost:3000/admin.html
echo  按 Ctrl+C 停止服务器
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo.

start http://localhost:3000
npm start
goto MENU

:CHECK_STATUS
echo.
echo 系统状态检查...
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

node --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✓ Node.js: 已安装
    node --version
) else (
    echo ✗ Node.js: 未安装
)

npm --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✓ NPM: 已安装
    npm --version
) else (
    echo ✗ NPM: 未安装
)

if exist "node_modules" (
    echo ✓ 依赖包: 已安装
) else (
    echo ✗ 依赖包: 未安装
)

if exist "database.sqlite" (
    echo ✓ 数据库: 已创建
) else (
    echo ✗ 数据库: 未创建
)

if exist ".env" (
    echo ✓ 配置文件: 存在
) else (
    echo ✗ 配置文件: 需要配置邮箱
)

echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
pause
goto MENU

:DEPLOY_CLOUD
echo.
echo 云端部署选项...
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo.
echo [A] Vercel部署 (推荐，免费)
echo [B] Railway部署 (简单快速)
echo [C] Netlify部署 (稳定可靠)
echo [D] 查看部署指南
echo [E] 返回主菜单
echo.
set /p deploy_choice=请选择部署方式: 

if "%deploy_choice%"=="A" goto VERCEL_DEPLOY
if "%deploy_choice%"=="B" goto RAILWAY_DEPLOY
if "%deploy_choice%"=="C" goto NETLIFY_DEPLOY
if "%deploy_choice%"=="D" goto DEPLOY_GUIDE
if "%deploy_choice%"=="E" goto MENU
goto DEPLOY_CLOUD

:VERCEL_DEPLOY
echo.
echo Vercel部署步骤：
echo 1. 访问 https://vercel.com
echo 2. 使用GitHub登录
echo 3. 创建新项目并上传代码
echo 4. 配置环境变量
echo 5. 部署完成获得永久域名
echo.
start https://vercel.com
pause
goto MENU

:RAILWAY_DEPLOY
echo.
echo Railway部署步骤：
echo 1. 访问 https://railway.app
echo 2. 连接GitHub仓库
echo 3. 配置环境变量
echo 4. 自动部署完成
echo.
start https://railway.app
pause
goto MENU

:NETLIFY_DEPLOY
echo.
echo Netlify部署步骤：
echo 1. 访问 https://netlify.com
echo 2. 拖拽项目文件夹
echo 3. 配置环境变量
echo 4. 完成部署
echo.
start https://netlify.com
pause
goto MENU

:DEPLOY_GUIDE
echo.
echo 正在打开部署指南...
start deploy-guide.md
pause
goto MENU

:ADMIN_PANEL
echo.
echo 正在打开管理后台...
echo 如果服务器未启动，请先选择选项2启动服务器
start http://localhost:3000/admin.html
pause
goto MENU

:TEST_EMAIL
echo.
echo 邮件功能测试...
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo.
echo 请确保已在.env文件中配置邮箱信息：
echo EMAIL_USER=your_email@gmail.com
echo EMAIL_PASS=your_app_password
echo ADMIN_EMAIL=a178152369463@163.com
echo.
echo 测试步骤：
echo 1. 启动服务器 (选项2)
echo 2. 访问网站注册新用户
echo 3. 检查邮箱是否收到验证码
echo 4. 检查管理员邮箱是否收到通知
echo.
pause
goto MENU

:EXIT
echo.
echo 感谢使用HP数据库认证系统！
echo 系统已完全配置，可随时启动使用。
echo.
pause
exit

:ERROR
echo.
echo 发生错误，请检查系统配置
pause
goto MENU
