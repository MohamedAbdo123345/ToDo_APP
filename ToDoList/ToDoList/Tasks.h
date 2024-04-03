//
//  Tasks.h
//  ToDoList
//
//  Created by mohamed on 02/04/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Tasks : NSObject <NSCoding,NSSecureCoding>

@property NSString *name;
@property NSString *desc;
@property int prio;
@property int status;
@property NSDate *taskDate;
- (BOOL)isSameAs:(Tasks*) taskaya;
@end

NS_ASSUME_NONNULL_END
