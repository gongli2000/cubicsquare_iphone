//
//  TileView.m
//  Camera
//
//  Created by James Eclipse on 8/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TileView.h"


@implementation TileView
@synthesize color,number,usenum,colorindex;
UIColor* getColor(int index){
	NSArray* colors = [[NSArray alloc]   initWithObjects: 
					   [UIColor greenColor],
					   [UIColor blueColor],
					   [UIColor cyanColor],
					   [UIColor yellowColor],
					   [UIColor magentaColor],
					   [UIColor orangeColor],
					   [UIColor purpleColor],
					   [UIColor brownColor],
					   [UIColor redColor],
					   nil];
	UIColor* theColor=[colors objectAtIndex: index];;
	
	[colors release];
	return theColor;
}
- (id)initWithFrame:(CGRect)frame colorindex:(int)theColorindex usenum:(BOOL)usenumbers number:(int)num {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		self.color=getColor(theColorindex);
		self.colorindex=theColorindex;
		self.number=num;
		self.usenum =usenumbers;
		if(self.usenum == YES){
			UILabel* label = [[UILabel alloc] initWithFrame:frame];
			label.text=[NSString stringWithFormat:@"%ld",num];
			label.textAlignment = UITextAlignmentCenter;
			label.alpha = .6;
			[self addSubview:label];
			
		}
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}




- (void)drawRect:(CGRect)rect {
    // Drawing code
	[self.color  setFill];
	UIRectFill ([self bounds]);
}

- (void)dealloc {
	[color release];
    [super dealloc];
	
}


@end
