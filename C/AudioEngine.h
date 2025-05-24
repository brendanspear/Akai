// AudioEngine.h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioEngine : NSObject

- (instancetype)init;
- (BOOL)loadSampleAtPath:(NSString *)path error:(NSError **)error;
- (void)play;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
