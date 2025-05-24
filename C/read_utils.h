/*
 * Copyright (c) 2025 Brendan Spear
 * All rights reserved.
 *
 * This file is part of AkaiSConvert.
 *
 * This header provides utility function declarations for reading WAV files,
 * typically used to load sample data into the AkaiSConvert environment.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted for non-commercial purposes provided that
 * the copyright notice, this list of conditions, and the following disclaimer
 * are retained in all copies.
 *
 * THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
 */

#ifndef READ_UTILS_H
#define READ_UTILS_H

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Loads a WAV file and returns 0 on success, non-zero on failure.
 * @param filepath Absolute or relative path to the WAV file.
 * @return int status code
 */
int load_wav_file(const char *filepath);

#ifdef __cplusplus
}
#endif

#endif // READ_UTILS_H
