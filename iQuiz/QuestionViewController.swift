//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Adele on 2/21/19.
//  Copyright © 2019 edu.washington. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet var QuestionChoices: [UILabel]!
    
    @IBOutlet weak var AnswerSelectorSegment: UISegmentedControl!
    
    @IBOutlet weak var SubmitQuestionChoiceButton: UIButton!
    
    var quizDetails : QuizDetails? = nil
    
    var questionData : QuestionDetails? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionData = quizDetails?.questions[0]
        
        QuestionChoices[0].text = questionData?.answers[0]
        QuestionChoices[1].text = questionData?.answers[1]
        QuestionChoices[2].text = questionData?.answers[2]
        QuestionChoices[3].text = questionData?.answers[3]
    }
}
