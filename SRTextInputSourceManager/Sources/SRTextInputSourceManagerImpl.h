//
//  SRInputSourceManager.h
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2015. 1. 12..
//  Copyright (c) 2015 Seorenn. All rights reserved.
//

#import "TargetConditionals.h"

#if !TARGET_OS_IPHONE

#import <Foundation/Foundation.h>
#import "SRTextInputSourceImpl.h"

@interface SRTextInputSourceManagerImpl : NSObject

@property (nonatomic, readonly) NSArray *inputSources;
@property (nonatomic, readonly) SRTextInputSourceImpl *currentInputSource;
@property (nonatomic, readonly) NSInteger currentInputSourceIndex;

+ (SRTextInputSourceManagerImpl *)sharedManager;

- (void)refresh;
- (SRTextInputSourceImpl *)inputSourceWithInputSourceID:(NSString *)inputSourceID;

@end

#endif