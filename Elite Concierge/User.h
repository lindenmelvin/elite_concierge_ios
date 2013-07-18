//
//  User.h
//  Elite Concierge
//
//  Created by Linden Melvin on 6/25/13.
//  Copyright (c) 2013 Linden Melvin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * first_name;
@property (nonatomic, retain) NSString * last_name;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * authentication_token;
@property (nonatomic, retain) NSNumber * logged_in;

@end
