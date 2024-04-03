//
//  FirstScreen.h
//  ToDoList
//
//  Created by mohamed on 02/04/2024.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"
#import "Tasks.h"

NS_ASSUME_NONNULL_BEGIN

@interface FirstScreen : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@end

NS_ASSUME_NONNULL_END
