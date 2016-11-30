//
//  HmBaoeCell.m
//  whm_project
//
//  Created by zhaoHm on 16/11/30.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "HmBaoeCell.h"
#import "MacroUtility.h"

@implementation HmBaoeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 图标 headImg;
        self.headImg = [[UIImageView alloc] init];
        [self.contentView addSubview:_headImg];
        // 文字 myLaber;
        self.myLaber = [[UILabel alloc] init];
        [self.contentView addSubview:_myLaber];
        // 内容 selectLaber;
        self.selectLaber = [[UITextField alloc] init];
        [self.contentView addSubview:_selectLaber];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 图标 imgHead;
    _headImg.frame = CGRectMake(9, 5, 25, 25);
    _headImg.center = CGPointMake(9 + 25 / 2, self.contentView.center.y);
    //    _headImg.backgroundColor = [UIColor redColor];
    // 文字 lblName;
    _myLaber.frame = CGRectMake(CGRectGetMaxX(_headImg.frame) + 3, CGRectGetMinY(_headImg.frame), 100, 25);
    _myLaber.font = [UIFont systemFontOfSize:14];
    // 内容 lblContent;
    _selectLaber.frame = CGRectMake(CGRectGetMaxX(_myLaber.frame) + 3, CGRectGetMinY(_myLaber.frame), kScreenWitdh - CGRectGetMaxX(_myLaber.frame) - 13 - 25, 25);
    _selectLaber.font = [UIFont systemFontOfSize:14];
    _selectLaber.textAlignment = NSTextAlignmentRight;
    _selectLaber.keyboardType = UIKeyboardTypeNumberPad;
    _selectLaber.delegate = self;
}

#pragma mark -- UITextField Delegate
- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField isEqual:_selectLaber] && textField.enabled == YES) {
        return [self validateNumber:string];
    }
    return YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
