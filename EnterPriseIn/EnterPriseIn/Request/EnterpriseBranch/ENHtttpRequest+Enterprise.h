//
//  ENHtttpRequest+Enterprise.h
//  EnterPriseIn
//
//  Created by 陶顺顺 on 2018/7/7.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENHtttpRequest.h"

@interface ENHtttpRequest (Enterprise)

- (void)getEnterpriseBranchListCompleteBlock:(void (^)(BOOL ok, NSString *message, NSArray *branchList))completeBlock;


@end
