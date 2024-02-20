@echo off
title Eaglercraft Beta 1.3 Desktop Runtime
java -Xmx1G -Xms1G -Dsun.java2d.uiScale=1 -Djava.library.path=. -cp "eaglercraft.jar;lwjgl.jar;lwjgl_util.jar;Java-WebSocket-1.5.1-with-dependencies.jar" net.lax1dude.eaglercraft.MinecraftMain
pause