//
//  FirstViewController.swift
//  Exchange Ability
//
//  Created by Eva Suska on 2018-02-26.
//  Copyright © 2018 Eva Suska. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var compensationLabel: UILabel!
    @IBOutlet weak var compensationTextField: UITextField!
    
    let categoryData = [Task.Category.furnitureAssembly.rawValue, Task.Category.lawnCare.rawValue, Task.Category.moving.rawValue, Task.Category.snowRemoval.rawValue, Task.Category.other.rawValue]
    
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
        self.categoryPicker.delegate = self
        self.categoryPicker.dataSource = self
        
        titleTextField.delegate = self
        titleTextField.returnKeyType = UIReturnKeyType.done
        
        compensationTextField.delegate = self
        compensationTextField.keyboardType = UIKeyboardType.decimalPad
        compensationTextField.returnKeyType = UIReturnKeyType.done
	}
    
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryData[row]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: Actions
    @IBAction func submitTaskButton(_ sender: UIButton) {
        
        let user : User = User()
        let requestor : Requestor = Requestor(user:user)
        let task : Task = Task(requestor:requestor)
        task.title = titleTextField.text!
        task.dateTime = datePicker.date
    }
    
    
}

