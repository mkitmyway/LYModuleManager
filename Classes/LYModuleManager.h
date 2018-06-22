//
//  LYModuleManager.h
//  LYModuleManager
//
//  Created by wangwei on 2018/6/21.
//

#import <Foundation/Foundation.h>

@interface LYModuleManager : NSObject

+ (instancetype)shareInstance;

- (void)start;
- (id)getModule:(Protocol *)moduleProtocol;

@end
