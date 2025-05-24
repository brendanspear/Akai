#include "akai_bridge.h"
#include "akai_export.h"
#include "akai_model.h"
#include <string.h>
#include <stdio.h>

bool akai_convert_file(const char *inputPath, const char *outputDir, const char *modelName, bool normalize, bool trim) {
    AkaiModel model = AKAI_MODEL_S1000; // default fallback

    if (strcmp(modelName, "S900") == 0) model = AKAI_MODEL_S900;
    if (strcmp(modelName, "S1000") == 0) model = AKAI_MODEL_S1000;
    if (strcmp(modelName, "S3000") == 0) model = AKAI_MODEL_S3000;

    AkaiExportOptions options = {
        .normalize = normalize,
        .trim_silence = trim,
        .pad_silence = false
    };

    bool success = export_sample_to_akai_format(inputPath, outputDir, &options, model);

    if (!success) {
        printf("❌ export_sample_to_akai_format failed for: %s\n", inputPath);
    }

    return success;
}
