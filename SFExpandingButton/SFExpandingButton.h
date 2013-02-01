//
//  SFExpandingButton.h
//
//  Created by Jason Clardy on 12/3/12.
//  Copyright (c) 2012 Jason Clardy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFExpandingButton : UIView {
    UIButton *_mainButton;
    BOOL expanded;
    
    int itemCount;
    int itemWidth;
    int totalWidth;
}

- (void)addItem:(UIImage*)itemImage withTarget:(id)target action:(SEL)action;
- (void)collapse;

@property (strong, nonatomic) UIImage *mainButtonImage;


@end
