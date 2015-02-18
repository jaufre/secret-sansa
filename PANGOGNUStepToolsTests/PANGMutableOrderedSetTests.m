//
//  PANGOrderedSetTests.m
//  PANGOrderedSetForGnuStep
//
//  Created by Jaufré Thumerel on 14/02/2015.
//  GNU LESSER GENERAL PUBLIC LICENSE
//  Version 3, 29 June 2007

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "PANGMutableOrderedSet.h"

@interface PANGMutableOrderedSetTests : XCTestCase
{
    PANGMutableOrderedSet *orderedSet;
}

@end

@implementation PANGMutableOrderedSetTests

- (void)setUp {
    [super setUp];
    orderedSet = [PANGMutableOrderedSet orderedSetWithObjects:
                  @"Vert",
                  @"Rouge",
                  @"Bleu",
                  @"Noir",
                  @"Orange",
                  nil];
}

- (void)tearDown {
    orderedSet = nil;
    [super tearDown];
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

-(void)testInit
{
    PANGMutableOrderedSet *tempSet = [[PANGMutableOrderedSet alloc] init];
    XCTAssertEqual([tempSet count], 0);
}

-(void)testInitWithObject
{
    PANGMutableOrderedSet *otherOrderedSet = [[PANGMutableOrderedSet alloc] initWithObjects:
                                      @"rouge",
                                      @"bleu",
                                      @"vert",
                                      nil];
    XCTAssertEqual([otherOrderedSet count], 3);
    XCTAssertEqualObjects([otherOrderedSet objectAtIndex:0], @"rouge");
    XCTAssertEqualObjects([otherOrderedSet objectAtIndex:1], @"bleu");
    XCTAssertEqualObjects([otherOrderedSet objectAtIndex:2], @"vert");
    otherOrderedSet = [[PANGMutableOrderedSet alloc] initWithObjects:
                       @"rouge",
                       @"bleu",
                       @"vert",
                       @"rouge",
                       @"vert",
                       @"jaune",
                       nil];
    XCTAssertEqual([otherOrderedSet count], 4);
    XCTAssertEqualObjects([otherOrderedSet objectAtIndex:0], @"rouge");
    XCTAssertEqualObjects([otherOrderedSet objectAtIndex:1], @"bleu");
    XCTAssertEqualObjects([otherOrderedSet objectAtIndex:2], @"vert");
    XCTAssertEqualObjects([otherOrderedSet objectAtIndex:3], @"jaune");
}

-(void)testInitWithObjectsC
{
    id objects[5];
    objects[0] = @"Vert";
    objects[1] = @"Rouge";
    objects[2] = @"Bleu";
    objects[3] = @"Noir";
    objects[4] = @"Orange";
    PANGMutableOrderedSet *tmpOrderedSet = [PANGMutableOrderedSet orderedSetWithObjects:objects
                                                                                count:5];
    XCTAssertEqualObjects(tmpOrderedSet, orderedSet);
    XCTAssertNotEqual(tmpOrderedSet, orderedSet);
    XCTAssertEqual([tmpOrderedSet hash], [orderedSet hash]);
}

-(void)testInitWithArray
{
    NSArray *array = [NSArray arrayWithObjects:
                      @"Vert",
                      @"Rouge",
                      @"Bleu",
                      @"Noir",
                      @"Orange",
                      nil];
    PANGMutableOrderedSet *otherOrderedSet = [[PANGMutableOrderedSet alloc] initWithArray:array];
    XCTAssertEqualObjects(otherOrderedSet, orderedSet);
}

-(void)testInitWithCapacity
{
    PANGMutableOrderedSet *otherOrderedSet = [[PANGMutableOrderedSet alloc] initWithCapacity:5];
    XCTAssertEqual([otherOrderedSet count], 0);
}

-(void)orderedSetWithCapacity
{
    PANGMutableOrderedSet *otherOrderedSet = [PANGMutableOrderedSet orderedSetWithCapacity:5];
    XCTAssertEqual([otherOrderedSet count], 0);
}

-(void)testCoding
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:orderedSet];
    PANGMutableOrderedSet *otherOrderedSet = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    XCTAssertEqualObjects(orderedSet, otherOrderedSet);
    NSLog(@"");
}

-(void)testInsertObjectAtIndex
{
    [orderedSet insertObject:@"Marron"
                     atIndex:2];
    XCTAssertEqual([orderedSet count], 6);
    XCTAssertEqualObjects([orderedSet objectAtIndex:2], @"Marron");
    XCTAssertEqualObjects([orderedSet objectAtIndex:3], @"Bleu");
    XCTAssertTrue([orderedSet containsObject:@"Marron"]);
    XCTAssertTrue([orderedSet containsObject:@"Bleu"]);
    NSArray *tempArray = [NSArray arrayWithObjects:
                          @"Vert",
                          @"Rouge",
                          @"Marron",
                          @"Bleu",
                          @"Noir",
                          @"Orange",
                          nil];
    NSSet *tempSet = [NSSet setWithObjects:
                      @"Marron",
                      @"Vert",
                      @"Rouge",
                      @"Bleu",
                      @"Noir",
                      @"Orange",
                      nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
    [orderedSet insertObject:@"Rose"
                     atIndex:6];
    XCTAssertEqual([orderedSet count], 7);
    tempArray = [NSArray arrayWithObjects:
                            @"Vert",
                            @"Rouge",
                            @"Marron",
                            @"Bleu",
                            @"Noir",
                            @"Orange",
                            @"Rose",
                            nil];
   tempSet = [NSSet setWithObjects:
                        @"Marron",
                        @"Rose",
                        @"Vert",
                        @"Rouge",
                        @"Bleu",
                        @"Noir",
                        @"Orange",
                        nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
}

- (void)testRemoveObjectAtIndex
{
    XCTAssertTrue([orderedSet containsObject:@"Noir"]);
    [orderedSet removeObjectAtIndex:3];
    XCTAssertEqual([orderedSet count], 4);
    XCTAssertFalse([orderedSet containsObject:@"Noir"]);
    NSArray *tempArray = [NSArray arrayWithObjects:
                          @"Vert",
                          @"Rouge",
                          @"Bleu",
                          @"Orange",
                          nil];
    NSSet *tempSet = [NSSet setWithObjects:
                      @"Vert",
                      @"Rouge",
                      @"Bleu",
                      @"Orange",
                      nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
}

- (void)testReplaceObjectAtIndex
{
    XCTAssertTrue([orderedSet containsObject:@"Noir"]);
    XCTAssertFalse([orderedSet containsObject:@"Jaune"]);
    [orderedSet replaceObjectAtIndex:3 withObject:@"Jaune"];
    XCTAssertEqual([orderedSet count], 5);
    XCTAssertFalse([orderedSet containsObject:@"Noir"]);
    XCTAssertTrue([orderedSet containsObject:@"Jaune"]);
    NSArray *tempArray = [NSArray arrayWithObjects:
                          @"Vert",
                          @"Rouge",
                          @"Bleu",
                          @"Jaune",
                          @"Orange",
                          nil];
    NSSet *tempSet = [NSSet setWithObjects:
                      @"Vert",
                      @"Jaune",
                      @"Rouge",
                      @"Bleu",
                      @"Orange",
                      nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
    [orderedSet replaceObjectAtIndex:2 withObject:@"Jaune"];
    XCTAssertEqual([orderedSet count], 5);
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
}

-(void)testAddObject
{
    XCTAssertFalse([orderedSet containsObject:@"Jaune"]);
    [orderedSet addObject:@"Jaune"];
    XCTAssertEqual([orderedSet count], 6);
    XCTAssertTrue([orderedSet containsObject:@"Jaune"]);
    NSArray *tempArray = [NSArray arrayWithObjects:
                          @"Vert",
                          @"Rouge",
                          @"Bleu",
                          @"Noir",
                          @"Orange",
                          @"Jaune",
                          nil];
    NSSet *tempSet = [NSSet setWithObjects:
                      @"Vert",
                      @"Jaune",
                      @"Rouge",
                      @"Bleu",
                      @"Orange",
                      @"Noir",
                      nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
    XCTAssertTrue([orderedSet containsObject:@"Rouge"]);
    [orderedSet addObject:@"Rouge"];
    XCTAssertEqual([orderedSet count], 6);
    XCTAssertTrue([orderedSet containsObject:@"Rouge"]);
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
}

-(void)testAddObjectsC
{
    id objects[6];
    objects[0] = @"Jaune";
    objects[1] = @"Rouge";
    objects[2] = @"Orange";
    objects[3] = @"Marron";
    objects[4] = @"Rose";
    objects[5] = @"Ivoire";
    XCTAssertFalse([orderedSet containsObject:@"Jaune"]);
    XCTAssertFalse([orderedSet containsObject:@"Rose"]);
    XCTAssertFalse([orderedSet containsObject:@"Marron"]);
    XCTAssertFalse([orderedSet containsObject:@"Ivoire"]);
    [orderedSet addObjects:objects
                     count:6];
    XCTAssertEqual([orderedSet count], 9);
    XCTAssertTrue([orderedSet containsObject:@"Jaune"]);
    XCTAssertTrue([orderedSet containsObject:@"Rose"]);
    XCTAssertTrue([orderedSet containsObject:@"Marron"]);
    XCTAssertTrue([orderedSet containsObject:@"Ivoire"]);
    NSArray *tempArray = [NSArray arrayWithObjects:
                          @"Vert",
                          @"Rouge",
                          @"Bleu",
                          @"Noir",
                          @"Orange",
                          @"Jaune",
                          @"Marron",
                          @"Rose",
                          @"Ivoire",
                          nil];
    NSSet *tempSet = [NSSet setWithObjects:
                      @"Vert",
                      @"Ivoire",
                      @"Jaune",
                      @"Rouge",
                      @"Marron",
                      @"Bleu",
                      @"Orange",
                      @"Noir",
                      @"Rose",
                      nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
}

-(void)testAddObjectsFromArray
{
    NSArray *array = [NSArray arrayWithObjects:
                      @"Jaune",
                      @"Rouge",
                      @"Orange",
                      @"Marron",
                      @"Rose",
                      @"Ivoire",
                      nil];
    XCTAssertFalse([orderedSet containsObject:@"Jaune"]);
    XCTAssertFalse([orderedSet containsObject:@"Rose"]);
    XCTAssertFalse([orderedSet containsObject:@"Marron"]);
    XCTAssertFalse([orderedSet containsObject:@"Ivoire"]);
    [orderedSet addObjectsFromArray:array];
    XCTAssertEqual([orderedSet count], 9);
    XCTAssertTrue([orderedSet containsObject:@"Jaune"]);
    XCTAssertTrue([orderedSet containsObject:@"Rose"]);
    XCTAssertTrue([orderedSet containsObject:@"Marron"]);
    XCTAssertTrue([orderedSet containsObject:@"Ivoire"]);
    NSArray *tempArray = [NSArray arrayWithObjects:
                          @"Vert",
                          @"Rouge",
                          @"Bleu",
                          @"Noir",
                          @"Orange",
                          @"Jaune",
                          @"Marron",
                          @"Rose",
                          @"Ivoire",
                          nil];
    NSSet *tempSet = [NSSet setWithObjects:
                      @"Vert",
                      @"Ivoire",
                      @"Jaune",
                      @"Rouge",
                      @"Marron",
                      @"Bleu",
                      @"Orange",
                      @"Noir",
                      @"Rose",
                      nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
}

-(void)testRemoveObject
{
    XCTAssertTrue([orderedSet containsObject:@"Bleu"]);
    [orderedSet removeObject:@"Bleu"];
    XCTAssertEqual([orderedSet count], 4);
    XCTAssertFalse([orderedSet containsObject:@"Bleu"]);
    NSArray *tempArray = [NSArray arrayWithObjects:
                          @"Vert",
                          @"Rouge",
                          @"Noir",
                          @"Orange",
                          nil];
    NSSet *tempSet = [NSSet setWithObjects:
                      @"Vert",
                      @"Rouge",
                      @"Orange",
                      @"Noir",
                      nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
    XCTAssertFalse([orderedSet containsObject:@"Jaune"]);
    [orderedSet removeObject:@"Jaune"];
    XCTAssertEqual([orderedSet count], 4);
    XCTAssertFalse([orderedSet containsObject:@"Jaune"]);
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
}

-(void)testRemoveObjectInArray
{
    XCTAssertTrue([orderedSet containsObject:@"Bleu"]);
    XCTAssertTrue([orderedSet containsObject:@"Orange"]);
    XCTAssertFalse([orderedSet containsObject:@"Jaune"]);
    NSArray *array = [NSArray arrayWithObjects:
                      @"Bleu",
                      @"Jaune",
                      @"Orange",
                      nil];
    [orderedSet removeObjectsInArray:array];
    XCTAssertFalse([orderedSet containsObject:@"Bleu"]);
    XCTAssertFalse([orderedSet containsObject:@"Orange"]);
    XCTAssertFalse([orderedSet containsObject:@"Jaune"]);
    XCTAssertEqual([orderedSet count], 3);
    NSArray *tempArray = [NSArray arrayWithObjects:
                          @"Vert",
                          @"Rouge",
                          @"Noir",
                          nil];
    NSSet *tempSet = [NSSet setWithObjects:
                      @"Vert",
                      @"Rouge",
                      @"Noir",
                      nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
}

-(void)testRemoveObjectInRange
{
    XCTAssertTrue([orderedSet containsObject:@"Rouge"]);
    XCTAssertTrue([orderedSet containsObject:@"Bleu"]);
    NSRange range;
    range.location = 1;
    range.length = 2;
    [orderedSet removeObjectsInRange:range];
    XCTAssertFalse([orderedSet containsObject:@"Rouge"]);
    XCTAssertFalse([orderedSet containsObject:@"Bleu"]);
    XCTAssertEqual([orderedSet count], 3);
    NSArray *tempArray = [NSArray arrayWithObjects:
                          @"Vert",
                          @"Noir",
                          @"Orange",
                          nil];
    NSSet *tempSet = [NSSet setWithObjects:
                      @"Vert",
                      @"Orange",
                      @"Noir",
                      nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
}

-(void)testRemoveObjectsAtIndexes
{
    XCTAssertTrue([orderedSet containsObject:@"Rouge"]);
    XCTAssertTrue([orderedSet containsObject:@"Noir"]);
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    [indexSet addIndex:1];
    [indexSet addIndex:3];
    [orderedSet removeObjectsAtIndexes:indexSet];
    XCTAssertFalse([orderedSet containsObject:@"Rouge"]);
    XCTAssertFalse([orderedSet containsObject:@"Noir"]);
    XCTAssertEqual([orderedSet count], 3);
    NSArray *tempArray = [NSArray arrayWithObjects:
                          @"Vert",
                          @"Bleu",
                          @"Orange",
                          nil];
    NSSet *tempSet = [NSSet setWithObjects:
                      @"Vert",
                      @"Orange",
                      @"Bleu",
                      nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
}

-(void)testRemoveAllObjects
{
    [orderedSet removeAllObjects];
    XCTAssertEqual([orderedSet count], 0);
    NSArray *tempArray = [NSArray array];
    NSSet *tempSet = [NSSet set];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
}

- (void)testExchangeObjectAtIndex
{
    XCTAssertTrue([orderedSet containsObject:@"Rouge"]);
    XCTAssertTrue([orderedSet containsObject:@"Noir"]);
    [orderedSet exchangeObjectAtIndex:3 withObjectAtIndex:1];
    XCTAssertTrue([orderedSet containsObject:@"Rouge"]);
    XCTAssertTrue([orderedSet containsObject:@"Noir"]);
    XCTAssertEqual([orderedSet count], 5);
    NSArray *tempArray = [NSArray arrayWithObjects:
                          @"Vert",
                          @"Noir",
                          @"Bleu",
                          @"Rouge",
                          @"Orange",
                          nil];
    NSSet *tempSet = [NSSet setWithObjects:
                      @"Vert",
                      @"Bleu",
                      @"Rouge",
                      @"Orange",
                      @"Noir",
                      nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
}

-(void)testMoveObjectsAtIndexes
{
    XCTAssertTrue([orderedSet containsObject:@"Rouge"]);
    XCTAssertTrue([orderedSet containsObject:@"Noir"]);
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    [indexSet addIndex:1];
    [indexSet addIndex:3];
    [orderedSet moveObjectsAtIndexes:indexSet
                             toIndex:2];
    XCTAssertTrue([orderedSet containsObject:@"Rouge"]);
    XCTAssertTrue([orderedSet containsObject:@"Noir"]);
    XCTAssertEqual([orderedSet count], 5);
    NSArray *tempArray = [NSArray arrayWithObjects:
                          @"Vert",
                          @"Bleu",
                          @"Rouge",
                          @"Noir",
                          @"Orange",
                          nil];
    NSSet *tempSet = [NSSet setWithObjects:
                      @"Vert",
                      @"Bleu",
                      @"Rouge",
                      @"Orange",
                      @"Noir",
                      nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
    [orderedSet moveObjectsAtIndexes:indexSet
                             toIndex:3];
    XCTAssertEqual([orderedSet count], 5);
    tempArray = [NSArray arrayWithObjects:
                 @"Vert",
                 @"Rouge",
                 @"Orange",
                 @"Bleu",
                 @"Noir",
                 nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
}

-(void)testInsertsObjectsAtIndexes
{
    XCTAssertFalse([orderedSet containsObject:@"Rose"]);
    XCTAssertFalse([orderedSet containsObject:@"Ivoire"]);
    XCTAssertFalse([orderedSet containsObject:@"Cyan"]);
    XCTAssertTrue([orderedSet containsObject:@"Noir"]);
    XCTAssertTrue([orderedSet containsObject:@"Orange"]);
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    [indexSet addIndex:3];
    [indexSet addIndex:7];
    [indexSet addIndex:0];
    [indexSet addIndex:1];
    [indexSet addIndex:6];
    NSArray *array = [NSArray arrayWithObjects:
                      @"Rose",
                      @"Noir",
                      @"Ivoire",
                      @"Cyan",
                      @"Orange",
                      nil];
    [orderedSet insertObjects:array atIndexes:indexSet];
    XCTAssertTrue([orderedSet containsObject:@"Rose"]);
    XCTAssertTrue([orderedSet containsObject:@"Ivoire"]);
    XCTAssertTrue([orderedSet containsObject:@"Cyan"]);
    XCTAssertTrue([orderedSet containsObject:@"Noir"]);
    XCTAssertTrue([orderedSet containsObject:@"Orange"]);
    XCTAssertEqual([orderedSet count], 8);
    NSArray *tempArray = [NSArray arrayWithObjects:
                          @"Rose",
                          @"Vert",
                          @"Rouge",
                          @"Ivoire",
                          @"Bleu",
                          @"Noir",
                          @"Cyan",
                          @"Orange",
                          nil];
    NSSet *tempSet = [NSSet setWithObjects:
                      @"Vert",
                      @"Rouge",
                      @"Bleu",
                      @"Noir",
                      @"Orange",
                      @"Rose",
                      @"Ivoire",
                      @"Cyan",
                      nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
}

-(void)testSetObjectAtIndex
{
    XCTAssertFalse([orderedSet containsObject:@"Rose"]);
    XCTAssertTrue([orderedSet containsObject:@"Rouge"]);
    XCTAssertFalse([orderedSet containsObject:@"Ivoire"]);
    [orderedSet setObject:@"Rose" atIndex:1];
    XCTAssertTrue([orderedSet containsObject:@"Rose"]);
    XCTAssertFalse([orderedSet containsObject:@"Rouge"]);
    XCTAssertEqual([orderedSet count], 5);
    NSArray *tempArray = [NSArray arrayWithObjects:
                          @"Vert",
                          @"Rose",
                          @"Bleu",
                          @"Noir",
                          @"Orange",
                          nil];
    NSSet *tempSet = [NSSet setWithObjects:
                      @"Vert",
                      @"Bleu",
                      @"Noir",
                      @"Orange",
                      @"Rose",
                      nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
}

-(void)testSetObjectAtIndexedSubscript
{
    [orderedSet setObject:@"Marron"
                     atIndexedSubscript:2];
    XCTAssertEqual([orderedSet count], 6);
    XCTAssertEqualObjects([orderedSet objectAtIndex:2], @"Marron");
    XCTAssertEqualObjects([orderedSet objectAtIndex:3], @"Bleu");
    XCTAssertTrue([orderedSet containsObject:@"Marron"]);
    XCTAssertTrue([orderedSet containsObject:@"Bleu"]);
    NSArray *tempArray = [NSArray arrayWithObjects:
                          @"Vert",
                          @"Rouge",
                          @"Marron",
                          @"Bleu",
                          @"Noir",
                          @"Orange",
                          nil];
    NSSet *tempSet = [NSSet setWithObjects:
                      @"Marron",
                      @"Vert",
                      @"Rouge",
                      @"Bleu",
                      @"Noir",
                      @"Orange",
                      nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
    [orderedSet setObject:@"Rose"
       atIndexedSubscript:6];
    XCTAssertEqual([orderedSet count], 7);
    tempArray = [NSArray arrayWithObjects:
                 @"Vert",
                 @"Rouge",
                 @"Marron",
                 @"Bleu",
                 @"Noir",
                 @"Orange",
                 @"Rose",
                 nil];
    tempSet = [NSSet setWithObjects:
               @"Marron",
               @"Rose",
               @"Vert",
               @"Rouge",
               @"Bleu",
               @"Noir",
               @"Orange",
               nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
}

-(void)testReplaceObjectsInRange
{
    id objects[3];
    objects[0] = @"Rose";
    objects[1] = @"Vert";
    objects[2] = @"Ivoire";
    NSRange range;
    range.location = 1;
    range.length = 3;
    XCTAssertFalse([orderedSet containsObject:@"Rose"]);
    XCTAssertTrue([orderedSet containsObject:@"Vert"]);
    XCTAssertFalse([orderedSet containsObject:@"Ivoire"]);
    XCTAssertTrue([orderedSet containsObject:@"Rouge"]);
    XCTAssertTrue([orderedSet containsObject:@"Bleu"]);
    XCTAssertTrue([orderedSet containsObject:@"Noir"]);
    [orderedSet replaceObjectsInRange:range
                          withObjects:objects
                                count:3];
    XCTAssertEqual([orderedSet count], 5);
    XCTAssertTrue([orderedSet containsObject:@"Rose"]);
    XCTAssertTrue([orderedSet containsObject:@"Vert"]);
    XCTAssertTrue([orderedSet containsObject:@"Ivoire"]);
    XCTAssertFalse([orderedSet containsObject:@"Rouge"]);
    XCTAssertTrue([orderedSet containsObject:@"Bleu"]);
    XCTAssertFalse([orderedSet containsObject:@"Noir"]);
    NSArray *tempArray = [NSArray arrayWithObjects:
                          @"Vert",
                          @"Rose",
                          @"Bleu",
                          @"Ivoire",
                          @"Orange",
                          nil];
    NSSet *tempSet = [NSSet setWithObjects:
                      @"Vert",
                      @"Bleu",
                      @"Rose",
                      @"Orange",
                      @"Ivoire",
                      nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
}

- (void)testReplaceObjectsAtIndexes
{
    XCTAssertFalse([orderedSet containsObject:@"Rose"]);
    XCTAssertFalse([orderedSet containsObject:@"Ivoire"]);
    XCTAssertTrue([orderedSet containsObject:@"Vert"]);
    XCTAssertTrue([orderedSet containsObject:@"Bleu"]);
    XCTAssertTrue([orderedSet containsObject:@"Orange"]);
     XCTAssertTrue([orderedSet containsObject:@"Noir"]);
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    [indexSet addIndex:2];
    [indexSet addIndex:4];
    [indexSet addIndex:0];
    NSArray *array = [NSArray arrayWithObjects:
                      @"Rose",
                      @"Noir",
                      @"Ivoire",
                      nil];
    [orderedSet replaceObjectsAtIndexes:indexSet
                            withObjects:array];
    XCTAssertTrue([orderedSet containsObject:@"Rose"]);
    XCTAssertTrue([orderedSet containsObject:@"Ivoire"]);
    XCTAssertFalse([orderedSet containsObject:@"Vert"]);
    XCTAssertTrue([orderedSet containsObject:@"Bleu"]);
    XCTAssertFalse([orderedSet containsObject:@"Orange"]);
    XCTAssertTrue([orderedSet containsObject:@"Noir"]);
    XCTAssertEqual([orderedSet count], 5);
    NSArray *tempArray = [NSArray arrayWithObjects:
                          @"Rose",
                          @"Rouge",
                          @"Bleu",
                          @"Noir",
                          @"Ivoire",
                          nil];
    NSSet *tempSet = [NSSet setWithObjects:
                      @"Noir",
                      @"Ivoire",
                      @"Rose",
                      @"Rouge",
                      @"Bleu",
                      nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
}

-(void)testIntersectOrderedSet
{
    PANGOrderedSet *otherOrderedSet = [[PANGOrderedSet alloc] initWithObjects:
                                      @"Vert",
                                      @"Marron",
                                      @"Bleu",
                                      @"Ivoire",
                                      nil];
    [orderedSet intersectOrderedSet:otherOrderedSet];
    XCTAssertEqual([orderedSet count], 2);
    NSArray *tempArray = [NSArray arrayWithObjects:
                          @"Vert",
                          @"Bleu",
                          nil];
    NSSet *tempSet = [NSSet setWithObjects:
                      @"Vert",
                      @"Bleu",
                      nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
}

-(void)testMinusOrderedSet
{
    PANGOrderedSet *otherOrderedSet = [[PANGOrderedSet alloc] initWithObjects:
                                      @"Vert",
                                      @"Marron",
                                      @"Bleu",
                                      @"Ivoire",
                                      nil];
    [orderedSet minusOrderedSet:otherOrderedSet];
    XCTAssertEqual([orderedSet count], 3);
    NSArray *tempArray = [NSArray arrayWithObjects:
                          @"Rouge",
                          @"Noir",
                          @"Orange",
                          nil];
    NSSet *tempSet = [NSSet setWithObjects:
                      @"Noir",
                      @"Orange",
                      @"Rouge",
                      nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
}

-(void)testUnionOrderedSet
{
    PANGOrderedSet *otherOrderedSet = [[PANGOrderedSet alloc] initWithObjects:
                                      @"Vert",
                                      @"Marron",
                                      @"Bleu",
                                      @"Ivoire",
                                      nil];
    [orderedSet unionOrderedSet:otherOrderedSet];
    XCTAssertEqual([orderedSet count], 7);
    NSArray *tempArray = [NSArray arrayWithObjects:
                          @"Vert",
                          @"Rouge",
                          @"Bleu",
                          @"Noir",
                          @"Orange",
                          @"Marron",
                          @"Ivoire",
                          nil];
    NSSet *tempSet = [NSSet setWithObjects:
                      @"Noir",
                      @"Orange",
                      @"Marron",
                      @"Ivoire",
                      @"Vert",
                      @"Rouge",
                      @"Bleu",
                      nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
}

-(void)testIntersectSet
{
    NSSet *otherSet = [[NSSet alloc] initWithObjects:
                       @"Vert",
                       @"Marron",
                       @"Bleu",
                       @"Ivoire",
                       nil];
    [orderedSet intersectSet:otherSet];
    XCTAssertEqual([orderedSet count], 2);
    NSArray *tempArray = [NSArray arrayWithObjects:
                          @"Vert",
                          @"Bleu",
                          nil];
    NSSet *tempSet = [NSSet setWithObjects:
                      @"Vert",
                      @"Bleu",
                      nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
}

-(void)testMinusdSet
{
    NSSet *otherSet = [[NSSet alloc] initWithObjects:
                       @"Vert",
                       @"Marron",
                       @"Bleu",
                       @"Ivoire",
                       nil];
    [orderedSet minusSet:otherSet];
    XCTAssertEqual([orderedSet count], 3);
    NSArray *tempArray = [NSArray arrayWithObjects:
                          @"Rouge",
                          @"Noir",
                          @"Orange",
                          nil];
    NSSet *tempSet = [NSSet setWithObjects:
                      @"Noir",
                      @"Orange",
                      @"Rouge",
                      nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
}

-(void)testUnionSet
{
    NSSet *otherSet = [[NSSet alloc] initWithObjects:
                       @"Vert",
                       @"Marron",
                       @"Bleu",
                       @"Ivoire",
                       nil];
    [orderedSet unionSet:otherSet];
    XCTAssertEqual([orderedSet count], 7);
    NSArray *tempArray = [NSArray arrayWithObjects:
                          @"Vert",
                          @"Rouge",
                          @"Bleu",
                          @"Noir",
                          @"Orange",
                          @"Marron",
                          @"Ivoire",
                          nil];
    NSSet *tempSet = [NSSet setWithObjects:
                      @"Noir",
                      @"Orange",
                      @"Marron",
                      @"Ivoire",
                      @"Vert",
                      @"Rouge",
                      @"Bleu",
                      nil];
    XCTAssertEqual([tempArray count], [[orderedSet array] count]);
    NSArray *cpArray = [orderedSet array];
    for (id obj in tempArray) {
        XCTAssertTrue([cpArray containsObject:obj]);
    }
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
}

-(void)testSortUsingComparator
{
    [orderedSet sortUsingComparator: ^(id obj1, id obj2) {
        NSString *string1 = (NSString *)obj1;
        NSString *string2 = (NSString *)obj2;
        return [string1 compare:string2];
    }];
    XCTAssertEqual([orderedSet count], 5);
    NSArray *tempArray = [NSArray arrayWithObjects:
                      @"Bleu",
                      @"Noir",
                      @"Orange",
                      @"Rouge",
                      @"Vert",
                      nil];
    NSSet *tempSet = [NSSet setWithObjects:
                      @"Vert",
                      @"Rouge",
                      @"Bleu",
                      @"Noir",
                      @"Orange",
                      nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
}

-(void)testSortWithOptionsUsingComparator
{
    [orderedSet sortWithOptions:0
                usingComparator:^(id obj1, id obj2) {
        NSString *string1 = (NSString *)obj1;
        NSString *string2 = (NSString *)obj2;
        return [string1 compare:string2];
    }];
    XCTAssertEqual([orderedSet count], 5);
    NSArray *tempArray = [NSArray arrayWithObjects:
                          @"Bleu",
                          @"Noir",
                          @"Orange",
                          @"Rouge",
                          @"Vert",
                          nil];
    NSSet *tempSet = [NSSet setWithObjects:
                      @"Vert",
                      @"Rouge",
                      @"Bleu",
                      @"Noir",
                      @"Orange",
                      nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
}

-(void)testSortRange
{
    NSRange range;
    range.location = 1;
    range.length = 3;
    [orderedSet sortRange:range
                  options:0
                usingComparator:^(id obj1, id obj2) {
                    NSString *string1 = (NSString *)obj1;
                    NSString *string2 = (NSString *)obj2;
                    return [string1 compare:string2];
                }];
    XCTAssertEqual([orderedSet count], 5);
    NSArray *tempArray = [NSArray arrayWithObjects:
                          @"Vert",
                          @"Bleu",
                          @"Noir",
                          @"Rouge",
                          @"Orange",
                          nil];
    NSSet *tempSet = [NSSet setWithObjects:
                      @"Vert",
                      @"Rouge",
                      @"Bleu",
                      @"Noir",
                      @"Orange",
                      nil];
    XCTAssertEqualObjects(tempArray, [orderedSet array]);
    XCTAssertEqualObjects(tempSet, [orderedSet set]);
}

@end
