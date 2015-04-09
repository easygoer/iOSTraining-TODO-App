//
//  AddTodoViewController.h
//  Todo
//
//  Created by Jun on 2015/04/09.
//  Copyright (c) 2015年 appdojo. All rights reserved.
//

#import <UIKit/UIKit.h>

// delegateは前にかく
// もしくは宣言だけ先に書いて定義は後に
@protocol AddTodoViewControllerDelegate <NSObject>

- (void)addTodoViewControllerDoneButtonTapped:(NSString *)todo;

@end

@interface AddTodoViewController : UIViewController
@property (nonatomic, weak) id<AddTodoViewControllerDelegate> delegate;
@end

