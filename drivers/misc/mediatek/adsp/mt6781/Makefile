# SPDX-License-Identifier: GPL-2.0

ADSP_VERSION := common_v2
ADSP_VERSION_PATH := ../$(ADSP_VERSION)

ifeq ($(CONFIG_MACH_MT6781),y)
AUDIO_PLATFORM := mt6781
endif

obj-y += $(ADSP_VERSION_PATH)/
obj-y += adsp_awake.o
obj-y += adsp_clk.o
obj-y += adsp_bus_monitor.o
obj-y += adsp_reserved_mem.o
obj-y += adsp_platform_driver.o adsp_platform.o
obj-y += adsp_ipi.o
obj-$(CONFIG_MTK_AEE_FEATURE) += adsp_excep.o

ccflags-y += -I$(srctree)/drivers/misc/mediatek/adsp/common_v2
ccflags-y += -I$(srctree)/drivers/misc/mediatek/audio_ipi/common_v2/framework
ccflags-y += -I$(srctree)/drivers/misc/mediatek/include/mt-plat/$(CONFIG_MTK_PLATFORM)/include/mach
ccflags-y += -I$(srctree)/drivers/misc/mediatek/emi/submodule
ccflags-y += -I$(srctree)/drivers/misc/mediatek/emi/$(CONFIG_MTK_PLATFORM)
ccflags-y += -I$(srctree)/sound/soc/mediatek/$(AUDIO_PLATFORM)

ifeq ($(CONFIG_MTK_ENG_BUILD),y)
CFLAGS_adsp_excep.o += -DDEBUG
endif
