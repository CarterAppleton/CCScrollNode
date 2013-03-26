CCScrollNode
============

OVERVIEW:
A scroll node for Cocos2D that uses a UIScrollView in the background to handle smooth bounces and accelerations.

USE:
In a CCLayer file, create your new CCScrollNode like so:

theScrollNode = [CCScrollNode nodeWithFrame:CGRectMake(...) andContentSize:CGSizeMake(...)];
[theScrollNode setDelegate:self];
[theScrollNode setPagingEnabled:YES];
[self addChild:theScrollNode];

NOTES:

+ You can add children to the CCScrollNode and they will recieve taps (no drags though)

COPYWRITE
This work is free to use, just keep my name in it and cite use. Also, let me know if you like it!

