@echo off
cd /d %~dp0
ts-node ./configs.ts %*
