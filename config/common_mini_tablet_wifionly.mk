# Inherit mobile mini common Blaze stuff
$(call inherit-product, vendor/blaze/config/common_mobile_mini.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME
