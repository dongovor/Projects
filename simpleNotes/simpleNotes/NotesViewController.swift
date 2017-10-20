//
//  NotesViewController.swift
//  simpleNotes
//
//  Created by Dmitry Cherkasov on 10/18/17.
//  Copyright © 2017 Dmitry Cherkasov. All rights reserved.
//

import UIKit

protocol NoteViewDelegate {
    func didUpdateNoteWithTitle(newTitle: String, andBody newBody: String)
}
class NotesViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textBody: UITextView!
    @IBOutlet weak var doneButtonState: UIBarButtonItem!
    
    @IBAction func doneBtn(_ sender: Any) {
        self.textBody.resignFirstResponder()
        self.doneButtonState.tintColor = UIColor.clear
        self.textBody.delegate = self
        if self.delegate != nil {
            self.delegate!.didUpdateNoteWithTitle(newTitle: self.navigationItem.title!, andBody: self.textBody.text)
        }
    }
    
    var strBodyText: String!
    var delegate: NoteViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.textBody.text = self.strBodyText
        self.textBody.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.delegate != nil {
            self.delegate!.didUpdateNoteWithTitle(newTitle: self.navigationItem.title!, andBody: self.textBody.text)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidBeginEditing(_ textView:UITextView) {
        self.doneButtonState.tintColor = UIColor(red: 0, green: 122.0/255.0, blue: 1, alpha: 1)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let components = self.textBody.text.components(separatedBy: "\n")
        self.navigationItem.title = ""
        for item in components {
            if countElements(item.stringByTrimmingCharactersInSet(NSCharacterSet.whitespacesAndNewlines())) > 0 {
                self.navigationItem.title = item
                break
            }
        }
    }

}
