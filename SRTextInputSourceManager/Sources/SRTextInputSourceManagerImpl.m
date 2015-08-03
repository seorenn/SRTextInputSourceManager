//
//  SRInputSourceManager.m
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2015. 1. 12..
//  Copyright (c) 2015 Seorenn. All rights reserved.
//

#import "SRTextInputSourceManagerImpl.h"

#if TARGET_OS_IPHONE
#warning SRInputSourceManager was disabled because target platform is iOS
#else

@implementation SRTextInputSourceManagerImpl

@synthesize inputSources = _inputSources;

+ (SRTextInputSourceManagerImpl *)sharedManager {
    static SRTextInputSourceManagerImpl *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SRTextInputSourceManagerImpl alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        [self refresh];
    }
    return self;
}

- (void)refresh {
    _inputSources = nil;
    
    CFArrayRef iss = TISCreateInputSourceList(NULL, NO);
    if (!iss) return;
    
    NSMutableArray *sources = [[NSMutableArray alloc] init];
    
    NSInteger issCount = CFArrayGetCount(iss);
    for (int i=0; i < issCount; i++) {
        TISInputSourceRef tis = (TISInputSourceRef)CFArrayGetValueAtIndex(iss, i);
        if (!tis) continue;
        
        SRTextInputSourceImpl *inputSource = [[SRTextInputSourceImpl alloc] initWithTISInputSourceRef:tis];
        if (inputSource.isInputable) {
            [sources addObject:inputSource];
        }
    }
    _inputSources = [sources copy];
    
    CFRelease(iss);
}

- (SRTextInputSourceImpl *)inputSourceWithInputSourceID:(NSString *)inputSourceID {
    if (!_inputSources) {
        [self refresh];
    }
    
    for (SRTextInputSourceImpl *inputSource in _inputSources) {
        if ([inputSource.ID isEqualToString:inputSourceID]) {
            return inputSource;
        }
    }
    
    return nil;
}

- (NSInteger)currentInputSourceIndex {
    TISInputSourceRef tis = TISCopyCurrentKeyboardInputSource();
    if (!tis) return -1;
    
    NSString *tisID = (__bridge NSString *)TISGetInputSourceProperty(tis, kTISPropertyInputSourceID);
    NSInteger res = -1;
    
    if (tisID) {
        for (int i=0; i < _inputSources.count; i++) {
            SRTextInputSourceImpl *source = [_inputSources objectAtIndex:i];
            if ([source.ID isEqualToString:tisID]) {
                res = i;
                break;
            }
        }
    }
    
    CFRelease(tis);
    
    return res;
}

- (SRTextInputSourceImpl *)currentInputSource {
    NSInteger index = [self currentInputSourceIndex];
    if (index < 0) return nil;
    
    return [_inputSources objectAtIndex:index];
}

@end

#endif
