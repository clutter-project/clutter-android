LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := clutter-ohand
LOCAL_SRC_FILES := main.c clutter-utils.c
LOCAL_LDLIBS    := -llog -landroid -lEGL -lGLESv1_CM -lz
LOCAL_STATIC_LIBRARIES := mx gdk-pixbuf clutter json-glib soup atk cogl-pango pangocairo pangoft2 pango fontconfig libxml2 cairo-gobject cairo pixman png jpeg freetype cogl gio gobject gmodule gthread glib-android glib iconv libffi gettext
LOCAL_ARM_MODE := arm
LOCAL_CFLAGS := 				\
	-Wall					\
	-DCOGL_ENABLE_EXPERIMENTAL_API		\
	$(NULL)

include $(BUILD_SHARED_LIBRARY)

$(call import-module,android/native_app_glue)
$(call import-module,install)
