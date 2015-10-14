//
//  ViewController.m
//  SuperGuess
//
//  Created by 汇文 on 15/10/12.
//  Copyright (c) 2015年 Rick. All rights reserved.
//

#import "ViewController.h"
#import "RXappInfo.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@property (nonatomic,strong) UIButton *cover;
@property (nonatomic,assign) NSInteger index;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *imageName;
@property (nonatomic,copy) NSArray *questions;


@end

@implementation ViewController

- (UIButton *)cover
{
    if (_cover == nil) {
        _cover = [[UIButton alloc]initWithFrame:self.view.frame];
        _cover.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        _cover.alpha = 0.0;
        [self.view addSubview:_cover];
        [self.cover addTarget:self action:@selector(bigImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cover;
}

- (NSArray *)questions
{
    if (_questions == nil) {
        _questions = [RXappInfo appInfo];
    }
    return _questions;
}

/**
 *  数组乱序
 *
 *  @param array 要排序的数组
 *
 *  @return 乱序后的数组
 */
- (NSArray *)selectInfo:(NSArray *)array
{
    return [array sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        NSInteger seed = arc4random_uniform(2);
        if (seed) {
            return [obj1 compare:obj2];
        }else{
            return [obj2 compare:obj1];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _index = 0;
    
}
- (IBAction)nextImage:(UIButton *)button {
    _index ++;
    if (_index == 9) {
        button.enabled = NO;
    }
    [_numLabel setText:[NSString stringWithFormat:@"%d/%d",_index+1,self.questions.count]];
    _imageName.text = self.questions[_index][@"title"];
    [_iconButton setImage:[UIImage imageNamed:self.questions[_index][@"icon"]] forState:UIControlStateNormal];
}

- (IBAction)bigImage{
    
    if (self.cover.alpha == 0.0) {
        
        [self.view bringSubviewToFront:self.iconButton];
        
        CGFloat y = (self.view.bounds.size.height - self.view.bounds.size.width) * 0.5;
        CGFloat w = self.view.bounds.size.width;
        CGFloat h = w;
        
        [UIView animateWithDuration:1.0 animations:^{
            self.iconButton.frame = CGRectMake(0, y, w, h);
            self.cover.alpha = 1.0;
        }];
    
    }else{
        [UIView animateWithDuration:1.0 animations:^{
            _iconButton.frame = CGRectMake(89, 86, 150, 150);
            self.cover.alpha = 0.0;
        }];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
