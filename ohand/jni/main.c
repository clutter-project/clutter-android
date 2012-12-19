/*
 * Copyright © 2012, Intel Corporation.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms and conditions of the GNU Lesser General
 * Public License, version 2.1, as published by the Free Software
 * Foundation.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library. If not, see <http://www.gnu.org/licenses/>.
 */

#include <glib.h>
#include <cogl/cogl.h>
#include <clutter/clutter.h>
#ifndef _PC_VERSION
# include <clutter/android/clutter-android.h>
#endif
#include <mx/mx.h>

#include "clutter-utils.h"

typedef struct
{
  ClutterAndroidApplication *application;

  ClutterAction *drag_action;
  ClutterAction *rotate_action;
  ClutterAction *zoom_action;
} TestData;

static gboolean
toggle_fullscreen (ClutterActor *button,
                   ClutterStage *stage)
{
  clutter_stage_set_fullscreen (stage, !clutter_stage_get_fullscreen (stage));

  return TRUE;
}

static gboolean
toggle_keyboard (ClutterActor *button,
                 ClutterAndroidApplication *application)
{
  static gboolean visible = FALSE;

  visible = !visible;
#ifndef _PC_VERSION
  clutter_android_application_show_keyboard (application, visible, FALSE);
#endif

  return TRUE;
}

static gboolean
_rotate_gesture_begin (ClutterAction *action,
                       ClutterActor *actor,
                       TestData *data)
{
  clutter_actor_remove_action (actor, data->drag_action);

  return TRUE;
}

static gboolean
_rotate_gesture_end (ClutterAction *action,
                     ClutterActor *actor,
                     TestData *data)
{
  data->drag_action = clutter_drag_action_new ();
  clutter_actor_add_action (actor, data->drag_action);

  return TRUE;
}

static gboolean
test_init (ClutterAndroidApplication *application,
           TestData*                  data)
{
  ClutterInitError init_error;
  ClutterActor *square, *hand, *text, *clone;
  ClutterActor *stage;
  ClutterConstraint *constraint;
  ClutterVertex vertex;
  ClutterActor *box;

  /* Initialize Clutter */
  init_error = clutter_init (NULL, NULL);
  if (init_error <= 0)
    {
      g_critical ("Could not initialize clutter");
      return FALSE;
    }

  /* Set a background color on the stage */
  stage = clutter_stage_get_default ();
  clutter_actor_set_background_color (stage,
                                      CLUTTER_COLOR_LightSkyBlue);

#ifndef _PC_VERSION
  clutter_stage_set_fullscreen (CLUTTER_STAGE (stage), TRUE);
#endif

  box = mx_box_layout_new_with_orientation (MX_ORIENTATION_VERTICAL);
  mx_box_layout_set_spacing (MX_BOX_LAYOUT (box), 50);

  /* Place it at the center of the stage */
  constraint = clutter_align_constraint_new (stage,
                                             CLUTTER_ALIGN_X_AXIS,
                                             0.5f);
  clutter_actor_add_constraint (box, constraint);

  constraint = clutter_align_constraint_new (stage,
                                             CLUTTER_ALIGN_Y_AXIS,
                                             0.5f);
  clutter_actor_add_constraint (box, constraint);

  clutter_actor_add_child (stage, box);

  square = mx_button_new_with_label ("Fullscreen");
  clutter_actor_add_child (box, square);

  g_signal_connect (square, "clicked",
                    G_CALLBACK (toggle_fullscreen), stage);


  square = mx_button_new_with_label ("Keyboard");
  clutter_actor_add_child (box, square);

  g_signal_connect (square, "clicked",
                    G_CALLBACK (toggle_keyboard), application);

  text = mx_entry_new ();
  mx_entry_set_placeholder (MX_ENTRY (text), "Entry");
  clutter_actor_add_child (box, text);

  mx_focus_manager_push_focus (mx_focus_manager_get_for_stage (CLUTTER_STAGE (stage)),
                               MX_FOCUSABLE (text));

  /* Create a new ClutterTexture */
  hand = clutter_texture_new_from_android_asset (application, "redhand.png");

  vertex.x = clutter_actor_get_width (hand)/2.0;
  vertex.y = clutter_actor_get_height (hand)/2.0;
  vertex.z = 0;

  g_object_set (hand, "rotation-center-x", &vertex, "rotation-center-z",
                &vertex, NULL);
  clutter_actor_set_scale (hand, 2.0, 2.0);
  data->drag_action = clutter_drag_action_new ();
  data->rotate_action = clutter_rotate_action_new ();
  data->zoom_action = clutter_zoom_action_new ();

  clutter_actor_add_action (hand, data->drag_action);
  /* clutter_actor_add_action (hand, data->rotate_action); */
  clutter_actor_add_action (hand, data->zoom_action);

  /* g_signal_connect (data->rotate_action, "gesture-begin", */
  /*                   G_CALLBACK (_rotate_gesture_begin), data); */
  /* g_signal_connect (data->rotate_action, "gesture-end", */
  /*                   G_CALLBACK (_rotate_gesture_end), data); */

  /* clutter_actor_animate (hand, CLUTTER_LINEAR, 4000.0 * 99.0, */
  /*                        "rotation-angle-z", 360.0 * 99.0, */
  /*                        "rotation-angle-x", 180.0 * 99.0, NULL); */
  clutter_actor_add_child (stage, hand);
  clutter_actor_set_reactive (hand, TRUE);
  clutter_actor_set_position (hand,
                              clutter_actor_get_width (stage) / 2 -
                              clutter_actor_get_width (hand),
                              clutter_actor_get_height (stage) / 2 -
                              clutter_actor_get_height (hand));

  /**/
  clone = clutter_clone_new (hand);
  clutter_actor_set_reactive (clone, TRUE);
  clutter_actor_set_position (clone, 0, 0);
  clutter_actor_add_action (clone, clutter_zoom_action_new ());
  clutter_actor_add_child (stage, clone);

  clone = clutter_clone_new (hand);
  clutter_actor_set_reactive (clone, TRUE);
  clutter_actor_set_position (clone,
                              clutter_actor_get_width (stage) - clutter_actor_get_width (clone),
                              0);
  clutter_actor_add_action (clone, clutter_zoom_action_new ());
  clutter_actor_add_child (stage, clone);

  clone = clutter_clone_new (hand);
  clutter_actor_set_reactive (clone, TRUE);
  clutter_actor_set_position (clone,
                              0,
                              clutter_actor_get_height (stage) - clutter_actor_get_height (clone));
  clutter_actor_add_action (clone, clutter_zoom_action_new ());
  clutter_actor_add_child (stage, clone);

  clone = clutter_clone_new (hand);
  clutter_actor_set_reactive (clone, TRUE);
  clutter_actor_set_position (clone,
                              clutter_actor_get_width (stage) - clutter_actor_get_width (clone),
                              clutter_actor_get_height (stage) - clutter_actor_get_height (clone));
  clutter_actor_add_action (clone, clutter_zoom_action_new ());
  clutter_actor_add_child (stage, clone);

  /**/
  clutter_actor_show (stage);

  return TRUE;
}

void
clutter_android_main (ClutterAndroidApplication *application)
{
  TestData data;

  memset (&data, 0, sizeof (TestData));
  data.application = application;

  g_signal_connect_after (application, "ready", G_CALLBACK (test_init), &data);

  clutter_android_application_run (application);
}
