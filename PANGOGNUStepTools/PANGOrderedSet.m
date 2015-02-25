//
//  PANGOrderedSet.m
//  PANGOrderedSetForGnuStep
//
//  Created by Jaufré Thumerel on 05/02/2015.
//  GNU LESSER GENERAL PUBLIC LICENSE
//  Version 3, 29 June 2007

#import "PANGOrderedSet.h"
#import "PANGMutableOrderedSet.h"

@implementation PANGOrderedSet

- (NSUInteger)count
{
    return [array count];
}

- (id)objectAtIndex:(NSUInteger)idx
{
    return [array objectAtIndex:idx];
}

- (NSUInteger)indexOfObject:(id)object
{
    return [array indexOfObject:object];
}

- (id)init
{
    self = [super init];
    if (self) {
        array = [NSArray array];
        set = [NSSet set];
    }
    return self;
}

- (id)initWithObjects:(const id [])objects count:(NSUInteger)cnt
{
    self = [super init];
    if (self) {
        NSArray *tempArray = [[NSArray alloc] initWithObjects:objects count:cnt];
        NSMutableSet *mSet = [NSMutableSet set];
        NSMutableArray *mArray = [NSMutableArray array];
        for (int i = 0; i < [tempArray count]; i++) {
                id obj = [tempArray objectAtIndex:i];
            if (!obj) {
                [NSException raise: NSInvalidArgumentException
                            format: @"Tried to add nil to set"];
            }
            if (![mSet containsObject:obj]) {
                [mSet addObject:obj];
                [mArray addObject:obj];
            }
        }
        array = [NSArray arrayWithArray:mArray];
        set = [NSSet setWithSet:mSet];
    }
    return self;
}

- (id)initWithArray:(NSArray *)nArray
{
    self = [super init];
    if (self) {
        NSMutableSet *mSet = [NSMutableSet set];
        NSMutableArray *mArray = [NSMutableArray array];
        for (int i = 0; i < [nArray count]; i++) {
            id obj = [nArray objectAtIndex:i];
            if (!obj) {
                [NSException raise: NSInvalidArgumentException
                            format: @"Tried to add nil to set"];
            }
            if (![mSet containsObject:obj]) {
                [mSet addObject:obj];
                [mArray addObject:obj];
            }
        }
        array = [NSArray arrayWithArray:mArray];
        set = [NSSet setWithSet:mSet];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        array = [aDecoder decodeObjectForKey:@"array"];
        if (![array isKindOfClass:[NSArray class]]) {
            return nil;
        }
        set = [NSSet setWithArray:array];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:array forKey:@"array"];
}

- (id)copyWithZone:(NSZone *)zone
{
    PANGOrderedSet *orderedSet = [[[self class] allocWithZone:zone] initWithArray:[self array]];
    return orderedSet;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    PANGMutableOrderedSet *orderedSet = [[PANGMutableOrderedSet allocWithZone:zone] initWithArray:[self array]];
    return orderedSet;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id __unsafe_unretained[])stackbuf
                                    count:(NSUInteger)len
{
    return [array countByEnumeratingWithState:state
                                      objects:stackbuf
                                        count:len];
}

- (void)getObjects:(id __unsafe_unretained [])objects range:(NSRange)range
{
    [array getObjects:objects range:range];
}

- (NSArray *)objectsAtIndexes:(NSIndexSet *)indexes
{
    return [array objectsAtIndexes:indexes];
}

- (id) firstObject
{
    if ([self count] != 0) {
        return [array objectAtIndex:0];
    }
    return nil;
}

- (id) lastObject
{
    return [array lastObject];
}

- (BOOL)isEqualToOrderedSet:(PANGOrderedSet *)other
{
    return [set isEqualToSet:[other set]] && [array isEqualToArray:[other array]];
}

- (BOOL)isEqual:(id)object
{
    if([object isKindOfClass:[self class]]){
        PANGOrderedSet *otherOrderedSet = (PANGOrderedSet *)object;
        return [self isEqualToOrderedSet:otherOrderedSet];
    }
    return NO;
}

- (NSUInteger)hash
{
    return [array hash];
}

-(BOOL)containsObject:(id)object
{
    return [set containsObject:object];
}

- (BOOL)intersectsOrderedSet:(PANGOrderedSet *)other
{
    return [set intersectsSet:[other set]];
}

- (BOOL)intersectsSet:(NSSet *)tmpSet
{
    return [set intersectsSet:tmpSet];
}

- (BOOL)isSubsetOfOrderedSet:(PANGOrderedSet *)other
{
    return [set isSubsetOfSet:[other set]];
}

- (BOOL)isSubsetOfSet:(NSSet *)tmpSet
{
    return [set isSubsetOfSet:tmpSet];
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx
{
    return [array objectAtIndexedSubscript:idx];
}

- (NSEnumerator *)objectEnumerator
{
    return [array objectEnumerator];
}

- (NSEnumerator *)reverseObjectEnumerator
{
    return [array reverseObjectEnumerator];
}

- (PANGOrderedSet *) reversedOrderedSet
{
    NSArray * tempArray = [self array];
    NSMutableArray *mArray = [NSMutableArray array];
    for (int i = (int)[tempArray count] - 1; i >= 0; i--)
    {
        [mArray addObject:[tempArray objectAtIndex:i]];
    }
    return [[[self class] alloc] initWithArray:mArray];
}

- (NSArray *) array
{
    return (NSArray *) array;
}

- (NSSet *) set
{
    return (NSSet *) set;
}

- (void)enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block
{
    [array enumerateObjectsUsingBlock:block];
}

- (void)enumerateObjectsWithOptions:(NSEnumerationOptions)opts
                         usingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block
{
    [array enumerateObjectsWithOptions:opts
                            usingBlock:block];
}

- (void)enumerateObjectsAtIndexes:(NSIndexSet *)s
                          options:(NSEnumerationOptions)opts
                       usingBlock:(void (^)(id obj,NSUInteger idx, BOOL *stop))block
{
    [array enumerateObjectsAtIndexes:s
                             options:opts
                          usingBlock:block];
}

- (NSUInteger)indexOfObjectPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    return [array indexOfObjectPassingTest:predicate];
}

- (NSUInteger)indexOfObjectWithOptions:(NSEnumerationOptions)opts
                           passingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    return [array indexOfObjectWithOptions:opts
                               passingTest:predicate];
}

- (NSUInteger)indexOfObjectAtIndexes:(NSIndexSet *)s
                             options:(NSEnumerationOptions)opts
                         passingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    return [array indexOfObjectAtIndexes:s
                                 options:opts
                             passingTest:predicate];
}

- (NSIndexSet *)indexesOfObjectsPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    return [array indexesOfObjectsPassingTest:predicate];
}

- (NSIndexSet *)indexesOfObjectsWithOptions:(NSEnumerationOptions)opts
                                passingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    return [array indexesOfObjectsWithOptions:opts
                                  passingTest:predicate];
}

- (NSIndexSet *)indexesOfObjectsAtIndexes:(NSIndexSet *)s
                                  options:(NSEnumerationOptions)opts
                              passingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    return [array indexesOfObjectsAtIndexes:s
                                    options:opts
                                passingTest:predicate];
}

- (NSUInteger)indexOfObject:(id)object
              inSortedRange:(NSRange)range
                    options:(NSBinarySearchingOptions)opts
            usingComparator:(NSComparator)cmp
{
    return [array indexOfObject:object
                  inSortedRange:range
                        options:opts
                usingComparator:cmp];
}

- (NSArray *)sortedArrayUsingComparator:(NSComparator)cmptr
{
    return [array sortedArrayUsingComparator:cmptr];
}

- (NSArray *)sortedArrayWithOptions:(NSSortOptions)opts
                    usingComparator:(NSComparator)cmptr
{
    return [array sortedArrayWithOptions:opts
                         usingComparator:cmptr];
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"NSOrdererdSet : %@", [array description]];
}

- (NSString *)descriptionWithLocale:(id)locale
{
    return [NSString stringWithFormat:@"NSOrdererdSet : %@", [array descriptionWithLocale:locale]];
}

- (NSString *)descriptionWithLocale:(id)locale
                             indent:(NSUInteger)level
{
    return [NSString stringWithFormat:@"NSOrdererdSet : %@", [array descriptionWithLocale:locale
                                                                                   indent:level]];
}

+ (id)orderedSet
{
    return [[self alloc] init];
}

+ (id)orderedSetWithObject:(id)object
{
    return [[self alloc] initWithObject:object];
}

+ (id)orderedSetWithObjects:(const id [])objects
                                count:(NSUInteger)cnt
{
    return [[self alloc] initWithObjects:objects
                                   count:cnt];
}

+ (id)orderedSetWithObjects:(id)firstObj, ... NS_REQUIRES_NIL_TERMINATION
{
    NSMutableArray *tempArray = [NSMutableArray array];
    va_list objs;
    va_start(objs, firstObj);
    for (id obj = firstObj; obj != nil; obj = va_arg(objs, id))
    {
        [tempArray addObject:obj];
    }
    va_end(objs);
    return [self orderedSetWithArray:tempArray];
}

+ (id)orderedSetWithOrderedSet:(PANGOrderedSet *)nSet
{
    return [[PANGOrderedSet alloc] initWithOrderedSet:nSet];
}

+ (id)orderedSetWithOrderedSet:(PANGOrderedSet *)nSet range:(NSRange)range copyItems:(BOOL)flag
{
    return [[PANGOrderedSet alloc] initWithOrderedSet:nSet
                                      range:range
                                  copyItems:flag];
}

+ (id)orderedSetWithArray:(NSArray *)nArray
{
    return [[self alloc] initWithArray:nArray];
}

+ (id)orderedSetWithArray:(NSArray *)nArray
                    range:(NSRange)range
                copyItems:(BOOL)flag
{
    return [[self alloc] initWithArray:nArray
                                 range:range
                             copyItems:flag];
}

+ (id)orderedSetWithSet:(NSSet *)nSet
{
    return [[self alloc] initWithSet:nSet];
}

+ (id)orderedSetWithSet:(NSSet *)nSet
              copyItems:(BOOL)flag
{
    return [[self alloc] initWithSet:nSet
                           copyItems:flag];
}

- (id)initWithObject:(id)object
{
    if (!object) {
        [NSException raise: NSInvalidArgumentException
                    format: @"Tried to add nil to set"];
    }
    const __unsafe_unretained id *objects = &object;
    return [self initWithObjects:objects
                           count:1];
}

- (id)initWithObjects:(id)firstObj, ... NS_REQUIRES_NIL_TERMINATION
{
    NSMutableArray *tempArray = [NSMutableArray array];
    va_list objs;
    va_start(objs, firstObj);
    for (id obj = firstObj; obj != nil; obj = va_arg(objs, id))
    {
        [tempArray addObject:obj];
    }
    va_end(objs);
    return [self initWithArray:tempArray];
}

- (id)initWithOrderedSet:(PANGOrderedSet *)nSet
{
    return [self initWithArray:[nSet array]];
}

- (id)initWithOrderedSet:(PANGOrderedSet *)nSet
               copyItems:(BOOL)flag
{
    NSArray *tArray = [nSet array];
    if (flag) {
        tArray = [[NSArray alloc] initWithArray:tArray copyItems:flag];
    }
    return [self initWithArray:tArray];
}

- (id)initWithOrderedSet:(PANGOrderedSet *)nSet
                   range:(NSRange)range
               copyItems:(BOOL)flag
{
    NSArray *tArray = [nSet array];
    tArray = [[NSArray alloc] initWithArray:[tArray subarrayWithRange:range]
                                  copyItems:flag];
    return [self initWithArray:tArray];
}

- (id)initWithArray:(NSArray *)nArray
          copyItems:(BOOL)flag
{
    NSArray *tArray = nArray;
    if (flag) {
        tArray = [[NSArray alloc] initWithArray:tArray copyItems:flag];
    }
    return [self initWithArray:tArray];
}

- (id)initWithArray:(NSArray *)nArray
              range:(NSRange)range
          copyItems:(BOOL)flag;
{
    NSArray *tArray = nArray;
    tArray = [[NSArray alloc] initWithArray:[tArray subarrayWithRange:range]
                                  copyItems:flag];
    return [self initWithArray:tArray];
}

- (id)initWithSet:(NSSet *)nSet
{
    return [self initWithArray:[nSet allObjects]];}

- (id)initWithSet:(NSSet *)nSet copyItems:(BOOL)flag
{
    NSArray *tArray = [nSet allObjects];
    if (flag) {
        tArray = [[NSArray alloc] initWithArray:tArray copyItems:flag];
    }
    return [self initWithArray:tArray];}

@end
