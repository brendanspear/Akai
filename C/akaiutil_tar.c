//
//  This file is part of AkaiSConvert.
//  Based on original work: akaiutil by Klaus Michael Indlekofer
//  Copyright (C) 2008-2025 Klaus Michael Indlekofer <m.indlekofer@gmx.de>
//  Released under GNU GPL v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
//

#include "akaiutil_tar.h"
#include <stdlib.h>
#include <string.h>
#include "akai_disk.h"

int akai_build_disk_image(const disk_t *disk, uint8_t *buffer, size_t max_length) {
    if (!disk || !buffer || max_length == 0) {
        return -1;  // Invalid parameters
    }

    size_t offset = 0;

    // Write disk label (ensure it's 32 bytes)
    if (offset + 32 > max_length) return -2;
    memset(buffer + offset, 0, 32);
    strncpy((char *)(buffer + offset), disk->label, 31);
    offset += 32;

    // Write part count (as 32-bit unsigned int)
    if (offset + sizeof(uint32_t) > max_length) return -3;
    *(uint32_t *)(buffer + offset) = (uint32_t)disk->part_count;
    offset += sizeof(uint32_t);

    // Write each part
    for (size_t i = 0; i < disk->part_count; ++i) {
        if (offset + 32 + sizeof(uint32_t) * 2 > max_length) return -4;

        // Write name (32 bytes)
        memset(buffer + offset, 0, 32);
        strncpy((char *)(buffer + offset), disk->parts[i].name, 31);
        offset += 32;

        // Write start_sector
        *(uint32_t *)(buffer + offset) = disk->parts[i].start_sector;
        offset += sizeof(uint32_t);

        // Write sector_count
        *(uint32_t *)(buffer + offset) = disk->parts[i].sector_count;
        offset += sizeof(uint32_t);
    }

    // Pad rest with 0 if needed
    if (offset < max_length) {
        memset(buffer + offset, 0, max_length - offset);
    }

    return (int)offset;  // Total bytes written
}

