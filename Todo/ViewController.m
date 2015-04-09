//
//  ViewController.m
//  Todo
//
//  Created by appdojo on 2015/03/16.
//  Copyright (c) 2015年 appdojo. All rights reserved.
//

#import "ViewController.h"
#import "todoTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *todo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    // セルの登録
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    UINib *nib = [UINib nibWithNibName:@"todoTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];
    
    self.todo = @[@"牛乳を買ってくる",
                  @"ビールを飲む",
                  @"家賃の振り込み",
                  @"洗剤を買い足す",
                  @"Macのアップデート",
                  @"ルンバの充電",
                  @"結婚式の招待状に返信する",
                  @"犬の散歩",
                  @"雨ニモマケズ 風ニモマケズ 雪ニモ夏ノ暑サニモマケヌ 丈夫ナカラダヲモチ 慾ハナク 決シテ瞋ラズ イツモシヅカニワラッテヰル 一日ニ玄米四合ト 味噌ト少シノ野菜ヲタベ アラユルコトヲ ジブンヲカンジョウニ入レズニ ヨクミキキシワカリ ソシテワスレズ",
                  @"ビールを飲む"
                  ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
   return self.todo.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"numberOfRowsInSection %@", @(section));
//    return self.todo.count;
    return 1;
}
- (IBAction)pushAddButton:(UIBarButtonItem *)sender {
    NSLog(@"addButton");
}

- (UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cellForRowAtIndexPath : %@", indexPath);
//    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
//    cell.textLabel.text = @"hello, world";
//    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    todoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell2"];
    cell.todoLabel.text = self.todo[indexPath.section];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *todo = self.todo[indexPath.section];
    CGSize maxSize = CGSizeMake(CGRectGetWidth(tableView.bounds) - 8*2, CGFLOAT_MAX);
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:17.0]};
    CGRect rect =
    [todo boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    NSLog(@"%@ -> %@", todo, NSStringFromCGRect(rect));
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
@end
