//
//  setProjectNameViewController.swift
//  MiyataSample2
//
//  Created by 宮田恵里 on 2017/10/24.
//  Copyright © 2017年 宮田恵里. All rights reserved.
//

import UIKit
//import Material

class setProjectNameViewController: UIViewController {
    var project: String?
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.saveButton.isEnabled = false
    }
    
    private func updateSaveButtonState(){
        let project = self.textField.text ?? ""
        self.saveButton.isEnabled = !project.isEmpty
    }
    
    @IBAction func projectNameTextFieldChanged(_ sender: Any) {
        self.updateSaveButtonState()
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIBarButtonItem, button === self.saveButton else{
            return
        }
        self.project = self.textField.text ?? ""
    }


}

