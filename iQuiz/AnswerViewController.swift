//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Adele on 2/21/19.
//  Copyright © 2019 edu.washington. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    
    @IBOutlet var AnswerTextLabels: [UILabel]!
    @IBOutlet weak var QuestionTextLabel: UILabel!
    
    var lastAnswer : Int = -1
    var context : Context? = nil
    var currQuestionData : QuestionDetails? = nil
    var quizDetails : QuizDetails? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currQuestionData = quizDetails!.questions[context!.currQuestion]
        QuestionTextLabel.text = currQuestionData!.text
        
        for i in 0...3 {
            let currLabel = AnswerTextLabels[i]
            currLabel.text = currQuestionData!.answers[i]
            
            if String(i) == String(lastAnswer) {
                currLabel.backgroundColor = UIColor.red
            }
            if String(i + 1) == currQuestionData!.answer {
                currLabel.backgroundColor = UIColor.green
            }
        }
    }
    
    @IBAction func NextButtonPress(_ sender: Any) {
        // If all questions done
        if context!.currQuestion + 1 == quizDetails?.questions.count {
            performSegue(withIdentifier: "AnswerToFinishedSegue", sender: self)
        } else { // Questions remain
            performSegue(withIdentifier: "AnswerToQuestionSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "AnswerToQuestionSegue":
            let questionVC = segue.destination as! QuestionViewController
            questionVC.quizDetails = quizDetails
            questionVC.context = Context(currQuestion: context!.currQuestion + 1, currSubject: context!.currSubject, numCorrect: context!.numCorrect, numWrong: context!.numWrong)
        case "AnswerToFinishedSegue":
            let finishedVC = segue.destination as! FinishedViewController
            finishedVC.numWrong = context!.numWrong
            finishedVC.numCorrect = context!.numCorrect
        default: break
        }
    }
}
