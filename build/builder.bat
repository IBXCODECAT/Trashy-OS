@echo off

echo compiling ASM using NASM...
nasm %~dp0/../src/boot.asm -f bin -o %~dp0/../build/bootloader.bin > compile-bootloader.log
nasm %~dp0/../src/extended.asm -f bin -o %~dp0/../build/extended.bin > compile-extended.log
echo Generated by builder.bat (C) 2021 IBXCODECAT >> compile-bootloader.log (errors above)
echo Generated by builder.bat (C) 2021 IBXCODECAT >> compile-extended.log (errors above)

echo relocating compiler logs...
if not exist logs/ (
	mkdir logs
)
move compile-bootloader.log %~dp0/logs/compile-bootloader.log
move compile-extended.log %~dp0/logs/compile-extended.log

echo writing disk image...
copy /b bootloader.bin+extended.bin garabage-os.iso

echo relocating binaries...
if not exist bin/ (
	mkdir bin
)
move bootloader.bin %~dp0/bin/bootloader.bin
move extended.bin %~dp0/bin/extended.bin

echo relocating disk image...
if not exist iso/ (
	mkdir iso
)
move garabage-os.iso %~dp0/iso/garabage-os.iso

start bochs-config.bxrc