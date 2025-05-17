//
//  akaiutil_main.c
//  AkaiSConvert
//

#include "commoninclude.h"
#include "akaiutil_take.h"

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>

int main(int argc, char *argv[]) {
    PRINTF_OUT("Akai Utility Starting...\n");
    FLUSH_ALL();

    if (argc < 2) {
        PRINTF_ERR("Usage: %s <args>\n", argv[0]);
        exit(1);
    }

    struct flock fl;
    memset(&fl, 0, sizeof(fl));
    fl.l_type = F_WRLCK;
    fl.l_whence = SEEK_SET;

    // Simulated sample usage
    sample_t example;
    strncpy(example.name, "Test", sizeof(example.name));

    return 0;
}
