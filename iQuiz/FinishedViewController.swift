//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Adele on 2/22/19.
//  Copyright © 2019 edu.washington. All rights reserved.
//

import UIKit

class FinishedViewController: UIViewController {
    
    @IBOutlet weak var CorrectCount: UILabel!
    @IBOutlet weak var TotalCount: UILabel!
    @IBOutlet weak var ScoreComment: UILabel!
    
    var numWrong : Int = 0
    var numCorrect : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sum = numWrong + numCorrect
        let percentCorrect : Double = Double(numCorrect) / Double(sum)
        
        print("perc")
        print(percentCorrect)
        if percentCorrect == 1 {
             ScoreComment.text = "Perfect!"
        } else if percentCorrect > 0.8 {
             ScoreComment.text = "Almost!"
        } else if percentCorrect > 0.5 {
            ScoreComment.text = "Give it another try."
        } else if percentCorrect > 0.3 {
            ScoreComment.text = "Better luck next time."
        } else {
            ScoreComment.text = "RIP"
        }
        
        CorrectCount.text = String(numCorrect)
        TotalCount.text = String(sum)
    }
}
