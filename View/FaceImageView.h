//
//  ImageView.h
//  Weibo
//
//  Created by mac527 on 15/10/30.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kFaceNameKVO   @"faceName_KVO"
#define kFacePngKVO   @"facePNG_KVO"

@interface FaceImageView : UIView
{
    NSMutableArray *faceItemArr;
    UIImageView *manifierView;// 放大镜
    
    int lastTouchIndex;
}

@property (nonatomic, assign) NSInteger pageCount;

@property (copy, nonatomic) NSString *faceName_KVO;
@property (copy, nonatomic) NSString *facePNG_KVO;

@end
