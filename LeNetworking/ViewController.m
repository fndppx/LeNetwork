//
//  ViewController.m
//  LeNetworking
//
//  Created by keyan on 16/2/24.
//  Copyright © 2016年 keyan. All rights reserved.
//

#import "ViewController.h"
#import "LeDataCenterExend+test.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [ [LeDataCenterExend sharedDataCenterExtend]
     sendVideoBlockListWithTenant_id:@"1111111532"page_id:@"0"
     user_id:@""
     RequestTarget:self
     successSEL:@selector(sendVideoBlockListWithTenant_idSuccess:)
     failSEL:@selector(sendVideoBlockListWithTenant_idFailed:)
     isReadLocalCache:NO];
}
- (void)sendVideoBlockListWithTenant_idSuccess:(LeResponseItem*)item
{
    
}
- (void)sendVideoBlockListWithTenant_idFailed:(LeResponseItem*)item
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
