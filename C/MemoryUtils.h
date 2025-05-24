// File: MemoryUtils.h
// Copyright (c) 2025 Brendan Spear
// Licensed under MIT License

#ifndef MEMORY_UTILS_H
#define MEMORY_UTILS_H

#include <stddef.h>

void zero_memory(void *ptr, size_t size);
void print_memory(const void *data, size_t length);

#endif // MEMORY_UTILS_H
