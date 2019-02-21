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
    
    var questionData : [String] = ["0", "0", "0", "0"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        QuestionChoices[0].text = questionData[0]
        QuestionChoices[1].text = questionData[1]
        QuestionChoices[2].text = questionData[2]
        QuestionChoices[3].text = questionData[3]


        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
