//
//  LYTestModule.h
//  LYModuleManager_Example
//
//  Created by wangwei on 2018/6/22.
//  Copyright © 2018年 mkitmyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LYModuleManager/LYModuleProtocol.h>
#import "LYTestProtocol.h"

@interface LYTestModule : NSObject<LYModuleProtocol, LYTestProtocol>

-(void)test:(NSString *)name;

@end
