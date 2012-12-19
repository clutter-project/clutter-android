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

#include <math.h>

#include <glib.h>
#include <cogl/cogl.h>
#include <clutter/clutter.h>
#include <mx/mx.h>

#ifndef _PC_VERSION
# include <android/asset_manager.h>
# include <clutter/android/clutter-android.h>

extern unsigned char *stbi_load_from_memory (unsigned char const *buffer,
                                             int                  len,
                                             int                 *x,
                                             int                 *y,
                                             int                 *comp,
                                             int                  req_comp);

ClutterActor *
clutter_texture_new_from_android_asset (ClutterAndroidApplication *application,
                                        const char                *path)
{
  const unsigned char *buffer, *pixels;
  int width, height, stb_pixel_format;
  GError *error = NULL;
  AAssetManager *asset_manager;
  AAsset *asset;
  ClutterActor *actor;

  asset_manager =
    clutter_android_application_get_asset_manager (application);
  asset = AAssetManager_open (asset_manager, path, AASSET_MODE_BUFFER);

  if (asset == NULL)
    g_critical ("Could not open %s", path);

  buffer = AAsset_getBuffer (asset);
  pixels = stbi_load_from_memory (buffer,
                                  AAsset_getLength (asset),
                                  &width, &height,
                                  &stb_pixel_format,
                                  4 /* STBI_rgb_alpha */);

  if (pixels == NULL)
    g_critical ("Could not decompress image");

  actor = clutter_texture_new ();
  clutter_texture_set_from_rgb_data (CLUTTER_TEXTURE (actor),
                                     pixels,
                                     TRUE,
                                     width, height,
                                     width * 4,
                                     4,
                                     CLUTTER_TEXTURE_NONE,
                                     &error);
  AAsset_close (asset);

  if (error)
    g_critical ("Could not create texure: %s", error->message);


  return actor;
}

CoglTexture*
cogl_texture_new_from_android_asset (ClutterAndroidApplication *application,
                                     const char                *path)
{
  const unsigned char *buffer, *pixels;
  int width, height, stb_pixel_format;
  AAssetManager *asset_manager;
  AAsset *asset;
  CoglTexture *texture;

  asset_manager =
    clutter_android_application_get_asset_manager (application);
  asset = AAssetManager_open (asset_manager, path, AASSET_MODE_BUFFER);

  if (asset == NULL)
    g_critical ("Could not open %s", path);

  buffer = AAsset_getBuffer (asset);
  pixels = stbi_load_from_memory (buffer,
                                  AAsset_getLength (asset),
                                  &width, &height,
                                  &stb_pixel_format,
                                  4 /* STBI_rgb_alpha */);

  if (pixels == NULL)
    g_critical ("Could not decompress image");

  texture = cogl_texture_new_from_data (width, height,
                                      COGL_TEXTURE_NONE | COGL_TEXTURE_NO_SLICING,
                                      COGL_PIXEL_FORMAT_RGBA_8888,
                                      COGL_PIXEL_FORMAT_ANY,
                                      width * 4,
                                      pixels);
  AAsset_close (asset);

  return texture;
}

void
mx_load_embedded_theme (ClutterAndroidApplication *application)
{
  AAssetManager *asset_manager =
    clutter_android_application_get_asset_manager (application);
  AAsset* asset = AAssetManager_open (asset_manager, "default.css",
                                      AASSET_MODE_BUFFER);
  off_t length;
  const unsigned char *buffer;
  GError *error = NULL;

  if (asset == NULL)
    g_critical ("Could not open mx-theme.css");

  length = AAsset_getLength (asset);
  buffer = AAsset_getBuffer (asset);

  mx_style_load_from_data (mx_style_get_default (),
                           "default.css",
                           (gchar *) buffer,
                           &error);


  if (error)
    g_critical ("Could not create texure: %s", error->message);

  AAsset_close (asset);
}

#else

void
mx_load_embedded_theme (ClutterAndroidApplication *application)
{
  GError *error = NULL;

  mx_style_load_from_file (mx_style_get_default (),
                           "./ohand/assets/default.css",
                           &error);

  if (error)
    g_critical ("Loading Mx theme failed : %s", error->message);
}

ClutterActor *
clutter_texture_new_from_android_asset (ClutterAndroidApplication *application,
                                        const char                *path)
{
  gchar *epath = g_strdup_printf ("./ohand/assets/%s", path);
  ClutterActor *texture = clutter_texture_new_from_file (epath, NULL);

  return texture;
}



CoglTexture*
cogl_texture_new_from_android_asset (ClutterAndroidApplication *application,
                                     const char                *path)
{
  gchar *epath = g_strdup_printf ("./ohand/assets/%s", path);
  CoglTexture *texture = cogl_texture_new_from_file (epath, COGL_TEXTURE_NONE,
                                                     COGL_PIXEL_FORMAT_ANY,
                                                     NULL);

  return texture;
}

#endif /* _PC_VERSION */
