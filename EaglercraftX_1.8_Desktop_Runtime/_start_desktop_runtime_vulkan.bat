@echo off
title EaglercraftX 1.8 Desktop Runtime (Vulkan)
java -Xmx1G -Xms1G -Djava.library.path=. -cp ./* net.lax1dude.eaglercraft.v1_8.internal.lwjgl.MainClass vulkan
pause