//
//  CCScrollNode.h
//
//  Created by Carter Appleton on 3/12/13.
//  Copyright 2013 Carter Appleton.
//
//  Anyone may use the following code, just
//   keep this header in the file and cite use
//   if it ends up in a project.
//

#import "cocos2d.h"

@class CCScrollNode;

@protocol CCScrollNodeDelegate <NSObject>

//UIScrollView moved
- (void) ccScrollNode:(CCScrollNode *)scrollNode didScrollWithOffset:(CGPoint)offset;

@end

@interface CCScrollNode : CCLayer <UIScrollViewDelegate>

//Delegate for the CCScrollNode
//
@property (nonatomic, assign) NSObject<CCScrollNodeDelegate>* delegate;

//Convenience method to create ScrollNode
//
+ (CCScrollNode *) nodeWithFrame:(CGRect)frame andContentSize:(CGSize)contentSize;

//UIScrollView methods
//
- (void) setFrame:(CGRect)frame;
- (void) setContentSize:(CGSize)contentSize;
- (void) setPagingEnabled:(BOOL)paging;

@end
