#ifndef akai_bridge_h
#define akai_bridge_h

#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

bool akai_convert_file(const char *inputPath, const char *outputDir, const char *model, bool normalize, bool trim);

#ifdef __cplusplus
}
#endif

#endif /* akai_bridge_h */
