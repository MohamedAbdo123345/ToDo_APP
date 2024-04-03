//
//  DoneTable.h
//  ToDoList
//
//  Created by mohamed on 03/04/2024.
//

#import <UIKit/UIKit.h>
#import "Tasks.h"

NS_ASSUME_NONNULL_BEGIN

@interface DoneTable : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) Tasks *selectedTask;

@end

NS_ASSUME_NONNULL_END
