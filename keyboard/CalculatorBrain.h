//
//  CalculatorBrain.h
//  keyboard
//
//  Created by Amornchai Kanokpullwad on 7/2/14.
//  Copyright (c) 2014 stm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

@property (nonatomic) double operand;
@property (nonatomic) double waitingOperand;
@property (nonatomic, strong) NSString *waitingOperation;

- (double)performOperation:(NSString *)operation;
- (void)performWaitingOperation;

@end