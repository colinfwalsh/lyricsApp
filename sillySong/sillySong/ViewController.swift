//
//  ViewController.swift
//  sillySong
//
//  Created by Colin Walsh on 1/5/18.
//  Copyright © 2018 Colin Walsh. All rights reserved.
//

import UIKit



final class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joined(separator: "\n")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameField.delegate = self
        
    }
    
    func shortNameFromName(name: String) -> String {
        let vowels = CharacterSet(charactersIn: "aeiou")
        if let range = name.rangeOfCharacter(from: vowels) {
            if name[range.lowerBound] == name.first! {
                return name
            } else {
                return String(name[range.lowerBound...])
                
            }
        } else {
            return name
        }
    }
    
    func lyricsForName(_ name: String,_ template: String) -> String {
        
        let replaceName = template.replacingOccurrences(of: "<FULL_NAME>", with: "\(name)")
        let finalTemplate = replaceName.replacingOccurrences(of: "<SHORT_NAME>", with: shortNameFromName(name: "\(name.lowercased())"))
        
        return finalTemplate
    }
    
    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        guard let name = nameField.text else {return}
        lyricsView.text = lyricsForName(name, bananaFanaTemplate)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

