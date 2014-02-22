//
//  Puzzle.m
//  cubic's square
//
//  Created by larry e on 9/29/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Puzzle.h"
#import "TileView.h"

@implementation Puzzle

@synthesize viewArray;
@synthesize viewIndices;
@synthesize solutionMatrix;
@synthesize nrows;
@synthesize ncols;
@synthesize nTiles;
@synthesize curColPosition;
@synthesize curRowPosition;
@synthesize vacantRow;
@synthesize vacantCol;
@synthesize numMoves,theLevel,numMisMatches;

int getColorIndex(int row,int col,int nrows){
	int colorindex;
	int nrows2 = nrows/2;
	switch(nrows){
		case 4:
		case 6:
		case 8:
			if((row<nrows2) && (col < nrows2)){
				colorindex=8;
			}else if((row <nrows2) && (col >= nrows2)){
				colorindex=1;
			}else if((row >=nrows2) && (col < nrows2)){
				colorindex=5;
			}else{
				colorindex=0;
			}
			break;
		case 9:
		{
			int rowmod = row / 3;
			int colmod = col / 3;
			colorindex=  rowmod + 3*colmod;
		} 
	}
	
	return colorindex;
}

-(BOOL) haveSolution{
	int nummimatches=0;
	for(int row=0;row< nrows;row++){
		for(int col=0;col<ncols;col++){
			int n = [self rowcol2index:row col:col];
			//TileView* v = [viewArray objectAtIndex:[[viewIndices objectAtIndex:n] intValue]];
			TileView* v = [viewArray objectAtIndex:[self viewIndexAt:n]];
			int curcolor = v.colorindex;
			int correctcolor = [self solutionColorIndexAt: n];
			if(curcolor!=correctcolor){
				nummimatches++;
			}
		}
	}
	return (nummimatches==0)?YES: NO;
}

-(int) solutionColorIndexAt:(int)index{
	return [[self.solutionMatrix objectAtIndex:index] intValue];
}
-(int) solutionColorIndexAt:(int) row col:(int)col{
	return [[self.solutionMatrix objectAtIndex:[self rowcol2index:row col:col]] intValue];
}

-(int) rowcol2index:(int) row col:(int)col{
	return row * self.ncols + col;
}

-(void) addViewIndex:(int) row col:(int)col{
	[viewIndices addObject: [NSNumber numberWithInt: [self rowcol2index:row col:col]]];
}

-(int) viewIndexAt:(int)row col:(int)col{
	return [self viewIndexAt: [self rowcol2index: row col:col]];
}

-(int) viewIndexAt:(int)index{
	return [[viewIndices objectAtIndex:index] intValue];
}

-(NSNumber*) viewIndexNumberAt:(int)row col:col {
	return [viewIndices objectAtIndex: [self rowcol2index:row col:col]];
}

-(IntegerArray*) initSolutionMatrix:(int) xnrows col:(int)xncols{
	IntegerArray* solnmatrix=  [[[NSMutableArray alloc] initWithCapacity:nrows*ncols] autorelease];
	if(solnmatrix != nil){
		for(int i=0;i<xnrows;i++){
			for(int j=0;j<xncols;j++){
				int colorindex = getColorIndex(i,j,xnrows);
				[solnmatrix addObject: [NSNumber numberWithInt:colorindex]];
			}
		}
	}
	return solnmatrix;
}

-(void) initViewArray:(int)xnrows col:(int)xncols{
	self.viewArray = [[[NSMutableArray alloc] initWithCapacity:xnrows*xncols] autorelease];
}
-(UIView*) viewAtRowCol:(int)row col:(int)col{
	
	return [viewArray objectAtIndex: [self viewIndexAt:row col:col]];
}

-(NSMutableArray*) makePuzzleMoves:(int) nmoves size:(int)nsize
{
	NSMutableArray* moves = [[[NSMutableArray alloc] initWithCapacity:nsize*nsize] autorelease];
	int lastrow=-1;
	int lastcol=-1;
	for(int n =0;n<nmoves;n++){
		int row = intervalRand2(nsize);
		int col = intervalRand2(nsize);
		while((row==lastrow) && (col == lastcol)){
			row = intervalRand2(nsize);
			col=intervalRand2(nsize);
		}
		lastrow=row;
		lastcol=col;
		[moves addObject: [NSNumber numberWithInt: [self rowcol2index:row col:col]]];
	}
	return moves;
}


-(void) initWithIntegerArray:(IntegerArray*)array{
	self.viewIndices=array;
	self.nrows= sqrt([array count]);
	self.ncols=self.nrows;
	self.solutionMatrix = [self initSolutionMatrix: self.nrows col:self.ncols];
	[self initViewArray:nrows col:ncols];
	//return self;
}

-(void)initWithSize:(int)numrows ncols:(int)numcols
{
	self.viewIndices =   [[[NSMutableArray alloc] initWithCapacity:nrows*ncols] autorelease];
	self.nrows=numrows;
	self.ncols=numcols;
	if(self.viewIndices != nil){
		for(int i=0;i<nrows;i++){
			for(int j=0;j<ncols;j++){
				[self addViewIndex:i col:j];
			}
		}
	}
	self.solutionMatrix = [self initSolutionMatrix: self.nrows col:self.ncols];
	[self initViewArray:nrows col:ncols];
	//return self;
}

-(void) replaceIndexAt:(int)row col:(int)col withValue:(int)newvalue
{
	[viewIndices replaceObjectAtIndex: [self rowcol2index:row col:col] 
						   withObject: [NSNumber numberWithInt:newvalue]];
}

//=========================================================== 
// dealloc
//=========================================================== 
- (void)dealloc
{
    [viewIndices release], viewIndices = nil;
    [solutionMatrix release], solutionMatrix = nil;
	[viewArray release]; viewArray = nil;
    [super dealloc];
}

@end
