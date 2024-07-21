# Inherit mobile mini common Blaze stuff
$(call inherit-product, vendor/blaze/config/common_mobile_mini.mk)

# Inherit tablet common Blaze stuff
$(call inherit-product, vendor/blaze/config/tablet.mk)

$(call inherit-product, vendor/blaze/config/telephony.mk)
