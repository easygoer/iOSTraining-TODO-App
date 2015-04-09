//
//  AddTodoViewController.m
//  Todo
//
//  Created by Jun on 2015/04/09.
//  Copyright (c) 2015年 appdojo. All rights reserved.
//

#import "AddTodoViewController.h"

@interface AddTodoViewController ()

@end

@implementation AddTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Done
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTapped:)];
    // キャンセル
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonTapped:)];
    // ボタン追加してみる
    UIBarButtonItem *testButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:self action:@selector(testButtonTapped:)];

    self.navigationItem.leftBarButtonItems = [[NSArray alloc]
                                              initWithObjects:cancelButton, testButton, nil];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doneButtonTapped:(id)sender {
    NSLog(@"done tapped");
}

- (void)cancelButtonTapped:(id)sender {
    NSLog(@"cancel tapped");
}

- (void)testButtonTapped:(id)sender {
    NSLog(@"test tapped");
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
