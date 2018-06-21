//
//  LYModuleManager.m
//  LYModuleManager
//
//  Created by wangwei on 2018/6/21.
//

#import "LYModuleManager.h"

@implementation LYModuleManager

+ (instancetype)shareInstance{
    static dispatch_once_t p;
    static id LYModuleManager = nil;
    
    dispatch_once(&p, ^{
        LYModuleManager = [[self alloc] init];
    });
    
    return LYModuleManager;
}

- (void)start{
    [self syncLoadModules];
}

-(void)syncLoadModules{
    
}

@end
