//
//  safe_alloc.h
//  AkaiSConvert
//
//  Created by Brendan Spear on [date].
//  Copyright © 2025 Brendan Spear. All rights reserved.
//

#ifndef safe_alloc_h
#define safe_alloc_h

#include <stddef.h>

void *safe_malloc(size_t size);
void *safe_calloc(size_t count, size_t size);
void *safe_realloc(void *ptr, size_t size);
void safe_free(void *ptr);

#endif /* safe_alloc_h */
