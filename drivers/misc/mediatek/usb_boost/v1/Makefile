ccflags-y += -I$(srctree)/drivers/misc/mediatek/usb_boost
ccflags-y += -I$(srctree)/drivers/misc/mediatek/include/mt-plat
ccflags-y += -I$(srctree)/drivers/devfreq
obj-$(CONFIG_MTK_USB_BOOST) := usb_boost_plat.o

ifeq (y, $(filter y, $(CONFIG_MACH_MT6739) $(CONFIG_MACH_MT6768) $(CONFIG_MACH_MT6781) \
$(CONFIG_MACH_MT6833) $(CONFIG_MACH_MT6877) $(CONFIG_MACH_MT6893) $(CONFIG_MACH_MT6853) $(CONFIG_MACH_MT6873)))
	ccflags-y += -DPM_QOS_API_V1
endif
