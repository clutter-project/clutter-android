QUIET_ = @
QUIET = $(QUIET_$(V))

help:
	@echo "Usage: make [ ohand-app | ohand-pc | clean ]"

FAKE_C = $(PWD)/fake-android-application/fake-android-application.c
FAKE_H = $(PWD)/fake-android-application/fake-android-application.h
FAKE_OBJS = $(patsubst %.c,%.o,$(FAKE_C))
FAKE_CFLAGS = `pkg-config mx-2.0 libsoup-2.4 gdk-pixbuf-2.0 --cflags` -D_PC_VERSION=1 -include $(FAKE_H) -I ohand/jni
FAKE_LIBS = `pkg-config mx-2.0 libsoup-2.4 gdk-pixbuf-2.0 --libs` -lm

$(FAKE_OBJS): $(FAKE_C)
	@echo "  CC     `basename $@`"
	$(QUIET)$(CC) -Wall -g -c -o $@ $< $(FAKE_CFLAGS)

# OHand

ohand-app:
	cd $(PWD)/ohand && ndk-build
	cd $(PWD)/ohand && ant debug
	adb install -r $(PWD)/ohand/bin/NativeActivity-debug.apk

ohand-app-full:
	android update project -p $(PWD)/ohand --target 1
	cd $(PWD)/ohand && ndk-build
	cd $(PWD)/ohand && ant debug
	adb install -r $(PWD)/ohand/bin/NativeActivity-debug.apk

OHAND_FILES = $(shell cat $(PWD)/ohand/jni/Android.mk | grep LOCAL_SRC_FILES | cut -d = -f 2)
OHAND_SOURCES = $(addprefix $(PWD)/ohand/jni/, $(OHAND_FILES))

ohand-pc: $(OHAND_SOURCES) $(FAKE_C) $(FAKE_H)
	@echo $(OHAND_SOURCES)
	$(CC) -Wall -g -D_PC_VERSION=1 -include $(FAKE_H) $(FAKE_FLAGS) $(OHAND_SOURCES) $(FAKE_C) -I$(PWD)/ohand/jni -o ohand-pc $(FAKE_LIBS)
