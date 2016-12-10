//
//  ShareManager.h
//  chardlol
//
//  Created by Chard on 2016/12/10.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ShareManager : NSObject

+ (void)shareWithController:(UIViewController *)controller Url:(NSString *)url;

@end
