//
//  FaceView.m
//  Weibo
//
//  Created by mac527 on 15/10/30.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "FaceView.h"

@implementation FaceView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // 表情列表 背景
    UIImage *img = [UIImage imageNamed:@"emoticon_keyboard_background"];
    [img drawInRect:rect];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initFaceViewSubViews];
    }
    return self;
}

- (void)initFaceViewSubViews
{
    // 图片表情
    FaceImageView *faceImgView = [[FaceImageView alloc] initWithFrame:CGRectZero];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(faceImgView.frame))];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.clipsToBounds = NO;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(faceImgView.frame.size.width, scrollView.frame.size.height);
    
    [self addSubview:scrollView];
    [scrollView addSubview:faceImgView];
    
    
    self.faceImgView = faceImgView;
    
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(scrollView.frame), kScreenWidth, 36)];
    pageControl.numberOfPages = faceImgView.pageCount;
    pageControl.currentPage = 0;
    [pageControl addTarget:self action:@selector(pageChangeAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:pageControl];
    
    // 重新赋值自己frame
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(pageControl.frame));
}

- (void)pageChangeAction
{
    // 点击 pageControl 时 scrollView 跟着 滑动
    [scrollView setContentOffset:CGPointMake(pageControl.currentPage*kScreenWidth, scrollView.contentOffset.y) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView_
{
    // scrollView 停止滑动 计算当前 偏移页码
    NSInteger page = scrollView.contentOffset.x / kScreenWidth;
    
    pageControl.currentPage = page;
}


@end
