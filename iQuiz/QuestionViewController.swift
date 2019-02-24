//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Adele on 2/21/19.
//  Copyright © 2019 edu.washington. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    
    @IBOutlet weak var QuestionText: UILabel!
    @IBOutlet var QuestionChoices: [UILabel]!
    @IBOutlet weak var AnswerSelectorSegment: UISegmentedControl!
    @IBOutlet weak var SubmitQuestionChoiceButton: UIButton!
    
    var quizDetails : QuizDetails? = nil
    var currQuestionData : QuestionDetails? = nil
    var context : Context? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Update UI elements
        currQuestionData = quizDetails!.questions[context!.currQuestion]
        for i in 0...3 { QuestionChoices[i].text = currQuestionData!.answers[i] }
        QuestionText.text = currQuestionData?.text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "QuestionToAnswerSegue":
                let answerVC = segue.destination as! AnswerViewController
                let currSelectedAnswer = AnswerSelectorSegment.selectedSegmentIndex
                answerVC.lastAnswer = currSelectedAnswer
                
                // Check if answer is correct
                var newNumCorrect = context!.numCorrect
                var newNumWrong = context!.numWrong
                if currQuestionData?.answer == String(currSelectedAnswer + 1) {
                   newNumCorrect = newNumCorrect + 1
                } else {
                   newNumWrong = newNumWrong + 1
                }
                
                answerVC.context = Context(currQuestion: context!.currQuestion, currSubject: context!.currSubject, numCorrect: newNumCorrect, numWrong: newNumWrong)
                answerVC.quizDetails = quizDetails
            default: break
        }
    }
}

