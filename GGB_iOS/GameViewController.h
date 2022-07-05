//
// Created by Sidharth Juyal on 04/07/2022.
// Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
// 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GameViewController : UIViewController

+ (instancetype)viewControllerWithGameNamed: (NSString*)gameClassName;

@end

NS_ASSUME_NONNULL_END
