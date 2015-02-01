//
//  KeyboardViewController.swift
//  keyboard
//
//  Created by Amornchai Kanokpullwad on 7/2/14.
//  Copyright (c) 2014 stm. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var operationButtons: [UIButton]!
    
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var equalButton: UIButton!
    @IBOutlet private var clearButton: UIButton!
    
    private let calculatorBrain = CalculatorBrain()
    private var userIsInTheMiddleOfTypingANumber: Bool = false
    private var thePointHasBeenSet: Bool = false
    private var layout: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Perform custom UI setup here
        layout = NSBundle.mainBundle().loadNibNamed("KeyboardView" ,owner:self, options:nil)[0] as? UIView
        view.addSubview(layout!)
        
        self.nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout!.frame = self.view.bounds
    }

    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput) {
        // The app has just changed the document's contents, the document context has been updated.
    
        var textColor: UIColor
        var proxy = self.textDocumentProxy as UITextDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }
    
    // MARK: Action
    
    @IBAction func donePressed(sender: AnyObject) {
        operationPressed(equalButton)
        (textDocumentProxy as UITextDocumentProxy).insertText(textLabel.text! + " ")
    }
    
    @IBAction func digitPressed(sender: UIButton) {
        let digit = sender.titleLabel!.text
        if digit == "." {
            if thePointHasBeenSet {
                return
            } else {
                thePointHasBeenSet = true
            }
        }
        
        if userIsInTheMiddleOfTypingANumber {
            if textLabel.text == "0" {
                textLabel.text = digit
            } else {
                textLabel.text = textLabel.text!.stringByAppendingString(digit!)
            }
        } else {
            textLabel.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
        
        clearButton.setTitle("C", forState: .Normal)
    }
    
    @IBAction func backspacePressed(sender: AnyObject) {
        (textDocumentProxy as UITextDocumentProxy).deleteBackward();
    }
    
    @IBAction func operationPressed(sender: UIButton) {
        // set state
        if contains(operationButtons, sender) {
            for button in operationButtons {
                button.selected = false
            }
            sender.selected = true
        }
        
        let operand = sender.titleLabel!.text
        
        if operand == "AC" || operand == "=" {
            for butto in operationButtons {
                butto.selected = false
            }
        }
        
        if userIsInTheMiddleOfTypingANumber {
            let curDisplayValue: Double = (textLabel.text! as NSString).doubleValue
            calculatorBrain.operand = curDisplayValue
            
            if "±" != operand {
                userIsInTheMiddleOfTypingANumber = false
            }
        }
        
        let result = calculatorBrain.performOperation(operand)
        textLabel.text = NSString(format: "%g", result)
        
        let displayPointRange = (textLabel.text! as NSString).rangeOfString(".")
        thePointHasBeenSet = displayPointRange.length > 0
        
        if operand == "C" {
            sender.setTitle("AC", forState: .Normal)
        }
        
    }
    
}
