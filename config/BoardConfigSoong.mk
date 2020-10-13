PATH_OVERRIDE_SOONG := $(shell echo $(TOOLS_PATH_OVERRIDE))

# Add variables that we wish to make available to soong here.
EXPORT_TO_SOONG := \
    KERNEL_ARCH \
    KERNEL_BUILD_OUT_PREFIX \
    KERNEL_CROSS_COMPILE \
    KERNEL_MAKE_CMD \
    KERNEL_MAKE_FLAGS \
    PATH_OVERRIDE_SOONG \
    TARGET_KERNEL_CONFIG \
    TARGET_KERNEL_SOURCE

# Setup SOONG_CONFIG_* vars to export the vars listed above.
# Documentation here:
# https://github.com/LineageOS/android_build_soong/commit/8328367c44085b948c003116c0ed74a047237a69

SOONG_CONFIG_NAMESPACES += styxVarsPlugin

SOONG_CONFIG_styxVarsPlugin :=

define addVar
  SOONG_CONFIG_styxVarsPlugin += $(1)
  SOONG_CONFIG_styxVarsPlugin_$(1) := $$(subst ",\",$$($1))
endef

$(foreach v,$(EXPORT_TO_SOONG),$(eval $(call addVar,$(v))))

SOONG_CONFIG_NAMESPACES += styxGlobalVars
SOONG_CONFIG_styxGlobalVars += \
    additional_gralloc_10_usage_bits \
    supports_extended_compress_format \
    target_init_vendor_lib \
    uses_qti_camera_device

SOONG_CONFIG_NAMESPACES += styxQcomVars
SOONG_CONFIG_styxQcomVars += \
    uses_pre_uplink_features_netmgrd

# Only create display_headers_namespace var if dealing with UM platforms to avoid breaking build for all other platforms
ifneq ($(filter $(UM_PLATFORMS),$(TARGET_BOARD_PLATFORM)),)
SOONG_CONFIG_styxGlobalVars += \
    qcom_display_headers_namespace
endif

# Soong bool variables
SOONG_CONFIG_styxGlobalVars_supports_extended_compress_format := $(AUDIO_FEATURE_ENABLED_EXTENDED_COMPRESS_FORMAT)
SOONG_CONFIG_styxGlobalVars_uses_qti_camera_device := $(TARGET_USES_QTI_CAMERA_DEVICE)
SOONG_CONFIG_styxQcomVars_uses_pre_uplink_features_netmgrd := $(TARGET_USES_PRE_UPLINK_FEATURES_NETMGRD)

# Set default values
TARGET_INIT_VENDOR_LIB ?= vendor_init

# Soong value variables
SOONG_CONFIG_styxGlobalVars_additional_gralloc_10_usage_bits := $(TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS)
SOONG_CONFIG_styxGlobalVars_target_init_vendor_lib := $(TARGET_INIT_VENDOR_LIB)
ifneq ($(filter $(QSSI_SUPPORTED_PLATFORMS),$(TARGET_BOARD_PLATFORM)),)
SOONG_CONFIG_styxGlobalVars_qcom_display_headers_namespace := vendor/qcom/opensource/commonsys-intf/display
else
SOONG_CONFIG_styxGlobalVars_qcom_display_headers_namespace := $(QCOM_SOONG_NAMESPACE)/display
endif
