//
//  SFExpandingButton.m
//
//  Created by Jason Clardy on 12/3/12.
//  Copyright (c) 2012 Jason Clardy. All rights reserved.
//

#import "SFExpandingButton.h"

@implementation SFExpandingButton


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        expanded = FALSE;
        self.clipsToBounds = TRUE;
    }
    return self;
    
}

- (void)addItem:(UIImage*)itemImage withTarget:(id)target action:(SEL)action {
    itemCount++;
    totalWidth += itemImage.size.width;
    
    if (itemWidth < itemImage.size.width)
        itemWidth = itemImage.size.width;
    
    UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [itemButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [itemButton addTarget:self action:@selector(collapse) forControlEvents:UIControlEventTouchUpInside];

    [itemButton setBackgroundImage:itemImage forState:UIControlStateNormal];
    
    int ypos = (_mainButtonImage.size.height - itemImage.size.height) / 2;
    [itemButton setFrame:CGRectMake(-itemWidth * itemCount, ypos, itemImage.size.width, itemImage.size.height)];
    [_mainButton addSubview:itemButton];

}





- (void)setMainButtonImage:(UIImage *)mainButtonImage {
    _mainButtonImage = [mainButtonImage resizableImageWithCapInsets:UIEdgeInsetsMake(1, 0, 0, 44)];
    
    _mainButton = [UIButton buttonWithType:UIButtonTypeCustom];

    [_mainButton setBackgroundImage:self.mainButtonImage forState:UIControlStateNormal];
    [_mainButton setFrame:CGRectMake(0, 0, _mainButtonImage.size.width, _mainButtonImage.size.height)];
    [_mainButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_mainButton];

    [self layoutSubviews];
}



- (void)collapse {
    if (!expanded)
        return;
    
    
    [UIView beginAnimations:@"ButtonSlide" context:nil];
    int size = -totalWidth; 

    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width+size, self.frame.size.height)];
    [_mainButton setFrame:CGRectMake(0, 0, _mainButton.frame.size.width+size, _mainButtonImage.size.height)];
    
    int count = 0;
    for (UIView *itemButton in _mainButton.subviews) {
        if (![itemButton isKindOfClass:[UIButton class]])
            continue;
        size = -itemWidth * (itemCount - (count));

        [itemButton setFrame:CGRectMake(size, itemButton.frame.origin.y, itemButton.frame.size.width, itemButton.frame.size.height)];
        count++;
    }
    
    [UIView commitAnimations];
    expanded = FALSE;
}

- (void)buttonPressed:(id)sender {
    [UIView beginAnimations:@"ButtonSlide" context:nil];
    int size = totalWidth; 
    if (expanded) {
        size = -size;
    }
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width+size, self.frame.size.height)];
    [_mainButton setFrame:CGRectMake(0, 0, _mainButton.frame.size.width+size, _mainButtonImage.size.height)];
    
    int count = 0;
    int currentPosition = 0;
    for (UIView *itemButton in _mainButton.subviews) {
        if (![itemButton isKindOfClass:[UIButton class]])
            continue;
        if (expanded) {
            size = -itemWidth * (itemCount - (count));
        } else {
            size = currentPosition; 
            
        }
        [itemButton setFrame:CGRectMake(size, itemButton.frame.origin.y, itemButton.frame.size.width, itemButton.frame.size.height)];
        count++;
        currentPosition += itemButton.frame.size.width;
    }
    
    [UIView commitAnimations];
    expanded = !expanded;

}



@end
