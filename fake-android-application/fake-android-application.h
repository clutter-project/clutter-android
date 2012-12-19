/*
 * Clutter.
 *
 * An OpenGL based 'interactive canvas' library.
 *
 * Copyright (C) 2011 Intel Corporation.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library. If not, see <http://www.gnu.org/licenses/>.
 *
 * Authors:
 *   Damien Lespiau <damien.lespiau@intel.com>
 */

#ifndef __CLUTTER_ANDROID_APPLICATION_H__
#define __CLUTTER_ANDROID_APPLICATION_H__

#include <glib-object.h>

G_BEGIN_DECLS

#define CLUTTER_TYPE_ANDROID_APPLICATION clutter_android_application_get_type()

#define CLUTTER_ANDROID_APPLICATION(obj) \
  (G_TYPE_CHECK_INSTANCE_CAST ((obj), \
  CLUTTER_TYPE_ANDROID_APPLICATION, ClutterAndroidApplication))

#define CLUTTER_ANDROID_APPLICATION_CLASS(klass) \
  (G_TYPE_CHECK_CLASS_CAST ((klass), \
  CLUTTER_TYPE_ANDROID_APPLICATION, ClutterAndroidApplicationClass))

#define CLUTTER_IS_ANDROID_APPLICATION(obj) \
  (G_TYPE_CHECK_INSTANCE_TYPE ((obj), \
  CLUTTER_TYPE_ANDROID_APPLICATION))

#define CLUTTER_IS_ANDROID_APPLICATION_CLASS(klass) \
  (G_TYPE_CHECK_CLASS_TYPE ((klass), \
  CLUTTER_TYPE_ANDROID_APPLICATION))

#define CLUTTER_ANDROID_APPLICATION_GET_CLASS(obj) \
  (G_TYPE_INSTANCE_GET_CLASS ((obj), \
  CLUTTER_TYPE_ANDROID_APPLICATION, ClutterAndroidApplicationClass))

typedef struct _ClutterAndroidApplication ClutterAndroidApplication;
typedef struct _ClutterAndroidApplicationClass ClutterAndroidApplicationClass;
typedef struct _ClutterAndroidApplicationPrivate ClutterAndroidApplicationPrivate;

struct _ClutterAndroidApplicationClass
{
  GObjectClass parent_class;

  /* signals */
  gboolean (*ready) (ClutterAndroidApplication *self);
};

/* Entry point for android clutter applications */
void clutter_android_main (ClutterAndroidApplication *application);

GType clutter_android_application_get_type (void) G_GNUC_CONST;

ClutterAndroidApplication *clutter_android_application_get_default (void);

void clutter_android_application_show_keyboard (ClutterAndroidApplication *application,
                                                gboolean show_keyboard,
                                                gboolean implicit);

gpointer clutter_android_application_get_native_activity (ClutterAndroidApplication *application);

void clutter_android_application_set_enable_touch ();
void clutter_android_application_run (ClutterAndroidApplication *application);

G_END_DECLS

#endif /* __CLUTTER_ANDROID_APPLICATION_H__ */
