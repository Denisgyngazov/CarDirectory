//
//  NewCarTableViewController.swift
//  CarDirectory
//
//  Created by Денис Гынгазов on 03.03.2020.
//  Copyright © 2020 Денис Гынгазов. All rights reserved.
//

import UIKit

class NewCarTableViewController: UITableViewController {
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var carManufacturer: UITextField!
    @IBOutlet weak var carModel: UITextField!
    @IBOutlet weak var carBodyType: UITextField!
    @IBOutlet weak var carYear: UITextField!
    
    var currentCar: Car?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.tableFooterView = UIView()
    
        saveBtn.isEnabled = false
        carManufacturer.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        carModel.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        carBodyType.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        carYear.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        setupEditScreen()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
   
    func saveCar(){
        let newCar = Car(manufacturer: carManufacturer.text!, model: carModel.text!, bodyType: carBodyType.text!, year: carYear.text!)
        if currentCar != nil {
            try! realm.write {
                currentCar?.manufacturer = newCar.manufacturer
                currentCar?.model = newCar.model
                currentCar?.bodyType = newCar.bodyType
                currentCar?.year = newCar.year
            }
        }else {
            StorageManager.saveObject(newCar)
        }
    }
    
    private func setupEditScreen() {
        if currentCar != nil {
            setupNavigationBar()
            carManufacturer.text = currentCar?.manufacturer
            carModel.text = currentCar?.model
            carBodyType.text = currentCar?.bodyType
            carYear.text = currentCar?.year
        }
    }
    
    private func setupNavigationBar() {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navigationItem.leftBarButtonItem = nil
        title = currentCar?.manufacturer
        saveBtn.isEnabled = true
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension NewCarTableViewController: UITextFieldDelegate {
    // Hide the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // Btn save enabl , disable
    @objc private func textFieldChanged() {
        if carManufacturer.text?.isEmpty == false && carModel.text?.isEmpty == false && carBodyType.text?.isEmpty == false && carYear.text?.isEmpty == false{
            saveBtn.isEnabled = true
        }else{
            saveBtn.isEnabled = false
        }
    }
}


