// File: MemoryUtils.c
// Copyright (c) 2025 Brendan Spear
// Licensed under MIT License

#include "MemoryUtils.h"
#include <stdio.h>
#include <string.h>

// Utility function: Zero out a memory block
void zero_memory(void *ptr, size_t size) {
    if (ptr != NULL && size > 0) {
        memset(ptr, 0, size);
    }
}

// Utility function: Print memory contents (hex)
void print_memory(const void *data, size_t length) {
    const unsigned char *bytes = (const unsigned char *)data;
    for (size_t i = 0; i < length; ++i) {
        printf("%02X ", bytes[i]);
        if ((i + 1) % 16 == 0) {
            printf("\n");
        }
    }
    if (length % 16 != 0) {
        printf("\n");
    }
}
