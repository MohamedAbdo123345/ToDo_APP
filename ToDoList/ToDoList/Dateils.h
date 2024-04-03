//
//  Dateils.h
//  ToDoList
//
//  Created by mohamed on 03/04/2024.
//

#import <UIKit/UIKit.h>
#import "Tasks.h"
#import "ProgressTable.h"
#import "DoneTable.h"

NS_ASSUME_NONNULL_BEGIN

@interface Dateils : UIViewController
- (void)setToTaska:(Tasks *)t : (int)index;
-(void)setScreenIndex:(int)index;
@property (nonatomic, strong) Tasks *selectedTask;
@property (nonatomic, strong) Tasks *taskData;

@end

NS_ASSUME_NONNULL_END
