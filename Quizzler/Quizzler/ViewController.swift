//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionbBank()
    var pickedAnswer: Bool = false
    var questionNumber = 0
    var score = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextQuestion()
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1{
            pickedAnswer = true
        }else if sender.tag == 2{
            pickedAnswer = false
        }
        checkAnswer()
        questionNumber += 1
        
        nextQuestion()
  
    }
    
    
    func updateUI() {
        scoreLabel.text = "分数： \(score)"
        progressLabel.text = "\(questionNumber + 1) / 13"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber)
      
    }
    

    func nextQuestion() {
        if questionNumber <= 12 {
            questionLabel.text = allQuestions.list[questionNumber].questionText
            updateUI()
        }else{
            let alert = UIAlertController(title: "了不起", message: "你已经完成了所有的题目", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "重新开始", style: .default, handler: {(alertAction) in self.startOver()})
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    func checkAnswer() {
        let correctAnswer = allQuestions.list[0].answer
        if correctAnswer == pickedAnswer{
            print("回答正确")
            score += 1
        }else{
            print("回答错误")
            
        }
    }
    
    
    func startOver() {
       questionNumber = 0
        nextQuestion()
        score = 0
    }
    

    
}
