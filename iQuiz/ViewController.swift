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
    var data : [String] = ["Mathematics", "Marvel Super Heros", "Mathematics"]
    init(_ elements : [String]) {
        data = elements
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        assert(section == 0)
        return "Subjects"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")!
        
        cell.textLabel?.text = data[indexPath.row]
        
        return cell
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var ToolBar_Settings: UIBarButtonItem!
    
    @IBOutlet weak var MainTableView: UITableView!
    
    let dataSource = SubjectsDataSource(["Mathematics", "Marvel Super Heros", "Mathematics"])
    
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

