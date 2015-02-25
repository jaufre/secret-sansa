//
//  PANGOrderedSetForGnuStepTests.m
//  PANGOrderedSetForGnuStepTests
//
//  Created by Jaufré Thumerel on 05/02/2015.
//  GNU LESSER GENERAL PUBLIC LICENSE
//  Version 3, 29 June 2007

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "PANGOrderedSet.h"
#import "PANGMutableOrderedSet.h"

@interface PANGOrderedSetForGnuStepTests : XCTestCase
{
    PANGOrderedSet *orderedSet;
}

@end

@implementation PANGOrderedSetForGnuStepTests

- (void)setUp {
    [super setUp];
    orderedSet = [PANGOrderedSet orderedSetWithObjects:
                  @"Vert",
                  @"Rouge",
                  @"Bleu",
                  @"Noir",
                  @"Orange",
                  nil];
}

- (void)tearDown
{
    [super tearDown];
    orderedSet = nil;
}

-(void)testGetObject
{
    __unsafe_unretained id  objects[3];
    NSRange range;
    range.location = 1;
    range.length = 3;
    [orderedSet getObjects:objects
                     range:range];
    XCTAssertEqual(objects[0], @"Rouge");
    XCTAssertEqual(objects[1], @"Bleu");
    XCTAssertEqual(objects[2], @"Noir");
}

- (void)testCount
{
    XCTAssertEqual([orderedSet count], 5);
}

- (void)testObjectAtIndex
{
    XCTAssertEqualObjects([orderedSet objectAtIndex:2], @"Bleu");
}

-(void)testIndexOfObject
{
    XCTAssertEqual([orderedSet indexOfObject:@"Rouge"], 1);
    XCTAssertEqual([orderedSet indexOfObject:@"rouge"], NSNotFound);
}

-(void)testInit
{
    PANGOrderedSet *tempSet = [[PANGOrderedSet alloc] init];
    XCTAssertEqual([tempSet count], 0);
}

-(void)testInitWithObject
{
    PANGOrderedSet *otherOrderedSet = [[PANGOrderedSet alloc] initWithObjects:
                                      @"rouge",
                                      @"bleu",
                                      @"vert",
                                      nil];
    XCTAssertEqual([otherOrderedSet count], 3);
    XCTAssertEqualObjects([otherOrderedSet objectAtIndex:0], @"rouge");
    XCTAssertEqualObjects([otherOrderedSet objectAtIndex:1], @"bleu");
    XCTAssertEqualObjects([otherOrderedSet objectAtIndex:2], @"vert");
    otherOrderedSet = [[PANGOrderedSet alloc] initWithObjects:
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

-(void)testEqual
{
    PANGOrderedSet *tempSet = [[PANGOrderedSet alloc] init];
    XCTAssertNotEqual(tempSet, orderedSet);
    tempSet = [[PANGOrderedSet alloc] initWithObjects:
               @"Vert",
               @"Rouge",
               @"Bleu",
               @"Noir",
               @"Orange",
               nil];
    XCTAssertEqualObjects(tempSet, orderedSet);
    XCTAssertEqual([tempSet hash], [orderedSet hash]);
    tempSet = [[PANGOrderedSet alloc] initWithObjects:
               @"Vert",
               @"Rouge",
               @"Marron",
               @"Noir",
               @"Orange",
               nil];
    XCTAssertNotEqualObjects(tempSet, orderedSet);
    tempSet = [[PANGMutableOrderedSet alloc] initWithObjects:
               @"Vert",
               @"Rouge",
               @"Bleu",
               @"Noir",
               @"Orange",
               nil];
    XCTAssertEqualObjects(orderedSet, tempSet);
    XCTAssertNotEqualObjects(tempSet, orderedSet);
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
    PANGOrderedSet *otherOrderedSet = [[PANGOrderedSet alloc] initWithArray:array];
    XCTAssertEqualObjects(otherOrderedSet, orderedSet);
}

-(void)testObjectsAtIndexes
{
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    [indexSet addIndex:1];
    [indexSet addIndex:3];
    NSArray *array = [orderedSet objectsAtIndexes:indexSet];
    NSArray *otherArray = [NSArray arrayWithObjects:
                           @"Rouge",
                           @"Noir",
                           nil];
    XCTAssertEqualObjects(array, otherArray);
    XCTAssertTrue([array isEqualTo:otherArray]);
}

-(void)testFirstObject
{
    XCTAssertEqualObjects([orderedSet firstObject], @"Vert");
}

-(void)testLastObject
{
    XCTAssertEqualObjects([orderedSet lastObject], @"Orange");
}

-(void)testIsEqualToOrderedSet
{
    PANGOrderedSet *tempSet = [[PANGOrderedSet alloc] initWithObjects:
               @"Vert",
               @"Rouge",
               @"Bleu",
               @"Noir",
               @"Orange",
               nil];
    XCTAssertTrue([orderedSet isEqualToOrderedSet:tempSet]);
}

-(void)testCoding
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:orderedSet];
    PANGOrderedSet *otherOrderedSet = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    XCTAssertEqualObjects(orderedSet, otherOrderedSet);
}

-(void)testContainsObject
{
    XCTAssertTrue([orderedSet containsObject:@"Vert"]);
    XCTAssertTrue([orderedSet containsObject:@"Rouge"]);
    XCTAssertTrue([orderedSet containsObject:@"Bleu"]);
    XCTAssertTrue([orderedSet containsObject:@"Noir"]);
    XCTAssertTrue([orderedSet containsObject:@"Orange"]);
    XCTAssertFalse([orderedSet containsObject:@"orange"]);
    XCTAssertFalse([orderedSet containsObject:@"violet"]);
    XCTAssertFalse([orderedSet containsObject:@"Pourpre"]);
}

-(void)testIntersectOrderedSet
{
    PANGOrderedSet *otherOrderedSet = [[PANGOrderedSet alloc] initWithObjects:
                                      @"Vert",
                                      @"Rouge",
                                      @"Bleu",
                                      @"Noir",
                                      @"Orange",
                                      nil];
    XCTAssertTrue([orderedSet intersectsOrderedSet:otherOrderedSet]);
    otherOrderedSet = [[PANGOrderedSet alloc] initWithObjects:
                       @"Vert",
                       @"Rouge",
                       @"Orange",
                       nil];
    XCTAssertTrue([orderedSet intersectsOrderedSet:otherOrderedSet]);
    otherOrderedSet = [[PANGOrderedSet alloc] initWithObjects:
                       @"Pourpre",
                       @"Rose",
                       @"Ivoire",
                       nil];
    XCTAssertFalse([orderedSet intersectsOrderedSet:otherOrderedSet]);
    otherOrderedSet = [[PANGOrderedSet alloc] initWithObjects:
                       @"Pourpre",
                       @"Rose",
                       @"Ivoire",
                       @"Noir",
                       nil];
    XCTAssertTrue([orderedSet intersectsOrderedSet:otherOrderedSet]);
}

-(void)testIntersectSet
{
    NSSet *otherSet = [[NSSet alloc] initWithObjects:
                                      @"Vert",
                                      @"Rouge",
                                      @"Bleu",
                                      @"Noir",
                                      @"Orange",
                                      nil];
    XCTAssertTrue([orderedSet intersectsSet:otherSet]);
    otherSet = [[NSSet alloc] initWithObjects:
                       @"Vert",
                       @"Rouge",
                       @"Orange",
                       nil];
    XCTAssertTrue([orderedSet intersectsSet:otherSet]);
    otherSet = [[NSSet alloc] initWithObjects:
                       @"Pourpre",
                       @"Rose",
                       @"Ivoire",
                       nil];
    XCTAssertFalse([orderedSet intersectsSet:otherSet]);
    otherSet = [[NSSet alloc] initWithObjects:
                       @"Pourpre",
                       @"Rose",
                       @"Ivoire",
                       @"Noir",
                       nil];
    XCTAssertTrue([orderedSet intersectsSet:otherSet]);
}

-(void)testIsSubsetOfOrderedSet
{
    PANGOrderedSet *otherOrderedSet = [[PANGOrderedSet alloc] initWithObjects:
                                      @"Vert",
                                      @"Rouge",
                                      @"Bleu",
                                      @"Noir",
                                      @"Orange",
                                      nil];
    XCTAssertTrue([otherOrderedSet isSubsetOfOrderedSet:orderedSet]);
    otherOrderedSet = [[PANGOrderedSet alloc] initWithObjects:
                       @"Vert",
                       @"Rouge",
                       @"Orange",
                       nil];
    XCTAssertTrue([otherOrderedSet isSubsetOfOrderedSet:orderedSet]);
    otherOrderedSet = [[PANGOrderedSet alloc] initWithObjects:
                       @"Vert",
                       @"Rose",
                       @"Orange",
                       nil];
    XCTAssertFalse([otherOrderedSet isSubsetOfOrderedSet:orderedSet]);
    otherOrderedSet = [[PANGOrderedSet alloc] initWithObjects:
                       @"Vert",
                       @"Rouge",
                       @"Bleu",
                       @"Orange",
                       @"Ivoire",
                       nil];
    XCTAssertFalse([otherOrderedSet isSubsetOfOrderedSet:orderedSet]);
}

-(void)testIsSubsetOfSet
{
    NSSet *set = [[NSSet alloc] initWithObjects:
                                      @"Vert",
                                      @"Rouge",
                                      @"Bleu",
                                      @"Noir",
                                      @"Orange",
                                      nil];
    PANGOrderedSet *tempOrderedSet = [[PANGOrderedSet alloc] initWithObjects:
                                     @"Vert",
                                     @"Rouge",
                                     @"Bleu",
                                     @"Noir",
                                     @"Orange",
                                     nil];
    XCTAssertTrue([tempOrderedSet isSubsetOfSet:set]);
    tempOrderedSet = [[PANGOrderedSet alloc] initWithObjects:
                       @"Vert",
                       @"Rouge",
                       @"Orange",
                       nil];
    XCTAssertTrue([tempOrderedSet isSubsetOfSet:set]);
    tempOrderedSet = [[PANGOrderedSet alloc] initWithObjects:
                       @"Vert",
                       @"Rose",
                       @"Orange",
                       nil];
    XCTAssertFalse([tempOrderedSet isSubsetOfSet:set]);
    tempOrderedSet = [[PANGOrderedSet alloc] initWithObjects:
                       @"Vert",
                       @"Rouge",
                       @"Bleu",
                       @"Orange",
                       @"Ivoire",
                       nil];
    XCTAssertFalse([tempOrderedSet isSubsetOfSet:set]);
}

- (void)testObjectAtIndexSubscript
{
    XCTAssertEqualObjects([orderedSet objectAtIndexedSubscript:2], @"Bleu");
}

-(void)testObjectEnumerator
{
    NSEnumerator *enumerator = [orderedSet objectEnumerator];
    XCTAssertEqual([enumerator nextObject], [orderedSet objectAtIndex:0]);
    XCTAssertEqual([enumerator nextObject], [orderedSet objectAtIndex:1]);
    XCTAssertEqual([enumerator nextObject], [orderedSet objectAtIndex:2]);
    XCTAssertEqual([enumerator nextObject], [orderedSet objectAtIndex:3]);
    XCTAssertEqual([enumerator nextObject], [orderedSet objectAtIndex:4]);
    XCTAssertNil([enumerator nextObject]);
}

-(void)testReverseObjectEnumerator
{
    NSEnumerator *reverseEnumerator = [orderedSet reverseObjectEnumerator];
    XCTAssertEqual([reverseEnumerator nextObject], [orderedSet objectAtIndex:4]);
    XCTAssertEqual([reverseEnumerator nextObject], [orderedSet objectAtIndex:3]);
    XCTAssertEqual([reverseEnumerator nextObject], [orderedSet objectAtIndex:2]);
    XCTAssertEqual([reverseEnumerator nextObject], [orderedSet objectAtIndex:1]);
    XCTAssertEqual([reverseEnumerator nextObject], [orderedSet objectAtIndex:0]);
    XCTAssertNil([reverseEnumerator nextObject]);
}

-(void)testReversedOrderedSet
{
    PANGOrderedSet *reversedOrderedSet = [[PANGOrderedSet alloc] initWithObjects:
                                 @"Orange",
                                 @"Noir",
                                 @"Bleu",
                                 @"Rouge",
                                 @"Vert",
                                 nil];
    XCTAssertEqualObjects(reversedOrderedSet, [orderedSet reversedOrderedSet]);
}

-(void)testArray
{
    NSArray *array = [orderedSet array];
    NSArray *otherArray = [NSArray arrayWithObjects:
                           @"Vert",
                           @"Rouge",
                           @"Bleu",
                           @"Noir",
                           @"Orange",
                           nil];
    XCTAssertEqualObjects(array, otherArray);
    NSArray *array2 = [orderedSet array];;
    XCTAssertEqualObjects(array, array2);
}

-(void)testSet
{
    NSSet *set = [orderedSet set];
    NSSet *otherSet = [NSSet setWithObjects:
                           @"Vert",
                           @"Rouge",
                           @"Bleu",
                           @"Noir",
                           @"Orange",
                           nil];
    XCTAssertEqualObjects(set, otherSet);
    NSSet *set2 = [orderedSet set];;
    XCTAssertEqualObjects(set, set2);
}

-(void)testCopy
{
    PANGOrderedSet *otherOrderedSet = [orderedSet copy];
    XCTAssertNotEqual(otherOrderedSet, orderedSet);
    XCTAssertEqualObjects(otherOrderedSet, orderedSet);
    XCTAssertEqual([otherOrderedSet hash], [orderedSet hash]);
}

-(void)testEnumerateObjectsUsingBlock
{
    [orderedSet enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XCTAssertEqualObjects(obj, [orderedSet objectAtIndex:idx]);
    }];
}

-(void)testEnumerateObjectsWithOptions
{
    [orderedSet enumerateObjectsWithOptions:0 usingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        XCTAssertEqualObjects(obj, [orderedSet objectAtIndex:idx]);
    }];
    [orderedSet enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        XCTAssertEqualObjects(obj, [orderedSet objectAtIndex:idx]);
    }];
}

-(void)testEnumerateObjectsAtIndexes
{
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    [indexSet addIndex:1];
    [indexSet addIndex:3];
    NSArray *array = [orderedSet objectsAtIndexes:indexSet];
    [orderedSet enumerateObjectsAtIndexes:indexSet options:0 usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XCTAssertEqualObjects(obj, [orderedSet objectAtIndex:idx]);
        XCTAssertTrue([array containsObject:obj]);
        [indexSet containsIndex:idx];
    }];
}

-(void)testIndexOfObjectPassingTest
{
    NSUInteger idx = [orderedSet indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isEqualToString:@"Noir"]) {
            return YES;
        }
        return NO;
    }];
    XCTAssertEqual(idx, 3);
}

-(void)testIndexOfObjectWithOptions
{
    NSUInteger idx = [orderedSet indexOfObjectWithOptions:0
                                              passingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isEqualToString:@"Noir"]) {
            return YES;
        }
        return NO;
    }];
    XCTAssertEqual(idx, 3);
    idx = [orderedSet indexOfObjectWithOptions:NSEnumerationReverse
                                   passingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
                                       if ([obj isEqualToString:@"Noir"]) {
                                           return YES;
                                       }
                                       return NO;
                                   }];
    XCTAssertEqual(idx, 3);
}

-(void)testIndexOfObjectAtIndexes
{
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    [indexSet addIndex:1];
    [indexSet addIndex:2];
    [indexSet addIndex:3];
    NSUInteger idx = [orderedSet indexOfObjectAtIndexes:indexSet
                                                options:0
                                            passingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
                                                if ([obj length] == 4) {
                                                    return YES;
                                                }
                                                return NO;
        
    }];
    XCTAssertEqual(idx, 2);
    idx = [orderedSet indexOfObjectAtIndexes:indexSet
                                     options:NSEnumerationReverse
                                 passingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
                                     if ([obj length] == 4) {
                                         return YES;
                                     }
                                     return NO;
                                     
                                 }];
    XCTAssertEqual(idx, 3);
}

-(void)testIndexesOfObjectsPassingTest
{
    NSMutableIndexSet *tempIndexSet = [NSMutableIndexSet indexSet];
    [tempIndexSet addIndex:0];
    [tempIndexSet addIndex:2];
    [tempIndexSet addIndex:3];
    NSIndexSet *indexSet = [orderedSet indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj length] == 4) {
            return YES;
        }
        return NO;
    }];
    XCTAssertEqualObjects(indexSet, tempIndexSet);
}

-(void)testIndexesOfObjectsWithOptions
{
    NSMutableIndexSet *tempIndexSet = [NSMutableIndexSet indexSet];
    [tempIndexSet addIndex:0];
    [tempIndexSet addIndex:2];
    [tempIndexSet addIndex:3];
    NSIndexSet *indexSet = [orderedSet indexesOfObjectsWithOptions:0
                                                       passingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
                                                            if ([obj length] == 4) {
                                                                    return YES;
                                                            }
                                                           return NO;
    }];
    XCTAssertEqualObjects(indexSet, tempIndexSet);
    indexSet = [orderedSet indexesOfObjectsWithOptions:NSEnumerationReverse
                                           passingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
                                               if ([obj length] == 4) {
                                                   return YES;
                                               }
                                               return NO;
                                           }];
    XCTAssertEqualObjects(indexSet, tempIndexSet);
}

-(void)testIndexesOfObjectsAtIndexes
{
    NSMutableIndexSet *selectedIndexSet = [NSMutableIndexSet indexSet];
    [selectedIndexSet addIndex:0];
    [selectedIndexSet addIndex:1];
    [selectedIndexSet addIndex:2];
    [selectedIndexSet addIndex:4];
    NSMutableIndexSet *tempIndexSet = [NSMutableIndexSet indexSet];
    [tempIndexSet addIndex:0];
    [tempIndexSet addIndex:2];
    NSIndexSet *indexSet = [orderedSet indexesOfObjectsAtIndexes:selectedIndexSet
                                                         options:0
                                                     passingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
                                                         if ([obj length] == 4) {
                                                             return YES;
                                                         }
                                                         return NO;
                                                     }];
    XCTAssertEqualObjects(indexSet, tempIndexSet);
    indexSet = [orderedSet indexesOfObjectsAtIndexes:selectedIndexSet
                                             options:NSEnumerationReverse
                                         passingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
                                             if ([obj length] == 4) {
                                                 return YES;
                                             }
                                             return NO;
                                         }];
    XCTAssertEqualObjects(indexSet, tempIndexSet);
}

-(void)testSortedArrayUsingComparator
{
    NSArray *sortedArray = [orderedSet sortedArrayUsingComparator: ^(id obj1, id obj2) {
        NSString *string1 = (NSString *)obj1;
        NSString *string2 = (NSString *)obj2;
        return [string1 compare:string2];
    }];
    NSArray *array = [NSArray arrayWithObjects:
                      @"Bleu",
                      @"Noir",
                      @"Orange",
                      @"Rouge",
                      @"Vert",
                      nil];
    XCTAssertEqualObjects(sortedArray, array);
}

-(void)testSortedArrayWithOptions
{
    NSArray *sortedArray = [orderedSet sortedArrayWithOptions:0 usingComparator: ^(id obj1, id obj2) {
        NSString *string1 = (NSString *)obj1;
        NSString *string2 = (NSString *)obj2;
        return [string1 compare:string2];
    }];
    NSArray *array = [NSArray arrayWithObjects:
                      @"Bleu",
                      @"Noir",
                      @"Orange",
                      @"Rouge",
                      @"Vert",
                      nil];
    XCTAssertEqualObjects(sortedArray, array);
}

-(void)testOrderedSet
{
    PANGOrderedSet *tmpOrderedSet = [PANGOrderedSet orderedSet];
    XCTAssertEqual([tmpOrderedSet count], 0);
}

-(void)testOrderedSetWithObjects
{
    PANGOrderedSet *tmpOrderedSet = [PANGOrderedSet orderedSetWithObjects:@"Vert",
                             @"Rouge",
                             @"Bleu",
                             @"Noir",
                             @"Orange",
                             nil];
    XCTAssertEqualObjects(tmpOrderedSet, orderedSet);
}

-(void)testOrderedSetWithObject
{
    PANGOrderedSet *tmpOrderedSet = [PANGOrderedSet orderedSetWithObject:@"Vert"];
    XCTAssertEqual([tmpOrderedSet count], 1);
    XCTAssertEqualObjects([tmpOrderedSet objectAtIndex:0], @"Vert");
}

-(void)testOrderedSetWithObjectsC
{
    id objects[5];
    objects[0] = @"Vert";
    objects[1] = @"Rouge";
    objects[2] = @"Bleu";
    objects[3] = @"Noir";
    objects[4] = @"Orange";
    PANGOrderedSet *tmpOrderedSet = [PANGOrderedSet orderedSetWithObjects:objects
                                                                  count:5];
    XCTAssertEqualObjects(tmpOrderedSet, orderedSet);
    XCTAssertNotEqual(tmpOrderedSet, orderedSet);
    XCTAssertEqual([tmpOrderedSet hash], [orderedSet hash]);
}

-(void)testOrderedSetWithOrderedSet
{
    PANGOrderedSet *tmpOrderedSet = [PANGOrderedSet orderedSetWithOrderedSet:orderedSet];
    XCTAssertNotEqual(tmpOrderedSet, orderedSet);
    XCTAssertEqualObjects(tmpOrderedSet, orderedSet);
    XCTAssertEqual([tmpOrderedSet hash], [orderedSet hash]);
}

-(void)testOrderedSetWithOrderedSetRangeCopy
{
    NSRange range;
    range.location = 1;
    range.length = 3;
    PANGOrderedSet *tmpOrderedSet = [PANGOrderedSet orderedSetWithOrderedSet:orderedSet
                                                                     range:range
                                                                 copyItems:YES];
    PANGOrderedSet *tOrderedSet = [PANGOrderedSet orderedSetWithObjects:
                                  @"Rouge",
                                  @"Bleu",
                                  @"Noir",
                                  nil];
    XCTAssertNotEqual(tmpOrderedSet, tOrderedSet);
    XCTAssertEqualObjects(tmpOrderedSet, tOrderedSet);
    XCTAssertEqual([tmpOrderedSet hash], [tOrderedSet hash]);
    XCTAssertEqualObjects([tmpOrderedSet objectAtIndex:1], [orderedSet objectAtIndex:2]);
}

-(void)testOrderedSetWithArray
{
    NSArray *array = [NSArray arrayWithObjects:
                      @"Vert",
                      @"Rouge",
                      @"Bleu",
                      @"Noir",
                      @"Orange",
                      nil];
    PANGOrderedSet *tmpOrderedSet = [PANGOrderedSet orderedSetWithArray:array];
    XCTAssertEqualObjects(tmpOrderedSet, orderedSet);
    XCTAssertNotEqual(tmpOrderedSet, orderedSet);
    XCTAssertEqual([tmpOrderedSet hash], [orderedSet hash]);
}

-(void)testOrderedSetWithArrayRange
{
    NSArray *array = [NSArray arrayWithObjects:
                      @"Rouge",
                      @"Bleu",
                      @"Noir",
                      nil];
    PANGOrderedSet *tmpOrderedSet = [PANGOrderedSet orderedSetWithArray:array];
    array = [NSArray arrayWithObjects:
             @"Vert",
             @"Rouge",
             @"Bleu",
             @"Noir",
             @"Orange",
             nil];
    NSRange range;
    range.location = 1;
    range.length = 3;
    PANGOrderedSet *otherOrderedSet = [PANGOrderedSet orderedSetWithArray:array
                                                                  range:range
                                                              copyItems:YES];
    XCTAssertEqualObjects(tmpOrderedSet, otherOrderedSet);
    XCTAssertNotEqual(tmpOrderedSet, otherOrderedSet);
    XCTAssertEqual([tmpOrderedSet hash], [otherOrderedSet hash]);
}

-(void)testOrderedSetWithSet
{
    NSSet *set = [NSSet setWithObjects:
                  @"Vert",
                  @"Rouge",
                  @"Bleu",
                  @"Noir",
                  @"Orange",
                  nil];
    PANGOrderedSet *tmpOrderedSet = [PANGOrderedSet orderedSetWithSet:set];
    XCTAssertEqualObjects([tmpOrderedSet set], [orderedSet set]);
    XCTAssertNotEqual(tmpOrderedSet, orderedSet);
    XCTAssertEqual([[tmpOrderedSet set] hash], [[orderedSet set] hash]);
}

-(void)testOrderedSetWithSetCopy
{
    NSSet *set = [NSSet setWithObjects:
                  @"Vert",
                  @"Rouge",
                  @"Bleu",
                  @"Noir",
                  @"Orange",
                  nil];
    PANGOrderedSet *tmpOrderedSet = [PANGOrderedSet orderedSetWithSet:set
                                                          copyItems:YES];
    XCTAssertEqualObjects([tmpOrderedSet set], [orderedSet set]);
    XCTAssertNotEqual(tmpOrderedSet, orderedSet);
    XCTAssertEqual([[tmpOrderedSet set] hash], [[orderedSet set] hash]);
}

-(void)initWithObject
{
    PANGOrderedSet *tmpOrderedSet = [[PANGOrderedSet alloc] initWithObject:@"Vert"];
    XCTAssertEqual([tmpOrderedSet count], 1);
    XCTAssertEqualObjects([tmpOrderedSet objectAtIndex:0], @"Vert");
}

-(void)testInitWithObjects
{
    PANGOrderedSet *tmpOrderedSet = [[PANGOrderedSet alloc] initWithObjects:
                                    @"Vert",
                                    @"Rouge",
                                    @"Bleu",
                                    @"Noir",
                                    @"Orange",
                                    nil];
    XCTAssertEqualObjects(tmpOrderedSet, orderedSet);
}

-(void)testInitWithSet
{
    NSSet *set = [NSSet setWithObjects:
                  @"Vert",
                  @"Rouge",
                  @"Bleu",
                  @"Noir",
                  @"Orange",
                  nil];
    PANGOrderedSet *tmpOrderedSet = [[PANGOrderedSet alloc] initWithSet:set];
    XCTAssertEqualObjects([tmpOrderedSet set], [orderedSet set]);
    XCTAssertNotEqual(tmpOrderedSet, orderedSet);
    XCTAssertEqual([[tmpOrderedSet set] hash], [[orderedSet set] hash]);
}

-(void)testInitWithSetCopy
{
    NSSet *set = [NSSet setWithObjects:
                  @"Vert",
                  @"Rouge",
                  @"Bleu",
                  @"Noir",
                  @"Orange",
                  nil];
    PANGOrderedSet *tmpOrderedSet = [[PANGOrderedSet alloc] initWithSet:set
                                                            copyItems:YES];
    XCTAssertEqualObjects([tmpOrderedSet set], [orderedSet set]);
    XCTAssertNotEqual(tmpOrderedSet, orderedSet);
    XCTAssertEqual([[tmpOrderedSet set] hash], [[orderedSet set] hash]);
}

-(void)testInitWithOrderedSet
{
    PANGOrderedSet *tmpOrderedSet = [[PANGOrderedSet alloc] initWithOrderedSet:orderedSet];
    XCTAssertNotEqual(tmpOrderedSet, orderedSet);
    XCTAssertEqualObjects(tmpOrderedSet, orderedSet);
    XCTAssertEqual([tmpOrderedSet hash], [orderedSet hash]);
}

-(void)testInitWithOrderedSetCopy
{
    PANGOrderedSet *tmpOrderedSet = [[PANGOrderedSet alloc] initWithOrderedSet:orderedSet
                                                                   copyItems:YES];
    XCTAssertNotEqual(tmpOrderedSet, orderedSet);
    XCTAssertEqualObjects(tmpOrderedSet, orderedSet);
    XCTAssertEqual([tmpOrderedSet hash], [orderedSet hash]);
}

-(void)testInitWithArrayRange
{
    NSArray *array = [NSArray arrayWithObjects:
                      @"Rouge",
                      @"Bleu",
                      @"Noir",
                      nil];
    PANGOrderedSet *tmpOrderedSet = [PANGOrderedSet orderedSetWithArray:array];
    array = [NSArray arrayWithObjects:
             @"Vert",
             @"Rouge",
             @"Bleu",
             @"Noir",
             @"Orange",
             nil];
    NSRange range;
    range.location = 1;
    range.length = 3;
    PANGOrderedSet *otherOrderedSet = [[PANGOrderedSet alloc] initWithArray:array
                                                                    range:range
                                                                copyItems:YES];
    XCTAssertEqualObjects(tmpOrderedSet, otherOrderedSet);
    XCTAssertNotEqual(tmpOrderedSet, otherOrderedSet);
    XCTAssertEqual([tmpOrderedSet hash], [otherOrderedSet hash]);
}

-(void)testInitWithOrderedSetRangeCopy
{
    NSRange range;
    range.location = 1;
    range.length = 3;
    PANGOrderedSet *tmpOrderedSet = [[PANGOrderedSet alloc] initWithOrderedSet:orderedSet
                                                                       range:range
                                                                   copyItems:YES];
    PANGOrderedSet *tOrderedSet = [PANGOrderedSet orderedSetWithObjects:
                                  @"Rouge",
                                  @"Bleu",
                                  @"Noir",
                                  nil];
    XCTAssertNotEqual(tmpOrderedSet, tOrderedSet);
    XCTAssertEqualObjects(tmpOrderedSet, tOrderedSet);
    XCTAssertEqual([tmpOrderedSet hash], [tOrderedSet hash]);
    XCTAssertEqualObjects([tmpOrderedSet objectAtIndex:1], [orderedSet objectAtIndex:2]);
}

-(void)testInitWithArrayCopy
{
    NSArray *array = [NSArray arrayWithObjects:
                      @"Vert",
                      @"Rouge",
                      @"Bleu",
                      @"Noir",
                      @"Orange",
                      nil];
    PANGOrderedSet *tmpOrderedSet = [[PANGOrderedSet alloc] initWithArray:array
                                                              copyItems:YES];
    XCTAssertEqualObjects(tmpOrderedSet, orderedSet);
    XCTAssertNotEqual(tmpOrderedSet, orderedSet);
    XCTAssertEqual([tmpOrderedSet hash], [orderedSet hash]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
