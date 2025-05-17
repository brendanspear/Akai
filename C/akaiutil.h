//
//  This file is part of AkaiSConvert.
//  Based on original work: akaiutil by Klaus Michael Indlekofer
//  Copyright (C) 2008-2025 Klaus Michael Indlekofer <m.indlekofer@gmx.de>
//  Released under GNU GPL v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
//

#ifndef AKAIUTIL_H
#define AKAIUTIL_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stddef.h>

/*
 * akaiutil: access to AKAI S900/S1000/S3000 filesystems
 * Copyright (C) 2008–2025 by Klaus Michael Indlekofer
 * All rights reserved.
 * Distributed under GPL v3.0.
 *
 * Email: m.indlekofer@gmx.de
 */

// === Function Declarations for Swift Interop ===

// Converts 16-bit PCM to 12-bit packed Akai format
int32_t akai_convert_16bit_to_12bit(const int16_t* in, int32_t inCount, uint8_t* out, int32_t outMax);

// Converts 12-bit packed Akai format to 16-bit PCM

int32_t akai_convert_12bit_to_16bit(const uint8_t* in, int32_t inCount, int16_t* out, int32_t outMax);

#ifdef __cplusplus
}
#endif

#endif // AKAIUTIL_H
