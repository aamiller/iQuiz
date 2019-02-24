//
//  ViewController.swift
//  iQuiz
//
//  Created by Adele on 2/10/19.
//  Copyright © 2019 edu.washington. All rights reserved.
//

// todo: error handling, clean up code, comment up

import UIKit
import Foundation
import Reachability

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

struct Context {
    var currQuestion : Int
    var currSubject : Int // Number for subject
    var numCorrect : Int
    var numWrong: Int
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
    
    let reachability = Reachability()!
    let homeDir = NSHomeDirectory()
    
    @IBOutlet weak var ToolBar_Settings: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var quizDetails : [QuizDetails] = []
    var dataSource : SubjectsDataSource? = nil
    var urlString : String = "https://tednewardsandbox.site44.com/questions.json"
    let userDefs = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Start reachability notifier
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }

        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    func fetchJSON() {
        // Code adapted from https://medium.com/@nimjea/json-parsing-in-swift-2498099b78f
        guard let url = URL(string: userDefs.string(forKey: "URL") ?? "error") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    let errorString : String = error?.localizedDescription ?? "Response Error"

                    let alert = UIAlertController(title: "Error Downloading Questions", message: errorString, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                    self.present(alert, animated: true, completion: nil)
                    return
            }
            do {
                self.quizDetails = try JSONDecoder().decode([QuizDetails].self, from:dataResponse)
                self.dataSource = SubjectsDataSource(self.quizDetails)
                DispatchQueue.main.async {
                    self.viewDidLoad()
                }
                
                try dataResponse.write(to: URL(fileURLWithPath: (self.homeDir + "/quiz.json")))
                
            } catch let parsingError {
                let errorString : String = parsingError.localizedDescription
                
                let alert = UIAlertController(title: "Error Parsing Questions JSON", message: errorString, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                self.present(alert, animated: true, completion: nil)
            }
        }
        task.resume()
    }
    
    // Checks internet connection and notifies user if internet is unreachable
    func checkNowCall() {
        switch reachability.connection {
        case .wifi:
            fetchJSON()
        case .cellular:
            fetchJSON()
        case .none:
            let alert = UIAlertController(title: "Network Error", message: "Network is unreachable. Using locally stored quiz data if exists.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
            do {
                let dataResponse = try Data(contentsOf: URL(fileURLWithPath: (self.homeDir + "/quiz.json")))
                self.quizDetails = try JSONDecoder().decode([QuizDetails].self, from: dataResponse)
                self.dataSource = SubjectsDataSource(self.quizDetails)
                DispatchQueue.main.async {
                    self.viewDidLoad()
                }
                
            }
            catch {
                let alert = UIAlertController(title: "Network Error", message: "No quiz data stored locally.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func SettingsButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.text = self.userDefs.string(forKey: "URL")
        }
        
        let saveAction = UIAlertAction(title: "OK", style: .default) { (alertAction) in
            let urlString = (alert.textFields![0] as UITextField).text
            self.userDefs.set(urlString, forKey: "URL")
        }
        
        alert.addAction(UIAlertAction(title: "Check Now", style: UIAlertAction.Style.default) {
            UIAlertAction in self.checkNowCall()})
        alert.addAction(saveAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            let firstQuizVC = segue.destination as! QuestionViewController
            firstQuizVC.quizDetails = quizDetails[selectedRow]
            firstQuizVC.context = Context(currQuestion: 0, currSubject: indexPath.row, numCorrect: 0, numWrong: 0)
        }
    }
}
    

