//
//  ViewController.swift
//  BullsEye
//
//  Created by Eric Mentele on 11/28/14.
//  Copyright (c) 2014 Eric Mentele. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    //The below variables and constants are called instance variables because the belong to a class and exist as long as it does.  Local variables are inside of methods and only exist until it finishs running. Once they are used they self destruct.
    var currentValue = 0
    
    var targetValue = 0
    
    var score = 0
    
    var round = 0

    @IBOutlet weak var targetLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    //A variable that connects the slider on the story board with the ViewController class.
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var roundLabel: UILabel!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //receiver.methodName(parameters) = method syntax
        
        startNewRound()
    }//viewDidLoad
    
    func startNewRound()
    {
        currentValue = 50
        //lroundf(slider.value) This method rounds to the nearest whole number of slider.value
        //slider refers to the IBOutlet variable above.
        
        targetValue = 1 + Int(arc4random_uniform(100))
        //arc4random generates a number from 0-99.
        
        //these two methods change the initial values to the desired values from the other parts of the app.
        
        slider.value = Float(currentValue)
        //UISlider returns a float so the conversion must be explicit.
        
        round++
        
        updateLabels()
    }//startNewRound()
    
    func updateLabels()
    {
        targetLabel.text = String(targetValue)
        //targetLabel.text = "\(targetValue)"
        
        scoreLabel.text = String(score)
        
        roundLabel.text = String(round)
    }//updateLabels
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }//memory

    @IBAction func showAlert(sender: AnyObject)
    {
        //Below are local variables. They self destruct after the method is run.
        let difference = abs(targetValue - currentValue)
        println("\(difference)")
        
        var points = 100 - difference
        println("\(points)")
        
        var title: String
        
        if difference == 0
        {
            title = "Bull's Eye!"
            
            score += 100
        }
            
        else if difference < 5
        {
            title = "So close!"
            
            if difference == 1
            {
                score += 50
            }
            
        }
        else if difference < 10
        {
            title = "Good shot!"
        }
        else
        {
            title = "Meh.."
        }//if difference
        
        score += points
        
        let message = "You scored \(points) points!"
                
            + "\n The current value of the slider is: \(currentValue)"
        
            + "\n The target value of the slider is: \(targetValue)"
        
            + "\n The difference is: \(difference)"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        //creates an alert popup for when the "Hit Me" button is pressed.
        
        let action = UIAlertAction(title: "OK", style: .Default, handler:
            {
                action in
                self.startNewRound()
                self.updateLabels()
            }/*handler*/)
        //creates a button on the alert popup that dismisses it. The block of code inside handler is a closure. It runs when the alert is dismissed.  .self refers to the ViewController and is unecessary except inside closures.
        
        alert.addAction(action)
        //implements button to dismiss notification popup.
        
        presentViewController(alert, animated: true, completion: nil)
    }//showAlert action

    @IBAction func sliderMoved(slider: UISlider)//Takes UISlider in as slider
    {
        currentValue = lroundf(slider.value) //lroundf rounds to the nearest whole number.
        
        println("The value of the slider is now: \(slider.value)")//prints the value of UISlider as slider.
    }//slider moved
    
    @IBAction func startOver(sender: AnyObject)
    {
        score = 0
        round = 0
        startNewRound()
    }//startOver
    
}//View Controller

