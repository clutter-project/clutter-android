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

#ifndef __CLUTTER_UTILS_H__
#define __CLUTTER_UTILS_H__

#include <glib.h>
#include <clutter/clutter.h>
#ifndef _PC_VERSION
# include <clutter/android/clutter-android.h>
#endif

ClutterActor * clutter_texture_new_from_android_asset (ClutterAndroidApplication *application,
                                                       const char                *path);
CoglTexture * cogl_texture_new_from_android_asset (ClutterAndroidApplication *application,
                                                   const char                *path);

void mx_load_embedded_theme (ClutterAndroidApplication *application);

#endif /* __CLUTTER_UTILS_H__ */
