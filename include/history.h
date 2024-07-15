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

#ifndef __HISTORY_H__
# define __HISTORY_H__

#include <stdint.h>
#include "dir-handler.h"

/* ==DEFINE== */

#ifndef HISTORY_MAX
# define HISTORY_MAX 50
#endif

#ifndef HISTORY_DEFAULT_PATH
# define HISTORY_DEFAULT_PATH "~/.cache/oawp/history.txt"
#endif


/* ==STRUCTS== */

/*
 * OawpHistoryLinkedList_t
 * Contains the linked list of config paths
 */
typedef struct OawpHistoryLinkedList {
  /* Path data */
  char confFilePath[PATH_MAX];
  /* pointer to next node */
  struct OawpHistoryLinkedList *next;
} OawpHistoryLinkedList_t;

/*
 * OawpHistory_t
 * Contains the OawpHistoryLinkedList linked list and indexing variables
 */
typedef struct OawpHistory {
  /* The cache file */
  char cacheFilePath[PATH_MAX];

  /* Number of elements in the linked list */
  uint64_t configsCount;

  /* Head of linked list */
  OawpHistoryLinkedList_t *head;

  /* Last item pointer */
  OawpHistoryLinkedList_t *lastPtr;
} OawpHistory_t;


/* ==FUNCTIONS== */

/*
 * This init function initiates everything necessary into OawpHistory_t like
 * loading the config paths from the cache file into the linked list.
 */
int history_init(
    OawpHistory_t *history,  /* History structure to save on */
    char *cacheFilePath);    /* History file to read from */

/*
 * This function refreshes the linked list from the struct to an updated list
 * of config paths.
 */
int history_refresh(
    OawpHistory_t *history); /* History structure to refresh */

/*
 * This unreference functions makes sure every byte from the passed struct is
 * deallocated. Mostly used when cleaning up before exiting.
 */
int history_unref(
    OawpHistory_t *history); /* History structure to deallocate */


/* Getters and setters */

/*
 * This setter function sets a new path at the begining of a OawpHistory_t
 * type linked list and it's cache file.
 */
int history_set_list(
    OawpHistory_t *history,  /* History structure to set value */
    char *configPath);       /* Path value to set */

/* This getter function gets a path at a specific index of a OawpHistory_t
 * type linked list and it's cache file.
 */
int history_get_list(
    char dest[PATH_MAX],     /* Destination string array */
    OawpHistory_t *history,  /* History structure to get element from */
    uint8_t index);          /* Index to set element */


/* Clear history functions */

/*
 * This setter function clears a specific path value at a specific index of a
 * OawpHistory_t type linked list and it's text element inside cache file.
 */
int history_clear_element(
    OawpHistory_t *history,  /* History structure to clear */
    uint8_t index);          /* Index to clear element */

/* This function clears all the path values inside a OawpHistory_t type
 * linked list and the text inside it's cache file.
 */
int history_clear_all(
    OawpHistory_t *history); /* History structure to clear */


#endif
