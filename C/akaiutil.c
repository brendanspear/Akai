//
//  akaiutil.c
//  AkaiSConvert
//
//  Copyright (C) 2008-2025 by Klaus Michael Indlekofer. All rights reserved.
//  Adapted by Brendan Spear under GNU GPL v3.0
//

#include "commoninclude.h"
#include "akaiutil.h"
#include "akaiutil_file.h"
#include "akaiutil_io.h"
#include "akaiutil_check.h"
#include "akaiutil_tar.h"
#include "akaiutil_trim.h"
#include "akaiutil_take.h"
#include "akaiutil_wav.h"
#include "akaiutil_audioutils.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>

// Define any missing constants for portability
#ifndef DISK_NUM_MAX
#define DISK_NUM_MAX 32
#endif

#ifndef PART_NUM_MAX
#define PART_NUM_MAX 128
#endif

#ifndef AKAI_NAME_LEN
#define AKAI_NAME_LEN 64
#endif

#ifndef DIRNAMEBUF_LEN
#define DIRNAMEBUF_LEN 256
#endif

#ifndef AKAI_FILE_TAGNUM
#define AKAI_FILE_TAGNUM 10
#endif

#ifndef PSEUDODISK_NUM_MAX
#define PSEUDODISK_NUM_MAX 16
#endif

#ifndef AKAI_DISKSIZE_MAX
#define AKAI_DISKSIZE_MAX 1048576
#endif

#ifndef AKAI_HD_BLOCKSIZE
#define AKAI_HD_BLOCKSIZE 512
#endif

#ifndef AKAI_DISKSIZE_GRAN
#define AKAI_DISKSIZE_GRAN 4096
#endif

// Stub replacement for deprecated macro
#define OPEN(path, flags) open(path, flags)
#define PERROR(msg) perror(msg)

int akai_disksize(int blocks) {
    if (blocks <= 0) return 0;
    int size = blocks * AKAI_HD_BLOCKSIZE;
    if (size > AKAI_DISKSIZE_MAX) return AKAI_DISKSIZE_MAX;
    return size;
}

void example_disk_operation() {
    int fd = OPEN("disk.img", O_RDONLY);
    if (fd < 0) {
        PERROR("Failed to open disk");
        return;
    }

    PRINTF_OUT("Disk opened successfully.\n");
    close(fd);
}
