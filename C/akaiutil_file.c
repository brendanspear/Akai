//
//  This file is part of AkaiSConvert.
//  Based on original work: akaiutil by Klaus Michael Indlekofer
//  Copyright (C) 2008-2025 Klaus Michael Indlekofer <m.indlekofer@gmx.de>
//  Released under GNU GPL v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
//

#include "akaiutil_file.h"
#include <string.h>
#include <sys/stat.h>
#include <libgen.h>
#include <stdlib.h>
#include <stdio.h>

const char *get_file_extension(const char *filename) {
    const char *dot = strrchr(filename, '.');
    return (dot && dot != filename) ? dot + 1 : "";
}

int file_exists(const char *filename) {
    struct stat buffer;
    return (stat(filename, &buffer) == 0);
}

int ensure_directory_exists(const char *path) {
    struct stat st = {0};
    if (stat(path, &st) == -1) {
#ifdef _WIN32
        return mkdir(path);
#else
        return mkdir(path, 0755);
#endif
    }
    return 0;
}

void get_filename_base(const char *path, char *out, size_t max_len) {
    char *temp = strdup(path);
    if (!temp) {
        out[0] = '\0';
        return;
    }

    char *base = basename(temp);
    char *dot = strrchr(base, '.');
    if (dot) {
        *dot = '\0';
    }

    strncpy(out, base, max_len - 1);
    out[max_len - 1] = '\0';

    free(temp);
}

void join_path(char *out, size_t max_len, const char *dir, const char *filename, const char *ext) {
    snprintf(out, max_len, "%s/%s.%s", dir, filename, ext);
}
