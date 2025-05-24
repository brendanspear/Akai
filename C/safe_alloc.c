//
//  safe_alloc.c
//  AkaiSConvert
//
//  Created by Brendan Spear on 2025-05-22.
//  Copyright © 2025 Brendan Spear. All rights reserved.
//

#include "safe_alloc.h"
#include <stdlib.h>
#include <stdio.h>

void* safe_malloc(size_t size) {
    void* ptr = malloc(size);
    if (!ptr) {
        fprintf(stderr, "safe_malloc: Failed to allocate %zu bytes\n", size);
        exit(EXIT_FAILURE);
    }
    return ptr;
}

void* safe_calloc(size_t count, size_t size) {
    void* ptr = calloc(count, size);
    if (!ptr) {
        fprintf(stderr, "safe_calloc: Failed to allocate %zu bytes\n", count * size);
        exit(EXIT_FAILURE);
    }
    return ptr;
}

void* safe_realloc(void* ptr, size_t size) {
    void* new_ptr = realloc(ptr, size);
    if (!new_ptr) {
        fprintf(stderr, "safe_realloc: Failed to reallocate to %zu bytes\n", size);
        exit(EXIT_FAILURE);
    }
    return new_ptr;
}
