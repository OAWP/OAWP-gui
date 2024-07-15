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

#include "dir-handler.h"
#include "history.h"

#ifndef __OAWP_GUI_H__
# define __OAWP_GUI_H__

/* ==DEFINES== */
#ifndef DEFAULT_CONFIG_PATH
# define DEFAULT_CONFIG_PATH "~/.config/oawp/"
#endif

extern char default_config_path[PATH_MAX];
extern OawpHistory_t history;

# endif
