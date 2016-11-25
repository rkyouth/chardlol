//
//  RecommendModel.h
//  chardlol
//
//  Created by ChardLl on 2016/11/25.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "id" : "XMjg1MTcyNDQ0",
 "title" : "泡芙小姐的灯泡 11",
 "link" : "http://v.youku.com/v_show/id_XMjg1MTcyNDQ0.html",
 "thumbnail" : "http://g4.ykimg.com/0100641F464E1FC...",
 "duration" : "910",
 "state" : "normal",
 "view_count" : 2555843,
 "favorite_count" : 534,
 "comment_count" : 10,
 "up_count" : 14859,
 "down_count" : 559,
 "published" : "2011-07-15 09:00:42",
 "user" :
 {
 "id" : 58921428,
 "name" : "泡芙小姐",
 "link" : "http://u.youku.com/user_show/id_UMjM1Njg1NzEy.html"
 },
 "operation_limit": ["COMMENT_DISABLED"],
 "streamtypes" : ["flv","flvhd","hd"],
 "seq_no" : 1
 */
@interface RecommendModel : NSObject

@property (nonatomic,copy) NSString *videoId;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *link;

@property (nonatomic,copy) NSString *thumbnail;

@property (nonatomic,copy) NSString *published;

+ (instancetype)recommendWithDic:(NSDictionary *)dic;

@end
