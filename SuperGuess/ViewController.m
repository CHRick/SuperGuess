//
//  ViewController.m
//  SuperGuess
//
//  Created by 汇文 on 15/10/12.
//  Copyright (c) 2015年 Rick. All rights reserved.
//

#import "ViewController.h"
#import "RXappInfo.h"

#define kButtonW 35
#define kButtonH 35
#define kMargin  10
#define kColoumn 7


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@property (nonatomic,strong) UIButton *cover;
@property (nonatomic,assign) NSInteger index;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *imageName;
@property (nonatomic,copy) NSArray *questions;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (weak, nonatomic) IBOutlet UIView *answerView;
@property (weak, nonatomic) IBOutlet UIView *optionView;

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
    return [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
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
    self.index = -1;
    [self nextImage];
    
}

- (IBAction)nextImage {
    self.index ++;
    
    RXappInfo *question = [RXappInfo appInfoWithDictionary:self.questions[self.index]];

    [self setBascInfo:question];
    [self creatAnswerButton:question];
    [self creatOptionButton:question];
    
    }

- (void)setBascInfo:(RXappInfo *)question
{
    [self.numLabel setText:[NSString stringWithFormat:@"%d/%d",self.index+1,self.questions.count]];
    self.imageName.text = question.title;
    [self.iconButton setImage:[UIImage imageNamed:question.icon] forState:UIControlStateNormal];
    self.nextButton.enabled = (self.index < self.questions.count - 1);
}

- (void)creatAnswerButton:(RXappInfo *)question
{
    for (UIView *view in self.answerView.subviews) {
        [view removeFromSuperview];
    }
    CGFloat answerX = (self.answerView.bounds.size.width - kButtonW * question.answer.length - kMargin * (question.answer.length -1)) * 0.5;
    for (int i = 0; i < question.answer.length; i++) {
        CGFloat x = answerX + i * (kButtonW + kMargin);
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(x, 0, kButtonW, kButtonH)];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_answer"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_left_highlighted"] forState:UIControlStateHighlighted];
        [self.answerView addSubview:btn];
    }

}

- (void)creatOptionButton:(RXappInfo *)question
{
    if (self.optionView.subviews.count != question.options.count) {
        for (UIView *view in self.optionView.subviews) {
            [view removeFromSuperview];
        }
        CGFloat optionX = (self.optionView.bounds.size.width - kButtonW * kColoumn - kMargin * (kColoumn-1)) * 0.5;
        for (int i = 0; i < question.options.count; i++) {
            NSInteger row = i / kColoumn;
            NSInteger col = i % kColoumn;
            CGFloat x = optionX + col * (kButtonW + kMargin);
            CGFloat y = row * (kButtonH + kMargin);
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, kButtonW, kButtonH)];
            [btn setBackgroundImage:[UIImage imageNamed:@"btn_option"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"btn_option_highlighted"] forState:UIControlStateHighlighted];
            [btn setTitle:question.options[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.optionView addSubview:btn];
        }
    }
    
    int i = 0;
    for (UIButton *btn in self.optionView.subviews) {
        [btn setTitle:question.options[i] forState:UIControlStateNormal];
        i++;
    }

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
