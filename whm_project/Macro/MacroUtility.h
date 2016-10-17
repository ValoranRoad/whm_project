//
//  MacroUtility.h
//  e-bank
//
//  Created by chenJw on 16/9/6.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#ifndef MacroUtility_h
#define MacroUtility_h

/*** Height */
#define kStatusBarHeight 20
#define kNavBarHeight 44
#define kTabBarHeight 49
#define kScreenWitdh [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

/*** Macro */
#define Weak(name) __weak __typeof(name) w##name = name

/** 用户邮箱本地存储key */
#define kUDKeyLoginEmail @"LoginEmail"

/*** DLOG */
#if DEBUG
#ifndef DLog
#define DLog(format, args...) \
NSLog(@"[%s:%d]: " format "\n", strrchr(__FILE__, '/') + 1, __LINE__, ## args);
#endif
#else
#ifndef DLog
#define DLog(format, args...) do {} while(0)
#endif
#endif

/*** 通知中心 */
#define JwNotificationCenter [NSNotificationCenter defaultCenter]

/*** 获取当前系统的版本号 */
#define JwFloatValue [[[UIDevice currentDevice] systemVersion] floatValue]

/**
 *  RGB颜色
 */
#define JwColorRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
/**
 *  RGBA颜色
 */
#define JwColorRGBA(r,g,b,a)  [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:(a)]


//出纳
/**确定btn字体颜色*/
#define JwSure_Btn_CashierColor JwColorRGB(81, 74, 157)
/**取消btn字体颜色*/
#define JwCancel_Btn_CashierColor JwColorRGB(36, 198, 220)

//经办
/**确定btn字体颜色*/
#define JwSure_Btn_ClerkColor JwColorRGB(220, 36, 48)
/**取消btn字体颜色*/
#define JwCancel_Btn_ClerkColor JwColorRGB(123, 67, 100)

//主管
/**确定btn字体颜色*/
#define JwSure_Btn_ManagerColor JwColorRGB(248, 54, 0)
/**取消btn字体颜色*/
#define JwCancel_Btn_ManagerColor JwColorRGB(254, 140, 0)

//公用
/**标题字体颜色*/
#define JwTitleColor JwColorRGB(155, 155, 155)
/**内容字体颜色*/
#define JwTipColor JwColorRGB(74, 74, 74)

/**整体Cell背景颜色*/
#define JwMain_CellBColor JwColorRGB(238, 242, 243)
/**时间分时秒颜色*/
#define JwTime_MinColor JwColorRGB(171, 171, 171)

/**侧边菜单选中颜色*/
#define JwMenu_SelectColor JwColorRGB(231, 36, 16)

//边界距离--字体大小_规定

//信息
/**信息界面--字体距离边界*/
#define kTitle_x 30
/**信息界面--下划线距离边界*/
#define kLine_x 25
/**信息界面--下划线距离字体*/
#define kLine_y 10
/**信息界面--按钮距离边界*/
#define kButton_x 30

/**信息界面--内容字体大小*/
#define kTitle_font 15

/**金额字体大小*/
#define kMoney_font 27

//Cell
/**Cell--背景距离边界*/
#define kCell_b_x 10
/**Cell--背景距离时间*/
#define kCell_timeL_y 10

/**Cell--时间距离边界*/
#define kTimeL_x 10
#define kTimeL_y 10
/**Cell--时间字体大小*/
#define kTimeL_font 13

/**Cell--Button边距*/
#define kCell_button_x 20
#define kCell_button_y 20
#define kCell_button_bottom 20
/**Cell--Button间距*/
#define kCell_button_other 30

/**Cell--lable间距*/
#define kCell_lable_bottom 10
/**Cell--图标距离lable间距*/
#define kCell_icon_lable 15


// HM
/**Cell--白边边距*/
#define kCell_margin 15
/**Cell--黑框边距*/
#define kCell_icon_margin 10
/**Cell--下边距*/
#define kCell_bottom_margin 5
/**Cell--字体大小*/
#define kCell_Hm_font_size [UIFont systemFontOfSize:15]
/**Cell--状态字体大小*/
#define kCell_Hm_state_font_size [UIFont systemFontOfSize:13]





#endif /* MacroUtility_h */
