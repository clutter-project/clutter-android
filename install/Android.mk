LOCAL_PATH := $(call my-dir)

# gettext
include $(CLEAR_VARS)

LOCAL_MODULE        := gettext
LOCAL_SRC_FILES     := lib/libintl.a
LOCAL_EXPORT_CFLAGS := -I$(LOCAL_PATH)/include

include $(PREBUILT_STATIC_LIBRARY)


# libffi
include $(CLEAR_VARS)

LOCAL_MODULE        := libffi
LOCAL_SRC_FILES     := lib/libffi.a
LOCAL_EXPORT_CFLAGS := -I$(LOCAL_PATH)/include

include $(PREBUILT_STATIC_LIBRARY)

# json-glib
include $(CLEAR_VARS)

LOCAL_MODULE        := json-glib
LOCAL_SRC_FILES     := lib/libjson-glib-1.0.a
LOCAL_EXPORT_CFLAGS := -I$(LOCAL_PATH)/include/json-glib-1.0

include $(PREBUILT_STATIC_LIBRARY)


# atk
include $(CLEAR_VARS)

LOCAL_MODULE        := atk
LOCAL_SRC_FILES     := lib/libatk-1.0.a
LOCAL_EXPORT_CFLAGS := -I$(LOCAL_PATH)/include/atk-1.0

include $(PREBUILT_STATIC_LIBRARY)


# clutter
include $(CLEAR_VARS)

LOCAL_MODULE        := clutter
LOCAL_SRC_FILES     := lib/libclutter-1.0.a
LOCAL_EXPORT_CFLAGS := -I$(LOCAL_PATH)/include/clutter-1.0

include $(PREBUILT_STATIC_LIBRARY)


# mx
include $(CLEAR_VARS)

LOCAL_MODULE        := mx
LOCAL_SRC_FILES     := lib/libmx-2.0.a
LOCAL_EXPORT_CFLAGS := -I$(LOCAL_PATH)/include/mx-2.0

include $(PREBUILT_STATIC_LIBRARY)


# gdk-pixbuf
include $(CLEAR_VARS)

LOCAL_MODULE        := gdk-pixbuf
LOCAL_SRC_FILES     := lib/libgdk_pixbuf-2.0.a
LOCAL_EXPORT_CFLAGS := -I$(LOCAL_PATH)/include/gdk-pixbuf-2.0

include $(PREBUILT_STATIC_LIBRARY)


# libpng
include $(CLEAR_VARS)

LOCAL_MODULE        := png
LOCAL_SRC_FILES     := lib/libpng15.a
LOCAL_EXPORT_CFLAGS := -I$(LOCAL_PATH)/include/libpng15

include $(PREBUILT_STATIC_LIBRARY)


# libjpeg
include $(CLEAR_VARS)

LOCAL_MODULE        := jpeg
LOCAL_SRC_FILES     := lib/libjpeg.a
LOCAL_EXPORT_CFLAGS := -I$(LOCAL_PATH)/include

include $(PREBUILT_STATIC_LIBRARY)


# libxml2
include $(CLEAR_VARS)

LOCAL_MODULE        := libxml2
LOCAL_SRC_FILES     := lib/libxml2.a
LOCAL_EXPORT_CFLAGS := -I$(LOCAL_PATH)/include/libxml2

include $(PREBUILT_STATIC_LIBRARY)


# freetype
include $(CLEAR_VARS)

LOCAL_MODULE        := freetype
LOCAL_SRC_FILES     := lib/libfreetype.a
LOCAL_EXPORT_CFLAGS := -I$(LOCAL_PATH)/include/freetype2

include $(PREBUILT_STATIC_LIBRARY)


# iconv
include $(CLEAR_VARS)

LOCAL_MODULE := iconv
LOCAL_SRC_FILES := lib/libiconv.a

include $(PREBUILT_STATIC_LIBRARY)

# glib
include $(CLEAR_VARS)

LOCAL_MODULE    := glib
LOCAL_SRC_FILES := lib/libglib-2.0.a

LOCAL_EXPORT_CFLAGS := 				\
	-I$(LOCAL_PATH)/include/glib-2.0	\
	-I$(LOCAL_PATH)/lib/glib-2.0/include	\
	$(NULL)

include $(PREBUILT_STATIC_LIBRARY)


# gobject
include $(CLEAR_VARS)

LOCAL_MODULE    := gobject
LOCAL_SRC_FILES := lib/libgobject-2.0.a

LOCAL_EXPORT_CFLAGS := 				\
	-I$(LOCAL_PATH)/include/glib-2.0	\
	$(NULL)

include $(PREBUILT_STATIC_LIBRARY)


# gmodule
include $(CLEAR_VARS)

LOCAL_MODULE    := gmodule
LOCAL_SRC_FILES := lib/libgmodule-2.0.a

LOCAL_EXPORT_CFLAGS := 				\
	-I$(LOCAL_PATH)/include/glib-2.0	\
	$(NULL)

include $(PREBUILT_STATIC_LIBRARY)


# gthread
include $(CLEAR_VARS)

LOCAL_MODULE    := gthread
LOCAL_SRC_FILES := lib/libgthread-2.0.a

LOCAL_EXPORT_CFLAGS := 				\
	-I$(LOCAL_PATH)/include/glib-2.0	\
	$(NULL)

include $(PREBUILT_STATIC_LIBRARY)


# gio
include $(CLEAR_VARS)

LOCAL_MODULE := gio
LOCAL_SRC_FILES := lib/libgio-2.0.a
LOCAL_EXPORT_CFLAGS := -I$(LOCAL_PATH)/include/glib-2.0

include $(PREBUILT_STATIC_LIBRARY)


# glib-android
include $(CLEAR_VARS)

LOCAL_MODULE := glib-android
LOCAL_SRC_FILES := lib/libglib-android-1.0.a
LOCAL_EXPORT_CFLAGS :=					\
	-I$(LOCAL_PATH)/include/glib-android-1.0	\
	$(NULL)

include $(PREBUILT_STATIC_LIBRARY)


# fontconfig
include $(CLEAR_VARS)

LOCAL_MODULE        := fontconfig
LOCAL_SRC_FILES     := lib/libfontconfig.a
LOCAL_EXPORT_CFLAGS := -I$(LOCAL_PATH)/include/fontconfig

include $(PREBUILT_STATIC_LIBRARY)


# pango
include $(CLEAR_VARS)

LOCAL_MODULE        := pango
LOCAL_SRC_FILES     := lib/libpango-1.0.a
LOCAL_EXPORT_CFLAGS := -I$(LOCAL_PATH)/include/pango-1.0

include $(PREBUILT_STATIC_LIBRARY)


# pangocairo
include $(CLEAR_VARS)

LOCAL_MODULE        := pangocairo
LOCAL_SRC_FILES     := lib/libpangocairo-1.0.a
LOCAL_EXPORT_CFLAGS := -I$(LOCAL_PATH)/include/pango-1.0

include $(PREBUILT_STATIC_LIBRARY)


# pangoft2
include $(CLEAR_VARS)

LOCAL_MODULE        := pangoft2
LOCAL_SRC_FILES     := lib/libpangoft2-1.0.a
LOCAL_EXPORT_CFLAGS := -I$(LOCAL_PATH)/include/pango-1.0

include $(PREBUILT_STATIC_LIBRARY)


# pixman
include $(CLEAR_VARS)

LOCAL_MODULE        := pixman
LOCAL_SRC_FILES     := lib/libpixman-1.a
LOCAL_EXPORT_CFLAGS := -I$(LOCAL_PATH)/include/pixman-1

include $(PREBUILT_STATIC_LIBRARY)

# cairo
include $(CLEAR_VARS)

LOCAL_MODULE        := cairo
LOCAL_SRC_FILES     := lib/libcairo.a
LOCAL_EXPORT_CFLAGS := -I$(LOCAL_PATH)/include/cairo

include $(PREBUILT_STATIC_LIBRARY)

# cairo-gobject
include $(CLEAR_VARS)

LOCAL_MODULE        := cairo-gobject
LOCAL_SRC_FILES     := lib/libcairo-gobject.a
LOCAL_EXPORT_CFLAGS := -I$(LOCAL_PATH)/include/cairo

include $(PREBUILT_STATIC_LIBRARY)

# cairo-script-interpreter
include $(CLEAR_VARS)

LOCAL_MODULE        := cairo-script-interpreter
LOCAL_SRC_FILES     := lib/libcairo-script-interpreter.a
LOCAL_EXPORT_CFLAGS := -I$(LOCAL_PATH)/include/cairo

include $(PREBUILT_STATIC_LIBRARY)

# cogl
include $(CLEAR_VARS)

LOCAL_MODULE        := cogl
LOCAL_SRC_FILES     := lib/libcogl.a
LOCAL_EXPORT_CFLAGS := -I$(LOCAL_PATH)/include/cogl

include $(PREBUILT_STATIC_LIBRARY)

# cogl-pango
include $(CLEAR_VARS)

LOCAL_MODULE        := cogl-pango
LOCAL_SRC_FILES     := lib/libcogl-pango.a
LOCAL_EXPORT_CFLAGS := -I$(LOCAL_PATH)/include/cogl

include $(PREBUILT_STATIC_LIBRARY)

# libsoup
include $(CLEAR_VARS)

LOCAL_MODULE        := soup
LOCAL_SRC_FILES     := lib/libsoup-2.4.a
LOCAL_EXPORT_CFLAGS := -I$(LOCAL_PATH)/include/libsoup-2.4

include $(PREBUILT_STATIC_LIBRARY)
