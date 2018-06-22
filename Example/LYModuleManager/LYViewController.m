//
//  LYViewController.m
//  LYModuleManager
//
//  Created by mkitmyway on 06/21/2018.
//  Copyright (c) 2018 mkitmyway. All rights reserved.
//

#import "LYViewController.h"
#import <LYModuleManager/LYModuleManager.h>
#import "LYTestProtocol.h"

@interface LYViewController ()

@end

@implementation LYViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	
    id<LYTestProtocol> testModule = [[LYModuleManager shareInstance] getModule:@protocol(LYTestProtocol)];
    [testModule test:@"hello world"];
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
