/*
* akaiutil.h
* Header for Akai file utilities
*/

#ifndef AKAIUTIL_H
#define AKAIUTIL_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>

/* Opaque struct definitions for Swift interop */
typedef struct vol_s vol_s;
typedef struct file_s file_s;
typedef struct akai_sample_header akai_sample_header;

/* Exported function declarations */
int akai_sample2wav(file_s *fp, int wavfd, uint32_t *sizep, char **wavnamep, int what);
int akai_wav2sample(int wavfd, const char *wavname, vol_s *volp, akai_sample_header *hdrp, int samplerModel, uint32_t *bcountp);

/* Additional exports (examples, adjust as needed) */
int akai_file_info(file_s *fp, int verbose);
int akai_fixramname(file_s *fp);
int akai_sample900_getsamplesize(file_s *fp);

#ifdef __cplusplus
}
#endif

#endif /* AKAIUTIL_H */
