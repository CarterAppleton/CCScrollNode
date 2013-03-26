//
//  CCScrollNode.m
//
//  Created by Carter Appleton on 3/12/13.
//  Copyright 2013 Carter Appleton
//
//  Anyone may use the following code, just
//   keep this header in the file and cite use
//   if it ends up in a project.
//

#import "CCScrollNode.h"

@interface CCScrollNode ()

@property (nonatomic, assign) CCNode* subnode;

@property (nonatomic, assign) UIView* dummyView;
@property (nonatomic, assign) UIScrollView* scrollView;

@end

@implementation CCScrollNode

@synthesize delegate;

//private synthesize
@synthesize subnode, dummyView, scrollView = scrollView_;

+ (CCScrollNode *) nodeWithFrame:(CGRect)frame andContentSize:(CGSize)contentSize
{
    CCScrollNode* node = [[[CCScrollNode alloc] init] autorelease];
    
    [node setFrame:frame];
    [node setContentSize:contentSize];
    
    return node;
}

- (id) init
{
    self = [super init];
    
    if(self)
    {
        self.isTouchEnabled = YES;
               
        self.scrollView = [[[UIScrollView alloc] init] autorelease];
        self.scrollView .delegate = self;
        self.scrollView .hidden = YES;
        [[[CCDirector sharedDirector] view] addSubview:self.scrollView ];
        
        [self.scrollView .panGestureRecognizer setCancelsTouchesInView:YES];
                
        self.dummyView = [[[UIView alloc] init] autorelease];
        [self.dummyView addGestureRecognizer:self.scrollView .panGestureRecognizer];
        [[[CCDirector sharedDirector] view] addSubview:self.dummyView];
        
        self.subnode = [[CCNode alloc] init];
        [super addChild:self.subnode];
    }
    
    return self;
}

#pragma mark Override CCNode

- (void) addChild:(CCNode *)node
{
    [self.subnode addChild:node];
}

- (void) onExit
{
    [super onExit];
    
    [self.dummyView removeGestureRecognizer:self.scrollView .panGestureRecognizer];
    [self.dummyView removeFromSuperview];
    
    [self.scrollView  setDelegate:NULL];
    [self.scrollView  removeFromSuperview];
    self.scrollView = nil;
}

#pragma mark UIScrollView Helpers

- (void) setFrame:(CGRect)frame
{
    CGSize s = [[CCDirector sharedDirector] winSize];
    
    CGRect rect = CGRectMake(frame.origin.x, s.height - frame.size.height - frame.origin.y, frame.size.width, frame.size.height);
    
    self.scrollView .frame = rect;
    self.dummyView.frame = rect;
}

- (void) setContentSize:(CGSize)contentSize
{
    self.scrollView.contentSize = contentSize;
}

- (void) setPagingEnabled:(BOOL)paging
{
    [self.scrollView setPagingEnabled:paging];
}

#pragma mark UIScrollViewDelegate

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = ccp(-scrollView.contentOffset.x,scrollView.contentOffset.y);
    self.subnode.position = offset;
    
    //Force the scene to draw- UIScrollView inturrupts the drawing thread
    [[CCDirector sharedDirector] drawScene];
                         
    if(self.delegate)
        [self.delegate ccScrollNode:self didScrollWithOffset:offset];
}

@end
