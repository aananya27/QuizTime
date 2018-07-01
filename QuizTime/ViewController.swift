//
//  ViewController.swift
//  QuizTime
//
//  Created by Aananya on 25/06/18.
//  Copyright © 2018 Aananya. All rights reserved.
//

import UIKit
//import Firebase

//import FirebaseStorage
import FirebaseAnalytics
import FirebaseDatabase


class ViewController: UIViewController {
    //to create  a connection to realtime databse
    let rootRef = Database.database().reference()
    //now to connect to the firebase database:
    ////////////////////////
    
    //Static Questions and answers for now
    let questions = ["2+7?","1+2?","20+20?"]
    let answers = [["9","27","55"],["3","12","15"],["40","60","99"]]
    
    //variables
    var currentQues = 0
    var correctAnsPlace:UInt32 = 0 //tracks where the right answer is
    var score = 0
    
    
    //MARK: Label to show question
    @IBOutlet weak var lbl: UILabel!
    //MARK: Buttons for answers
    @IBAction func action(_ sender: Any)
    {
        if ((sender as AnyObject).tag == Int(correctAnsPlace)){
            print("Correct!")
            score += 1
        }
        else{
            print("Wrong!!!!!!!")
            
        }
        
        if (currentQues != questions.count){
            showNewQuestion()
        }
        else{
            performSegue(withIdentifier: "ScoreBoard", sender: self)
        }
    }
    
    
    // touching this result button should send the score to fb..which send it back into the app.
    @IBAction func resultDidTouch(_ sender: Any) {
        //if the result button is tapped.
    }
    
    //result label -where it will show the result-throug fB^
    @IBOutlet weak var showResult: UILabel!
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        //to show questions when view appears.
        showNewQuestion()
        super.viewDidAppear(animated)
        
        //firebase connect
        let resultRef = rootRef.child("showResult")
        //showResult being the key after the root, in the FB dB.
        
        resultRef.observe(.value){
            (snap: DataSnapshot) in
            self.showResult.text = (snap.value as AnyObject).description
        }
    }
  
    //function to randomly sow qns and ans butons
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

