#ifndef COMMONINCLUDE_H
#define COMMONINCLUDE_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

// Define these macros if they are not already defined
#define PRINTF_OUT(...) fprintf(stdout, __VA_ARGS__)
#define PRINTF_ERR(...) fprintf(stderr, __VA_ARGS__)
#define FLUSH_ALL()     fflush(NULL)

#endif // COMMONINCLUDE_H
