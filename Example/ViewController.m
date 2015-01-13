//
//  ViewController.m
//  Example
//
//  Created by Hale Chan on 15/1/13.
//  Copyright (c) 2015年 Tips4app Inc. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+BlankEdge.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"markdown-title"];
    ImageBlankEdge edge = [image blankEdge];
    
    NSLog(@"top: %d, left:%d, bottom:%d, right:%d\n", edge.top, edge.left, edge.bottom, edge.right);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
