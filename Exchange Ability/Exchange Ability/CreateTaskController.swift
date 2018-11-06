//
//  FirstViewController.swift
//  Exchange Ability
//
//  Created by Eva Suska on 2018-02-26.
//  Copyright © 2018 Eva Suska. All rights reserved.
//

import UIKit
import os.log

class CreateTaskController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var compensationLabel: UILabel!
    @IBOutlet weak var compensationTextField: UITextField!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var desctiptionLabel: UILabel!
    @IBOutlet weak var descriptionTextField: UITextField!
	@IBOutlet weak var saveButton: UIBarButtonItem!

	@IBOutlet weak var photoImageView: UIImageView!
	@IBAction func cancel(_ sender: UIBarButtonItem) {
		dismiss(animated: true, completion: nil)
	}

	let categoryData = [Task.Category.furnitureAssembly.rawValue, Task.Category.lawnCare.rawValue, Task.Category.moving.rawValue, Task.Category.snowRemoval.rawValue, Task.Category.other.rawValue]
    
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
        self.categoryPicker.delegate = self
        self.categoryPicker.dataSource = self
        
        titleTextField.delegate = self
        titleTextField.returnKeyType = UIReturnKeyType.done
        locationTextField.delegate = self
        locationTextField.returnKeyType = UIReturnKeyType.done
        
        compensationTextField.delegate = self
        compensationTextField.keyboardType = UIKeyboardType.decimalPad
        compensationTextField.returnKeyType = UIReturnKeyType.done
        
        descriptionTextField.delegate = self
        descriptionTextField.returnKeyType = UIReturnKeyType.done
        
        APIService().getUsers() {users in
                print(users)
            }
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

	//MARK: Navigation
	// This method lets you configure a view controller before it's presented.
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

		super.prepare(for: segue, sender: sender)

		// Configure the destination view controller only when the save button is pressed.
		guard let button = sender as? UIBarButtonItem, button === saveButton else {
			os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
			return
		}

		let user : User = myUser	// UPDATE this when we have a database
		let requestor : Requestor = Requestor(user:user)
		let task : Task = Task(requestor:requestor)
		task.title = titleTextField.text!
		task.category = Task.Category(rawValue: categoryData[categoryPicker.selectedRow(inComponent: 0)])!
		task.dateTime = datePicker.date
		task.location = locationTextField.text!
        task.description = descriptionTextField.text!
		if let fee = Double(compensationTextField.text!) {
			task.fee = fee
		}
		task.photo = photoImageView.image
		requestor.tasks.append(task)
		task.state = Task.State.opened
		allTasks.append(task)
        
        APIService().createTask(task: task) { (err, result) in
            if(err != nil){
                print(err!.localizedDescription)
                return
            }
            print(result ?? "")
        }

	}

	//MARK: Actions
	@IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
		// Hide the keyboard.
//		nameTextField.resignFirstResponder()

		// UIImagePickerController is a view controller that lets a user pick media from their photo library.
		let imagePickerController = UIImagePickerController()

		// Only allow photos to be picked, not taken.
		imagePickerController.sourceType = .photoLibrary

		// Make sure ViewController is notified when the user picks an image.
		imagePickerController.delegate = self
		present(imagePickerController, animated: true, completion: nil)
	}

	//MARK: UIImagePickerControllerDelegate
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		// Dismiss the picker if the user canceled.
		dismiss(animated: true, completion: nil)
	}

	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

		// The info dictionary may contain multiple representations of the image. You want to use the original.
		guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
			fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
		}

		// Set photoImageView to display the selected image.
		photoImageView.image = selectedImage

		// Dismiss the picker.
		dismiss(animated: true, completion: nil)
	}

    
}

