//
//  akaiutil_check.h
//  AkaiSConvert
//
//  This file is part of AkaiSConvert.
//  Based on original work: akaiutil by Klaus Michael Indlekofer
//  Copyright (C) 2008-2025 Klaus Michael Indlekofer <m.indlekofer@gmx.de>
//  Released under GNU GPL v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
//

#ifndef AKAIUTIL_CHECK_H
#define AKAIUTIL_CHECK_H

#include <stdbool.h>
#include "sample.h"
#include "akai_model.h"

#ifdef __cplusplus
extern "C" {
#endif

int akai_check_compatibility_s900(const sample_t* sample);
int akai_check_compatibility_s1000(const sample_t* sample);
int akai_check_compatibility_s3000(const sample_t* sample);

bool check_akai_compatibility(const sample_t* sample, AkaiModel model);

#ifdef __cplusplus
}
#endif

#endif /* AKAIUTIL_CHECK_H */
