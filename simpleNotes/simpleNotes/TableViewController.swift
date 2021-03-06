//
//  ViewController.swift
//  simpleNotes
//
//  Created by Dmitry Cherkasov on 10/17/17.
//  Copyright © 2017 Dmitry Cherkasov. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, NoteViewDelegate {
    
    @IBAction func addNote(_ sender: Any) {
        var newDict = ["title":"", "body":""]
        self.selectedIndex = 0
        self.tableView.reloadData()
        performSegue(withIdentifier: "showDetails", sender: nil)
    }
    var notesArr = [[String:String]]()
    var selectedIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = notesArr[indexPath.row]["title"]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        performSegue(withIdentifier: "showDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let notesEditorVC = segue.destination
        notesEditorVC.navigationItem.title = notesArr[self.selectedIndex]["title"]
        notesEditorVC.strBodyText = notesArr[self.selectedIndex]["body"]
        notesEditorVC.delegate = self
    }
    
    func didUpdateNoteWithTitle(newTitle: String, andBody newBody: String) {
        self.notesArr[self.selectedIndex]["title"] = newTitle
        self.notesArr[self.selectedIndex]["body"] = newBody
        self.tableView.reloadData()
    }
    
    func saveNotesArr() {
        UserDefaults.standard.set(notesArr, forKey: "notes")
        UserDefaults.standard.synchronize()
    }


}

