//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Diva Harsoor on 7/21/16.
//  Copyright © 2016 Mobile Makers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var rowZeroColZeroLabel: UILabel!
    @IBOutlet weak var rowZeroColOneLabel: UILabel!
    @IBOutlet weak var rowZeroColTwoLabel: UILabel!
    @IBOutlet weak var rowOneColZeroLabel: UILabel!
    @IBOutlet weak var rowOneColOneLabel: UILabel!
    @IBOutlet weak var rowOneColTwoLabel: UILabel!
    @IBOutlet weak var rowTwoColZeroLabel: UILabel!
    @IBOutlet weak var rowTwoColOneLabel: UILabel!
    @IBOutlet weak var rowTwoColTwoLabel: UILabel!
    
    var labelArray : [UILabel]!
    var hasX = true //eventually ternary
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelArray = [rowZeroColZeroLabel, rowZeroColOneLabel, rowZeroColTwoLabel, rowOneColZeroLabel, rowOneColOneLabel, rowOneColTwoLabel, rowTwoColZeroLabel, rowTwoColOneLabel, rowTwoColTwoLabel]
    }

    @IBAction func onTappedBoard(sender: AnyObject) {
        for label in labelArray {
            if label.text == "" {
                if CGRectContainsPoint(label.frame, sender.locationInView(backgroundView)) {
                    label.text = hasX ? "X" : "O"
                    label.font = UIFont(name: "Chalkduster", size: 48)
                    label.textAlignment = NSTextAlignment.Center
                    label.textColor = hasX ? UIColor.redColor() : UIColor.blueColor()
                    hasX = !hasX
                }
            }
        }
        endChecker()
    }
    
    func allFilled() -> Bool {
        for label in labelArray {
            if label.text == "" {
                return false
            }
        }
        return true
    }
    
    func endChecker() {
            if labelArray[0].text != "" && labelArray[0].text == labelArray[1].text && labelArray[1].text ==  labelArray[2].text ||
            labelArray[3].text != "" && labelArray[3].text == labelArray[4].text && labelArray[4].text == labelArray[5].text ||
            labelArray[6].text != "" && labelArray[6].text == labelArray[7].text && labelArray[7].text == labelArray[8].text ||
            labelArray[0].text != "" && labelArray[0].text == labelArray[3].text && labelArray[3].text == labelArray[6].text ||
            labelArray[1].text != "" && labelArray[1].text == labelArray[4].text && labelArray[4].text == labelArray[7].text ||
            labelArray[2].text != "" && labelArray[2].text == labelArray[5].text && labelArray[5].text == labelArray[8].text ||
            labelArray[0].text != "" && labelArray[0].text == labelArray[4].text && labelArray[4].text == labelArray[8].text ||
            labelArray[2].text != "" && labelArray[2].text == labelArray[4].text && labelArray[4].text == labelArray[6].text {
            gameEndAlert(false)
        }
            else if allFilled(){
            gameEndAlert(true)
        }
    }
    
    func reNew(){
        UIApplication.sharedApplication().keyWindow?.rootViewController = storyboard!.instantiateViewControllerWithIdentifier("Root_View")
    }
    
    func gameEndAlert(catsGame: Bool) {
        var winner = "", controllerTitle = "", message = ""
        if hasX {
            winner = "O"
        }
        else {
            winner = "X"
        }
        if catsGame == true {
            controllerTitle = "Cat's Game"
            message = "It's a tie!"
        }
        else {
            controllerTitle = "Game Over"
            message = winner + " wins!"
        }
        
        let alert = UIAlertController(title: controllerTitle, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "New Game", style: .Destructive, handler: { action in
            self.reNew()
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}