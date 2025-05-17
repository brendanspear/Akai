//
//  This file is part of AkaiSConvert.
//  Based on original work: akaiutil by Klaus Michael Indlekofer
//  Copyright (C) 2008-2025 Klaus Michael Indlekofer <m.indlekofer@gmx.de>
//  Released under GNU GPL v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
//

#ifndef AKAIUTIL_FILE_H
#define AKAIUTIL_FILE_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stddef.h>

// Get file extension from a path
const char *get_file_extension(const char *filename);

// Check if file exists
int file_exists(const char *filename);

// Ensure directory exists (creates if not found)
int ensure_directory_exists(const char *path);

// Extract filename base (without directory and extension)
void get_filename_base(const char *path, char *out, size_t max_len);

// Join directory, filename, and extension into full path
void join_path(char *out, size_t max_len, const char *dir, const char *filename, const char *ext);

#ifdef __cplusplus
}
#endif

#endif // AKAIUTIL_FILE_H
