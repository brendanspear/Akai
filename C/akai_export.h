//  akai_export.h
//  AkaiSConvert

#ifndef AKAI_EXPORT_H
#define AKAI_EXPORT_H

#include <stdbool.h>
#include "sample.h"
#include "akai_model.h"

typedef struct {
    bool normalize;
    bool trim_silence;
    bool pad_silence;
    int silence_ms;
    bool force_mono;
} AkaiExportOptions;

#ifdef __cplusplus
extern "C" {
#endif

bool export_sample_to_akai_format(const char* input_path,
                                  const char* output_path,
                                  const AkaiExportOptions* options,
                                  AkaiModel model);

#ifdef __cplusplus
}
#endif

#endif /* AKAI_EXPORT_H */
