//
//  LYModuleManager.m
//  LYModuleManager
//
//  Created by wangwei on 2018/6/21.
//

#import "LYModuleManager.h"
#import "LYModuleProtocol.h"
@interface LYModuleManager()

@property(nonatomic, strong) NSMutableDictionary *moduleConfs;

@end


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
    self.moduleConfs = [[NSMutableDictionary alloc] init];
    [self syncLoadModules];
}

-(void)syncLoadModules{
    NSString *configPath = [[NSBundle mainBundle] resourcePath];
    NSFileManager * fileManager = [NSFileManager defaultManager];

    NSArray *fileNames = [fileManager contentsOfDirectoryAtPath:configPath error:nil];
    if([fileNames count] != 0){
        [fileNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *fileName = (NSString *)obj;
            if([fileName hasSuffix:@"_lymm.plist"]){
                NSString *fullPath = [NSString stringWithFormat:@"%@/%@", configPath, fileName];
                NSMutableDictionary *moduleConf = [[NSMutableDictionary alloc] initWithContentsOfFile:fullPath];
                if(moduleConf != nil){
                    [self.moduleConfs addEntriesFromDictionary:moduleConf];
                }
            }
        }];
    }
    
#ifdef DEBUG
    for(NSString *protoc in self.moduleConfs.allKeys){
        NSLog(@"interface %@, imp: %@", protoc, self.moduleConfs[protoc]);
    }
#endif
}


- (id)getModule:(Protocol *)moduleProtocol{
    NSString *protocName = NSStringFromProtocol(moduleProtocol);
   
    NSString *impClsName = nil;
    for (NSString *pName in self.moduleConfs.allKeys) {
        if([pName isEqualToString:protocName]){
            impClsName = self.moduleConfs[pName];
            break;
        }
    }
    
    id imp = nil;
    if (impClsName) {
        Class impCls = NSClassFromString(impClsName);
        if([impCls conformsToProtocol:@protocol(LYModuleProtocol)]){
            if([impCls respondsToSelector:@selector(getSingleton)]){
                imp = [impCls getSingleton];
            }else{
                imp = [[impCls alloc] init];
            }
        }
    }
    return imp;
}

@end
