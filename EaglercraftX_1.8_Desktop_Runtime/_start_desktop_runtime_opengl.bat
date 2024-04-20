@echo off
title EaglercraftX 1.8 Desktop Runtime (OpenGL)
java -Xmx1G -Xms1G -Djava.library.path=. -cp "eaglercraft.jar;lwjgl.jar;lwjgl-egl.jar;lwjgl-glfw.jar;lwjgl-jemalloc.jar;lwjgl-openal.jar;lwjgl-opengles.jar;soundsystem-20120107.jar;codecjorbis-20101023.jar;codecwav-20101023.jar;Java-WebSocket-1.5.1-with-dependencies.jar;webrtc-java-0.8.0.jar;UnsafeMemcpy.jar" net.lax1dude.eaglercraft.v1_8.internal.lwjgl.MainClass opengl hide-renderdoc
pause