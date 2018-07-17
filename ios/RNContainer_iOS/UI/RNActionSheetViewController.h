//
//  RNActionSheetViewController.h
//
//  Created by Johnnie on 19/12/17.
//

#import "JCBaseActionMenuViewController.h"


@interface RNActionSheetViewController : JCBaseActionMenuViewController

- (instancetype)initWithJsbundleName:(NSString *)jsbundleName
                   moduleName:(NSString *)moduleName
            initialProperties:(NSDictionary *)initialProperties;

@end
