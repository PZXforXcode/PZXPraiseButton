//
//  ViewController.m
//  PZXPraiseButton
//
//  Created by pzx on 16/11/15.
//  Copyright © 2016年 pzx. All rights reserved.
//

#import "ViewController.h"
#import "PZXPraiseButton.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    PZXPraiseButton *button = [[PZXPraiseButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    button.center = self.view.center;
    [button setImage:[UIImage imageNamed:@"桃心-3"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"桃心-2"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

-(void)buttonPressed:(PZXPraiseButton *)sender{

    sender.selected = !sender.selected;

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
