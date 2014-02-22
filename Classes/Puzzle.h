//
//  Puzzle.h
//  cubic's square
//  Created by larry e on 9/29/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TypeDefs.h"

@interface Puzzle : NSObject {
	IntegerArray*  viewIndices;
	IntegerArray* solutionMatrix;
	NSMutableArray* viewArray;
	int nrows;
	int ncols;
	int nTiles;
	int curColPosition;
	int curRowPosition;
	int vacantRow;
	int vacantCol;
	int numMoves,theLevel,numMisMatches;
}

@property (nonatomic,retain)NSMutableArray *viewArray;
@property(nonatomic,retain)NSMutableArray *viewIndices;
@property(nonatomic,retain)NSMutableArray *solutionMatrix;
@property(nonatomic,assign)int nrows;
@property(nonatomic,assign)int ncols;
@property(nonatomic,assign)int nTiles;
@property(nonatomic,assign)int curColPosition;
@property(nonatomic,assign)int curRowPosition;
@property(nonatomic,assign)int vacantRow;
@property(nonatomic,assign)int vacantCol;
@property(nonatomic,assign)int numMoves,theLevel,numMisMatches;

-(int) solutionColorIndexAt:(int)index;
-(int) solutionColorIndexAt:(int)row col:(int) col;
-(void) initWithIntegerArray:(IntegerArray*)array;
-(void)initWithSize:(int)nrows ncols:(int)ncols;
-(int) rowcol2index:(int) row col:(int)col;
-(void) addViewIndex:(int) row col:(int)col;
-(int) viewIndexAt:(int)index;
-(int) viewIndexAt:(int)row col:(int)col;
-(NSNumber*) viewIndexNumberAt:(int)row col:col;
-(void) replaceIndexAt:(int)row col:(int)col withValue:(int)newvalue;
-(UIView*) viewAtRowCol:(int)row col:(int)col;
-(NSMutableArray*) makePuzzleMoves:(int) nmoves size:(int)nsize;

//[viewIndices addObject: [NSNumber numberWithInt: [self rowcol2index:row col:col]]];
@end
