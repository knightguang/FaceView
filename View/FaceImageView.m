//
//  ImageView.m
//  Weibo
//
//  Created by mac527 on 15/10/30.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "FaceImageView.h"


//表情显示4行7列
#define kRowCount 4
#define kColumnCount 7


#define kFaceSize   30
#define kRowSpace    12  // 行间距
#define kColumnSpace ((kScreenWidth - kColumnCount*kFaceSize) / (kColumnCount+1))  // 列间距

@implementation FaceImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        lastTouchIndex = -1;
        
        // 1.读取字典
        [self parseFaceArr];
        
        [self configUI];
        // 2.画表情
        
        // 3.计算点击的是哪个表情
    }
    return self;
}

- (void)configUI
{
    
}

#pragma mark - 读取字典
- (void)parseFaceArr
{
    
}

#pragma mark - 画表情
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // 2.画表情
}

#pragma mark - 计算点击的是哪个表情
- (void)touchFace:(CGPoint)point
{
    // 1.确定页码
    int page = point.x / kScreenWidth;
    
    // 2.确定行与列
    float faceItemWidth = kFaceSize + kColumnSpace; //表情所占区域宽度（左列间距/2+表情宽度+右列间距/2）
    float faceItemHeight = kFaceSize + kRowSpace;   //表情所占区域高度（上行间距/2+表情高度+下行间距/2）
    int row = (point.y-kRowSpace/2) / faceItemHeight;
    int column = ((point.x-kScreenWidth*page)-kColumnSpace/2) / faceItemWidth;
    
    // 3.边界值判断（row：0-3；column：0-6）
    row = MAX(MIN(row, 3), 0);
    column = MAX(MIN(column, 6), 0);
//    NSLog(@"%d -- %d", row, column);
    
    // 4.一页表情
    NSArray *faceArr = faceItemArr[page];
    // 4.1 获取点击的表情下标
    int indx = row * kColumnCount + column;
    // 4.2 判断是否越界
    if (indx > faceArr.count - 1) {
        manifierView.hidden = YES;
        lastTouchIndex = -1;
        return;
    }
    
    if (lastTouchIndex != indx) {
        
        // 5.获取选中的表情
        NSDictionary *dic = faceArr[indx];
//================================================================
        
        NSString *faceName = dic[@"chs"];
        
        // 存储  kvo不会监控
        _faceName_KVO = faceName;
        
//================================================================
        
        NSString *facePng = dic[@"png"];
        _facePNG_KVO = facePng;
        
//================================================================
        UIImageView *imgView = (UIImageView *)[manifierView viewWithTag:400];
        imgView.image = [UIImage imageNamed:dic[@"png"]];
        
        // x = 间距 + 半个表情 + 前面有几个表情 + 页码 - 自身宽度
        CGFloat x = kFaceSize/2 + kColumnSpace*(column+1) + kFaceSize*column + kScreenWidth*page - manifierView.bounds.size.width/2;
        CGFloat y = kFaceSize/2 + kRowSpace*(row+1) + kFaceSize*row - manifierView.bounds.size.height;
        manifierView.frame = CGRectMake(x, y, CGRectGetWidth(manifierView.frame), CGRectGetHeight(manifierView.frame));
    }
    
    manifierView.hidden = NO;
    lastTouchIndex = indx;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    manifierView.hidden = YES;
    
    // kvo 监控
    [self changeValueKVO];
    
    // 禁止scrollview滑动
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self.superview;
        scrollView.scrollEnabled = YES;
    }
}

- (void)changeValueKVO
{
    // KVO
//    [self willChangeValueForKey:kFaceNameKVO];
    if (_faceName_KVO) {
        
        self.faceName_KVO = _faceName_KVO;
    }
//    [self didChangeValueForKey:kFaceNameKVO];
    
    
    if (_facePNG_KVO) {
        
        self.facePNG_KVO = _facePNG_KVO;
        
    }
}

@end
