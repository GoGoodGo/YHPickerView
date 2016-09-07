//
//  YHPickerView.m
//  YHPickerView
//
//  Created by YH_O on 16/7/27.
//  Copyright © 2016年 OYH. All rights reserved.
//

#import "YHPickerView.h"

@interface YHPickerView ()<UIScrollViewDelegate> {
 
    CGFloat _scrollViewWidth;
    CGFloat _scrollViewHeight;
    NSInteger _leftScrollViewRow;
    NSInteger _rightScrollViewRow;
    CGFloat _leftRowHeight;
    CGFloat _rightRowHeight;
    CGFloat _lastContentOffset; // 开始拖动的偏移量 x,y
    BOOL _isUp;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation YHPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutCustomSubViews];
    }
    return self;
}

#pragma mark - CustomMethods

- (void)layoutCustomSubViews {
    
    _scrollViewWidth = CGRectGetWidth(self.bounds) / 2;
    _scrollViewHeight = CGRectGetHeight(self.bounds);
    _leftRowHeight = 30;
    _rightRowHeight = 30;
    
    NSArray *scrollViewRowArr = @[@10, @12];
    
    for (NSInteger index = 0; index < 2; ++ index) {
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(_scrollViewWidth * index, 0, _scrollViewWidth, _scrollViewHeight)];
        scrollView.delegate = self;
        scrollView.tag = scrollViewTag + index;
        scrollView.showsVerticalScrollIndicator = NO;
        
        UIImageView *lineImgView = [[UIImageView alloc] init];
        lineImgView.bounds = CGRectMake(0, 0, 40, 2);
        lineImgView.center = scrollView.center;
        lineImgView.backgroundColor = [UIColor greenColor];
        
        [self addSubview:scrollView];
        [self addSubview:lineImgView];
        
        NSInteger row = [scrollViewRowArr[index] integerValue];
        [self contentLayoutScrollViewRow:row tag:scrollViewTag + index];
    }
}

- (void)getCurrentScrollView {
    
    self.scrollView = (UIScrollView *)[self viewWithTag:scrollViewTag];
    CGFloat contentHeight = [self contentHeightScrollViewRow:_leftScrollViewRow rowHeight:_leftRowHeight scrollViewHeight:_scrollViewHeight];
    
    self.scrollView.contentSize = CGSizeMake(_scrollViewWidth, contentHeight);
}

- (void)contentLayoutScrollViewRow:(NSInteger)row tag:(NSInteger)tag{
    
    self.scrollView = (UIScrollView *)[self viewWithTag:tag];
    CGFloat contentHeight = [self contentHeightScrollViewRow:row rowHeight:_leftRowHeight scrollViewHeight:_scrollViewHeight];
    
    self.scrollView.contentSize = CGSizeMake(_scrollViewWidth, contentHeight);
    
    for (NSInteger index = 0; index < row; ++ index) {
        
        UILabel *yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _leftRowHeight * index + (_scrollViewHeight / 2 - _leftRowHeight), _scrollViewWidth, _leftRowHeight)];
        yearLabel.textAlignment = NSTextAlignmentCenter;
        yearLabel.textColor = [UIColor blackColor];
        yearLabel.font = [UIFont systemFontOfSize:16];
        yearLabel.text = [NSString stringWithFormat:@"%ld", index];
        
        [self.scrollView addSubview:yearLabel];
    }
}

// 计算 scrollView contentSize
- (CGFloat)contentHeightScrollViewRow:(NSInteger)row rowHeight:(CGFloat)rowHeight scrollViewHeight:(CGFloat)scrollViewHeight {
    
    CGFloat contentHeight = row * rowHeight + scrollViewHeight - rowHeight;
    
    return contentHeight;
}

- (void)contentOffsetScrollView:(UIScrollView *)scrollView {
    
    NSInteger currentIndex;
    
    if (_isUp) {
        currentIndex = round(scrollView.contentOffset.y / _leftRowHeight + 0.4);
    } else {
        currentIndex = round(scrollView.contentOffset.y / _leftRowHeight - 0.4);
    }
    [scrollView setContentOffset:CGPointMake(0, currentIndex * _leftRowHeight) animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    _lastContentOffset = scrollView.contentOffset.y;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (_lastContentOffset < scrollView.contentOffset.y) {
        
        _isUp = YES;
        [self contentOffsetScrollView:scrollView];
        
    } else {
        _isUp = NO;
        [self contentOffsetScrollView:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (_lastContentOffset < scrollView.contentOffset.y) {
        
        _isUp = YES;
        [self contentOffsetScrollView:scrollView];
        
    } else {
        _isUp = NO;
        [self contentOffsetScrollView:scrollView];
    }
}
























@end
