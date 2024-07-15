/*
 * Copyright (C) 2023-2024 TheRealOne78 <bajcsielias78@gmail.com>
 *
 * This file is part of the OAWP project
 *
 * OAWP is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * OAWP is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with OAWP. If not, see <http://www.gnu.org/licenses/>.
 */

/* OAWP created headers */
#include "oawp-gui.h"
#include "info.h"
#include "history.h"
#include "ui.h"

/* Where the default config exists. */
char default_config_path[PATH_MAX];

/* Where every data about history is located at */
OawpHistory_t history;

int main(int argc, char **argv) {
  gtk_init(&argc, &argv);
  GApplication *app;
  int status;

  app = G_APPLICATION(gtk_application_new("net.gui.OAWP", G_APPLICATION_FLAGS_NONE));
  g_signal_connect(app, "activate", G_CALLBACK(activate), NULL);
  status = g_application_run(G_APPLICATION(app), argc, argv);
  g_object_unref(app);

}
