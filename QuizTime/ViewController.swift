//
//  ViewController.swift
//  QuizTime
//
//  Created by Aananya on 25/06/18.
//  Copyright © 2018 Aananya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Static Questions and answers
    let questions = ["2+7?","1+2?","20+20?"]
    let answers = [["9","27","55"],["3","12","15"],["40","60","99"]]
    
    //variables
    var currentQues = 0
    var correctAnsPlace:UInt32 = 0 //tracks where the right answer is
    var score = 0
    
    
    //MARK: Labels
    @IBOutlet weak var lbl: UILabel!
    
    @IBOutlet weak var Result: UILabel!
    
    //MARK: ScoreLabel
  
    
    //MARK: Buttons
    @IBAction func action(_ sender: Any)
    {
        if ((sender as AnyObject).tag == Int(correctAnsPlace)){
            Result.text = "Correct!"
            score += 1
        }
        else{
            Result.text = "Wrong!!!!!!!"
            
        }
        
        if (currentQues != questions.count){
            showNewQuestion()
        }
        else{
            performSegue(withIdentifier: "ScoreBoard", sender: self)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showNewQuestion()
    //    showScore
    }
  //  func showScore() {
        // scorelbl.text = score
  //  }
    func showNewQuestion()
    {
        lbl.text = questions[currentQues]
        correctAnsPlace = arc4random_uniform(3)+1
        
        var button:UIButton = UIButton()
        var x = 1
        
        for i in 1...3{
            button = view.viewWithTag(i) as! UIButton
            
            if (i==Int(correctAnsPlace)){
                button.setTitle(answers[currentQues][0], for: .normal)
            }
            else {
                button.setTitle(answers[currentQues][x], for: .normal)
                x = 2
            }
            
        }
        currentQues += 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

