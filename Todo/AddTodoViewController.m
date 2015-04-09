//
//  AddTodoViewController.m
//  Todo
//
//  Created by Jun on 2015/04/09.
//  Copyright (c) 2015年 appdojo. All rights reserved.
//

#import "AddTodoViewController.h"

@interface AddTodoViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint;
@property (weak, nonatomic) IBOutlet UITextView *textView;

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
    
    // キーボード表示の通知を受け取る
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // UIKeyboardWillShowNotification以外にもいろいろある
    // アプリケーションがforegroundやbackgroundになるときなど

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doneButtonTapped:(id)sender {
    NSLog(@"done tapped");
    NSString *newTodo = self.textView.text;
    [self.delegate addTodoViewControllerDoneButtonTapped:newTodo];
}

- (void)cancelButtonTapped:(id)sender {
    NSLog(@"cancel tapped");
    [self.delegate addTodoViewControllerDoneButtonTapped:nil];
}

- (void)testButtonTapped:(id)sender {
    NSLog(@"test tapped");
    self.textView.text=@"";
}

- (void)keyboardWillShow:(NSNotification*)notification {
    NSLog(@"keyboard will show");
    // キーボードの高さ分だけ制約を変える
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.constraint.constant = keyboardFrame.size.height;
    
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
