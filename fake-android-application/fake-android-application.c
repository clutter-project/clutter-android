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

#include <clutter/clutter.h>

#include "fake-android-application.h"

struct _ClutterAndroidApplication
{
  GObject parent;
};

G_DEFINE_TYPE (ClutterAndroidApplication,
               clutter_android_application,
               G_TYPE_OBJECT)
enum
{
  READY,

  LAST_SIGNAL,
};

static guint signals[LAST_SIGNAL] = { 0, };

static void
_clutter_marshal_BOOLEAN__VOID (GClosure     *closure,
                                GValue       *return_value G_GNUC_UNUSED,
                                guint         n_param_values,
                                const GValue *param_values,
                                gpointer      invocation_hint G_GNUC_UNUSED,
                                gpointer      marshal_data)
{
  typedef gboolean (*GMarshalFunc_BOOLEAN__VOID) (gpointer     data1,
                                                  gpointer     data2);
  register GMarshalFunc_BOOLEAN__VOID callback;
  register GCClosure *cc = (GCClosure*) closure;
  register gpointer data1, data2;
  gboolean v_return;

  g_return_if_fail (return_value != NULL);
  g_return_if_fail (n_param_values == 1);

  if (G_CCLOSURE_SWAP_DATA (closure))
    {
      data1 = closure->data;
      data2 = g_value_peek_pointer (param_values + 0);
    }
  else
    {
      data1 = g_value_peek_pointer (param_values + 0);
      data2 = closure->data;
    }
  callback = (GMarshalFunc_BOOLEAN__VOID) (marshal_data ? marshal_data : cc->callback);

  v_return = callback (data1,
                       data2);

  g_value_set_boolean (return_value, v_return);
}

static gboolean
clutter_android_application_ready (ClutterAndroidApplication *application)
{
  return TRUE;
}

static void
clutter_android_application_finalize (GObject *object)
{
  G_OBJECT_CLASS (clutter_android_application_parent_class)->finalize (object);
}

static void
clutter_android_application_class_init (ClutterAndroidApplicationClass *klass)
{
  GObjectClass *object_class = G_OBJECT_CLASS (klass);

  object_class->finalize = clutter_android_application_finalize;

  klass->ready = clutter_android_application_ready;

  signals[READY] =
    g_signal_new ("ready",
                  G_TYPE_FROM_CLASS (object_class),
                  G_SIGNAL_RUN_LAST,
                  G_STRUCT_OFFSET (ClutterAndroidApplicationClass, ready),
                  NULL, NULL,
                  _clutter_marshal_BOOLEAN__VOID,
                  G_TYPE_BOOLEAN, 0);
}

static void
clutter_android_application_init (ClutterAndroidApplication *self)
{
}

void
clutter_android_application_run (ClutterAndroidApplication *application)
{
  gboolean initialized;

  g_return_if_fail (CLUTTER_IS_ANDROID_APPLICATION (application));

  g_signal_emit (application, signals[READY], 0, &initialized);

  clutter_main ();
}


int
main (int argc, char *argv[])
{
  ClutterAndroidApplication *application;

  g_type_init ();

  application = (ClutterAndroidApplication *) g_object_new (CLUTTER_TYPE_ANDROID_APPLICATION, NULL);

  clutter_android_main (application);

  return 0;
}


void
clutter_android_application_show_keyboard (ClutterAndroidApplication *application,
                                           gboolean                   show_keyboard,
                                           gboolean                   implicit)
{
}

gpointer
clutter_android_application_get_native_activity (ClutterAndroidApplication *application)
{
  return NULL;
}

void
clutter_android_application_set_enable_touch ()
{
}

ClutterAndroidApplication *
clutter_android_application_get_default (void)
{
  return NULL;
}
