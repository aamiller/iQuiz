//
//  ViewController.swift
//  iQuiz
//
//  Created by Adele on 2/10/19.
//  Copyright © 2019 edu.washington. All rights reserved.
//

// todo: error handling, clean up code, check if imgs can repeat TODO - fix hacky

import UIKit
import Foundation

struct QuizDetails : Codable {
    let title : String
    let desc : String
    let questions : [QuestionDetails]
}

struct QuestionDetails : Codable {
    let text : String
    let answer : String
    let answers : [String]
}

class SubjectsDataSource : NSObject, UITableViewDataSource
{
    var subjectNames : [String] = []
    var photoPaths : [String] = []
    var shortDescriptions : [String] = []
    
    init(_ QuizDetails : [QuizDetails]) {
        
        var image_index = 0
        let photoPaths = ["paper.png", "superhero.png", "bulb.png"]
        
        for quiz in QuizDetails {
            self.subjectNames.append(quiz.title)
            self.shortDescriptions.append(quiz.desc)
            self.photoPaths.append(photoPaths[image_index])
            image_index = (image_index + 1) % 3
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        assert(section == 0)
        return "Subjects"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectNames.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")!
        
        cell.textLabel?.text = subjectNames[indexPath.row]
        cell.detailTextLabel?.text = shortDescriptions[indexPath.row]
        cell.imageView?.image = UIImage(named: photoPaths[indexPath.row])
        
        return cell
    }
}

class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var ToolBar_Settings: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    var quizDetails : [QuizDetails] = []
    
    var dataSource : SubjectsDataSource? = nil
    
    //TODO    var dataSource = SubjectsDataSource(["Mathematics", "Marvel Super Heros", "Science"], ["paper.png", "superhero.png", "bulb.png"], ["Don't worry, we won't make you do calculus... probably.", "You know what Scarlet Witch's real name is, right?", "Can you science it?"])
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Code adapted from https://medium.com/@nimjea/json-parsing-in-swift-2498099b78f
        guard let url = URL(string: "https://tednewardsandbox.site44.com/questions.json") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do {
                self.quizDetails = try JSONDecoder().decode([QuizDetails].self, from:dataResponse)
                self.dataSource = SubjectsDataSource(self.quizDetails)
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
        
        sleep(2) // TODO - fix hacky thing
        
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    
    @IBAction func SettingsButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            let firstQuizVC = segue.destination as! QuestionViewController
            firstQuizVC.quizDetails = quizDetails[selectedRow]
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("X")
//        performSegue(withIdentifier: "MainQuizToFirstAnswerSegue", sender: indexPath)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        switch segue.identifier {
//            case "MainQuizToFirstAnswerSegue":
//                let firstQuiz = segue.destination as! QuestionViewController
//                let indexPath = sender as! IndexPath
//                firstQuiz.quizDetails = quizDetails[indexPath[1]]
//            print("Y")
//            default: break
//        }
//    }
}
    

