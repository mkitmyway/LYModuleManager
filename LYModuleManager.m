//
//  LYModuleManager.m
//  LYModuleManager
//
//  Created by wangwei on 2018/6/21.
//

#import "LYModuleManager.h"
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
    //1.通过协议获取名字
    //2.通过协议名字找到对应实现类
    //3.创建实现类，如果存在直接返回，要考虑单例情况
    //4.返回实现类
    
    return nil;
}

@end
