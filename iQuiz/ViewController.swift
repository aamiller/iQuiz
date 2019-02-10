//
//  ViewController.swift
//  iQuiz
//
//  Created by Adele on 2/10/19.
//  Copyright © 2019 edu.washington. All rights reserved.
//

import UIKit

class SubjectsDataSource : NSObject, UITableViewDataSource
{
    var subjectNames : [String] = []
    var photoPaths : [String] = []
    var shortDescriptions : [String] = []

    init(_ subjectNames : [String], _ photoPaths : [String], _ shortDescriptions : [String]) {
        self.subjectNames = subjectNames
        self.photoPaths = photoPaths
        self.shortDescriptions = shortDescriptions
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

class ViewController: UIViewController {

    @IBOutlet weak var ToolBar_Settings: UIBarButtonItem!
    
    @IBOutlet weak var MainTableView: UITableView!
    
    let dataSource = SubjectsDataSource(["Mathematics", "Marvel Super Heros", "Science"], ["paper.png", "superhero.png", "bulb.png"], ["Don't worry, we won't make you do calculus... probably.", "You know what Scarlet Witch's real name is, right?", "Can you science it?"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     
        MainTableView.dataSource = dataSource
        MainTableView.tableFooterView = UIView()

    }
    
    
    @IBAction func SettingsButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
  
}

