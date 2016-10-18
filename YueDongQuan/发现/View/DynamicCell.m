//
//  DynamicCell.m
//  DouBeDemo
//
//  Created by gaolili on 16/5/4.
//  Copyright © 2016年 mRocker. All rights reserved.
//

#import "DynamicCell.h"
#import "UIImage+Extension.h"
#import "NSString+Extension.h"
#import "XHImageViewer.h"
#import "GlobalUI.h"

#define imgHeight  (CGRectGetWidth([UIScreen mainScreen].bounds) - 80)/3
#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
@interface DynamicCell ()

@property (nonatomic,strong) UIImageView * avatorImg;//头像
@property (nonatomic,strong) UILabel * nameLabel;//昵称
@property (nonatomic,strong) UIImageView * moreImg;//类型
@property (nonatomic,strong) UILabel * timeLabel;//时间显示
@property (nonatomic,strong) UILabel * distanceLabel;//距离显示
@property (nonatomic,strong) UILabel * contentLabel;//文字容器
@property (nonatomic,strong) UIView  * bgImgsView; // 9张图片bgView容器
@property (nonatomic,strong) UIImageView * lookImg;//查看浏览量图标
@property (nonatomic,strong) UILabel * lookLabel;//浏览量显示
@property (nonatomic,strong) UIImageView * commentImg;//评论图标
@property (nonatomic,strong) UILabel * commentLabel;//评论数量
@property (nonatomic,strong) UIImageView * zanImg;//点赞图标
@property (nonatomic,strong) UILabel * zanLabel;//点赞数量

@property (nonatomic,strong) NSArray * imgArray;
@property (nonatomic,strong) NSMutableArray * groupImgArr;
@property (nonatomic,assign) BOOL isZan;



@end

@implementation DynamicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupUI];
     }
    return self;
}

- (void)setupUI{
    _avatorImg = [GlobalUI createImageViewbgColor:[UIColor whiteColor]];
    _avatorImg.image = [[UIImage imageNamed:@"banner_bg"] clipImageWithRadius:15];
    
    _nameLabel = [GlobalUI createLabelFont:16 titleColor:[UIColor blackColor] bgColor:[UIColor whiteColor]];
    
    _moreImg = [GlobalUI createImageViewbgColor:[UIColor whiteColor]];
    _moreImg.image = [UIImage imageNamed:@"more_icon"];
    
    _timeLabel = [GlobalUI createLabelFont:14 titleColor:[UIColor lightGrayColor] bgColor:[UIColor whiteColor]];
    _timeLabel.text = @"顶";
    
    _distanceLabel.textAlignment = NSTextAlignmentCenter;
    _distanceLabel = [GlobalUI createLabelFont:14 titleColor:[UIColor blackColor] bgColor:[UIColor whiteColor]];
    
    _contentLabel = [GlobalUI createLabelFont:14 titleColor:[UIColor blackColor] bgColor:[UIColor whiteColor]];
    _contentLabel.numberOfLines = 0;
    
    _lookImg = [GlobalUI createImageViewbgColor:[UIColor whiteColor]];
    _lookImg.image = [UIImage imageNamed:@"time_icon"];
    
    _lookLabel = [GlobalUI createLabelFont:14 titleColor:[UIColor blackColor] bgColor:[UIColor whiteColor]];
    
    _commentImg = [GlobalUI createImageViewbgColor:[UIColor whiteColor]];
    _commentImg.image = [UIImage imageNamed:@"review_icon"];
    _commentImg.backgroundColor = [UIColor whiteColor];
    
    _commentLabel = [GlobalUI createLabelFont:14 titleColor:[UIColor blackColor] bgColor:[UIColor whiteColor]];
    _commentImg.userInteractionEnabled = YES;
    _commentLabel.userInteractionEnabled = YES;
    
    
    UITapGestureRecognizer *commentTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCommentBtn)];
    [_commentLabel  addGestureRecognizer:commentTap];
    [_commentImg  addGestureRecognizer:commentTap];
    
    
    _zanImg = [GlobalUI createImageViewbgColor:[UIColor whiteColor]];
    _zanImg.image = [UIImage imageNamed:@"zan_icon"];
    _zanImg.userInteractionEnabled = YES;
    _zanImg.backgroundColor = [UIColor whiteColor];
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapZanBtn)];
    [_zanImg  addGestureRecognizer:tap];
    
    _zanLabel = [GlobalUI createLabelFont:14 titleColor:[UIColor blackColor] bgColor:[UIColor whiteColor]];

    _bgImgsView = [[UIView alloc]init];
    
    
    
    
    [self.contentView addSubview:_avatorImg];
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_timeLabel];
    [self.contentView addSubview:_moreImg];
    [self.contentView addSubview:_distanceLabel];
    [self.contentView addSubview:_contentLabel];
    [self.contentView addSubview:_lookImg];
    [self.contentView addSubview:_lookLabel];
//    [self.contentView addSubview:_timeLabel];
    [self.contentView addSubview:_commentImg];
    [self.contentView addSubview:_commentLabel];
    [self.contentView addSubview:_zanImg];
    [self.contentView addSubview:_zanLabel];
    [self.contentView addSubview:_bgImgsView];
    
    _groupImgArr = [NSMutableArray array];
}




- (void)layoutSubviews{
    [super layoutSubviews];
    _avatorImg.frame = CGRectMake(10, 10, 50, 50);
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_avatorImg.frame) + 10, 10, 100, 30);
    
    _moreImg.frame = CGRectMake(CGRectGetWidth(self.contentView.bounds) - 45, 15, 40, 20);
    _timeLabel.frame = CGRectMake(CGRectGetMaxX(_avatorImg.frame) + 10, CGRectGetMaxY(_nameLabel.frame), SCREEN_WIDTH/4, 20);
    
    
    _distanceLabel.frame = CGRectMake(CGRectGetMaxX(_timeLabel.frame) + 13, CGRectGetMaxY(_nameLabel.frame) + 10,SCREEN_WIDTH/4, 0);
    
    CGFloat contentHeight = [_contentLabel.text heightWithWidth:CGRectGetWidth(self.contentView.bounds) - 40 font:14];
    _contentLabel.frame = CGRectMake(20, CGRectGetMaxY(_avatorImg.frame) + 20, CGRectGetWidth(self.contentView.bounds) - 40, contentHeight);
    NSInteger row = _imgArray.count / 3;// 多少行图片
    if (_imgArray.count %3 !=0) {
        ++row;
    }
    // 是否有图片，如果有图片  高度= 图片的总高度 + 中间的间距 ，如果没有 ，高度=0
    CGFloat bgH = _imgArray.count ? row * imgHeight + (row-1) * 10 :0;
    _bgImgsView.frame = CGRectMake(30, CGRectGetMaxY(_contentLabel.frame) + 10, CGRectGetWidth([UIScreen mainScreen].bounds) - 60, bgH);
    _lookImg.frame = CGRectMake(23, CGRectGetHeight(self.contentView.bounds) - 35, 25, 25);
    _lookLabel.frame = CGRectMake(CGRectGetMaxX(_lookImg.frame), CGRectGetMinY(_lookImg.frame), SCREEN_WIDTH/6, 25);
    
    _zanImg.frame = CGRectMake(CGRectGetMaxX(_lookLabel.frame) + 5, CGRectGetMinY(_lookImg.frame), 25, 25);
    _zanLabel.frame = CGRectMake(CGRectGetMaxX(_zanImg.frame) + 1, CGRectGetMinY(_lookImg.frame), SCREEN_WIDTH/6, 30);
    _commentImg.frame = CGRectMake(CGRectGetMaxX(_zanLabel.frame) + 5, CGRectGetMinY(_lookImg.frame), 25, 25);
    _commentLabel.frame = CGRectMake(CGRectGetMaxX(_commentImg.frame) +1, CGRectGetMinY(_lookImg.frame), SCREEN_WIDTH/6, 30);
    
    
     
    
  }

-(void)tapCommentBtn{
    NSLog(@"点击了评论");
}

/**********************************************/



/*******************************************/

- (void)tapZanBtn{
    _isZan = !_isZan;
    UIImage * selZan = [[UIImage imageNamed:@"zan_icon"]createImageWithColor:[UIColor redColor]];
    if (_isZan) {
        _zanImg.image = selZan;
        NSInteger zanNum = [_zanLabel.text integerValue];
        ++zanNum;
        _zanLabel.text = [NSString stringWithFormat:@"%ld",(long)zanNum];
    }else{
        _zanImg.image = [UIImage imageNamed:@"zan_icon"];
        NSInteger zanNum = [_zanLabel.text integerValue];
        --zanNum;
        _zanLabel.text = [NSString stringWithFormat:@"%ld",(long)zanNum];
    }
}

- (void)setModel:(CellModel *)model{
    if (_groupImgArr.count) {
        [_groupImgArr enumerateObjectsUsingBlock:^(UIImageView * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        [_groupImgArr removeAllObjects];
    }
   _imgArray = [model.imgsss componentsSeparatedByString:@","];
    if (_imgArray.count) {
        [self setupImageGroupView];
    }
    _avatorImg.image = [UIImage imageNamed:model.avator] ;
    _nameLabel.text = model.name;
    _timeLabel.text = model.time;
    _distanceLabel.text = model.title;
    _contentLabel.text = model.content;
    _lookLabel.text = model.time;
    _commentLabel.text = model.comemtNum;
    _zanLabel.text = model.zanNum;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setupImageGroupView{
    CGFloat w = imgHeight;
    CGFloat h = imgHeight;
    
    CGFloat edge = 10;
    for (int i = 0; i<_imgArray.count; i++) {
        
        int row = i / 3;
        int loc = i % 3;
        CGFloat x = (edge + w) * loc ;
        CGFloat y = (edge + h) * row;
        
        UIImageView * img =[[UIImageView alloc]init];
        img.image = [UIImage imageNamed:_imgArray[i]];
        img.backgroundColor = [UIColor greenColor];
        img.frame = CGRectMake(x, y, w, h);
        img.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(browerImage:)];
        [img addGestureRecognizer:tap];
        [_bgImgsView addSubview:img];
        [_groupImgArr addObject:img];
    }
    
}

#pragma mark - brower image
- (void)browerImage:(UITapGestureRecognizer *)gest{
      UIImageView * tapView = (UIImageView *)gest.view;
    XHImageViewer * brower  = [[XHImageViewer alloc]init];
    [brower showWithImageViews:_groupImgArr selectedView:tapView];
}

+ (CGFloat)cellHeightWithStr:(NSString *)str imgs:(NSArray *)imgs{
    CGFloat strH = [str heightWithWidth:CGRectGetWidth([UIScreen mainScreen].bounds) - 40 font:14];
    CGFloat cellH = strH + 160;
     NSInteger row = imgs.count / 3 ;
    if (imgs.count) {
        if ( imgs.count % 3 !=0) {
             row += 1;
        }
        cellH +=  row * imgHeight  + (row-1) * 10; // 图片高度 + 间隙
    }
    return  cellH;
}

+ (DynamicCell *)dynamicCellWithTable:(UITableView *)table{
    DynamicCell * cell = [table dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    if (!cell) {
        cell = [[DynamicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(self)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


@end
