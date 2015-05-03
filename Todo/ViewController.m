//
//  ViewController.m
//  Todo
//
//  Created by appdojo on 2015/03/16.
//  Copyright (c) 2015年 appdojo. All rights reserved.
//

#import "ViewController.h"
#import "todoTableViewCell.h"
#import "AddTodoViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, AddTodoViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *todo;

@end

// 永続化用のキー
static NSString *const kSavedTodoUserDefaultsKey = @"TODO";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    // セルの登録
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    UINib *nib = [UINib nibWithNibName:@"todoTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];

    self.title =@"title";
    self.todo = [NSMutableArray array];
    
    // ファイルの書き込み先
    NSLog(@"%@/Preferences", NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject);
    
    NSArray *savedTodo = [[NSUserDefaults standardUserDefaults] objectForKey:kSavedTodoUserDefaultsKey];
    NSLog(@"%@", savedTodo);
    [self.todo addObjectsFromArray:savedTodo];
    NSLog(@"%@", self.todo);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"numberOfSection");
    return 1;
//   return self.todo.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"numberOfRowsInSection %@/%ld", @(section), self.todo.count);
    return self.todo.count;
//    return 1;
}

- (UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cellForRowAtIndexPath : %@ %ld", indexPath, indexPath.row);
//    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
//    cell.textLabel.text = @"hello, world";
//    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    todoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell2"];
    cell.todoLabel.text = self.todo[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *todo = self.todo[indexPath.section];
    CGSize maxSize = CGSizeMake(CGRectGetWidth(tableView.bounds) - 8*2, CGFLOAT_MAX);
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:17.0]};
    CGRect rect =
    [todo boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
//    NSLog(@"%@ -> %@", todo, NSStringFromCGRect(rect));
    CGFloat height = ceil(CGRectGetHeight(rect));
    // セルのマージンの上下８ピクセル
    // UITableViewCellとContentViewの間の１ピクセル
    return height + 8 + 8 + 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}
/*
- (NSString *)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%ld 番目のセクション", section];
}
 
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
    view.backgroundColor = [UIColor brownColor];
    return view;
}
 */

- (IBAction)pushAddButton:(UIBarButtonItem *)sender {
    NSLog(@"addButton");
    AddTodoViewController *addTodoViewController =
    [self.storyboard instantiateViewControllerWithIdentifier:@"AddTodoViewController"];
    addTodoViewController.delegate = self;
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:addTodoViewController];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)addTodoViewControllerDoneButtonTapped:(NSString *)todo {
    NSLog(@"here!! %@", todo);
    [self dismissViewControllerAnimated:YES completion:nil];
    if (todo) {
        [self.todo addObject:todo];
        [[NSUserDefaults standardUserDefaults] setObject:self.todo forKey:kSavedTodoUserDefaultsKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.tableView reloadData];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"index path %@", indexPath);
    // 削除された場合
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // データ操作
        [self.todo removeObjectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults] setObject:self.todo forKey:kSavedTodoUserDefaultsKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        // テーブルの更新
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView endUpdates];
        // アニメーションなし
        // [tableView reloadData];
    }
}

@end
