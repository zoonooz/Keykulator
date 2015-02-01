//
//  CalculatorBrain.m
//  keyboard
//
//  Created by Amornchai Kanokpullwad on 7/2/14.
//  Copyright (c) 2014 stm. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@end

@implementation CalculatorBrain

@synthesize operand;
@synthesize waitingOperand;
@synthesize waitingOperation;

- (void)performWaitingOperation
{
    if ([@"+" isEqualToString:waitingOperation]) {
        operand = waitingOperand + operand;
    } else if ([@"-" isEqualToString:waitingOperation]) {
        operand = waitingOperand - operand;
    } else if ([@"÷" isEqualToString:waitingOperation]) {
        if (operand) {
            operand = waitingOperand / operand;
        } else {
            //warningOperation = @"Can't divide by zero";
        }
    } else if ([@"×" isEqualToString:waitingOperation]) {
        operand = waitingOperand * operand;
    } else if ([@"%" isEqualToString:waitingOperation]) {
        operand = (waitingOperand / operand) * 100;
    }
}

- (double)performOperation:(NSString *)operation
{
    if ([@"±" isEqualToString:operation]) {
        if (operand) {
            operand = -1 * operand;
        }
    } else if ([@"C" isEqualToString:operation]) {
        operand = 0;
    } else if ([@"AC" isEqualToString:operation]) {
        operand = 0;
        waitingOperand = 0;
        waitingOperation = nil;
    } else {
        [self performWaitingOperation];
        self.waitingOperation = operation;
        waitingOperand = operand;
    }
    
    return operand;
}

@end