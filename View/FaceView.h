//
//  FaceView.h
//  Weibo
//
//  Created by mac527 on 15/10/30.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceImageView.h"

@interface FaceView : UIView <UIScrollViewDelegate>
{
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    
}

@property (weak, nonatomic) FaceImageView *faceImgView;


@end
