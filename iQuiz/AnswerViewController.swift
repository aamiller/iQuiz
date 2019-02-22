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
        
        print("ans")
        print(currQuestionData!.answer)
        print(String(lastAnswer))
        

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

        QuestionTextLabel.text = currQuestionData!.text


    }
}
