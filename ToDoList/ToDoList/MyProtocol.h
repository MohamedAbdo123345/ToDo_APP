//
//  MyProtocol.h
//  ToDoList
//
//  Created by mohamed on 02/04/2024.
//

#import <Foundation/Foundation.h>
#import"Tasks.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MyProtocol <NSObject>
- (void)didReceiveData:(Tasks *)task;

@end

NS_ASSUME_NONNULL_END
