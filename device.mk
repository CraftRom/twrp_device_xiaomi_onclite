#
# Copyright (C) 2022 Team Win Recovery Project
# Copyright (C) 2022 The OrangeFox Recovery Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit AOSP product makefiles
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# Dynamic Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_RETROFIT_DYNAMIC_PARTITIONS := true

# Boot animation
TARGET_SCREEN_HEIGHT := 1520
TARGET_SCREEN_WIDTH := 720

# Crypto
PRODUCT_PACKAGES += qcom_decrypt_fbe
PRODUCT_PACKAGES += qcom_decrypt

# Debug
PRODUCT_PACKAGES += \
    crash_dump \
    libprocinfo.recovery

PRODUCT_COPY_FILES += \
    $(OUT_DIR)/target/product/$(PRODUCT_RELEASE_NAME)/system/apex/com.android.runtime/bin/crash_dump32:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/crash_dump32 \
    $(OUT_DIR)/target/product/$(PRODUCT_RELEASE_NAME)/system/apex/com.android.runtime/bin/crash_dump64:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/crash_dump64

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-impl \
    android.hardware.gatekeeper@1.0-service

PRODUCT_COPY_FILES += \
    $(OUT_DIR)/target/product/$(PRODUCT_RELEASE_NAME)/vendor/bin/hw/android.hardware.gatekeeper@1.0-service:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/android.hardware.gatekeeper@1.0-service \
    $(OUT_DIR)/target/product/$(PRODUCT_RELEASE_NAME)/vendor/lib64/hw/android.hardware.gatekeeper@1.0-impl.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/hw/android.hardware.gatekeeper@1.0-impl.so

# Proprietary - Gatekeeper
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/gatekeeper/system/,$(TARGET_COPY_OUT_RECOVERY)/root/system/)

# Proprietary - Keystore
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/keystore/system/,$(TARGET_COPY_OUT_RECOVERY)/root/system/)

# Proprietary - QSEECOMd
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/qseecomd/system/,$(TARGET_COPY_OUT_RECOVERY)/root/system/)

# Proprietary - QTI Gatekeeper 1.0
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/qti-gatekeeper-1-0/system/,$(TARGET_COPY_OUT_RECOVERY)/root/vendor/)

# Proprietary - QTI Keymaster
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/qti-keymaster-common/system/,$(TARGET_COPY_OUT_RECOVERY)/root/system/)
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/proprietary/qti-keymaster-4-0/system/,$(TARGET_COPY_OUT_RECOVERY)/root/system/)

# Vintf - Keymaster
PRODUCT_COPY_FILES += $(LOCAL_PATH)/vintf/keymaster-4-0.xml:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/vintf/manifest/keymaster-4-0.xml

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# OEM otacert
PRODUCT_EXTRA_RECOVERY_KEYS += \
    vendor/recovery/security/miui

# Inherit extra if exists
$(call inherit-product-if-exists, vendor/extra/product.mk)
