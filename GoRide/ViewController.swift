//
//  ViewController.swift
//  GoRide
//
//  Created by Egor  on 01.07.2020.
//  Copyright © 2020 Gregor Kramer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var segmentUserSex: UISegmentedControl!
    @IBOutlet weak var segmentUserType: UISegmentedControl!
    
    @IBOutlet weak var modelMotTextField: UITextField!
    @IBOutlet weak var equipment: UIStackView!
    @IBOutlet weak var myEquipment: UIStackView!
    
    @IBOutlet weak var lookingForSexTextField: UISegmentedControl!
    @IBOutlet weak var lookingHoursTextFild: UITextField!
    
    @IBOutlet weak var nextButtonOut: UIButton!

    

    var timeFrom1to24 = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]
    
    var selectedElement: String?
    
    
//------------------------------------------------------------------

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
// меняем цвет шрифта в сегментах
        segmentUserSex.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentUserSex.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemGray], for: .normal)

        segmentUserType.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentUserType.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemGray], for: .normal)

        lookingForSexTextField.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        lookingForSexTextField.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemGray], for: .normal)

        
        choiceTime()
        createToolBar()

        segmentUserType.selectedSegmentIndex = 1
        myEquipment.isHidden = true
        lookingForSexTextField.selectedSegmentIndex = 1
        
        self.setupToHideKeyboardOnTapOnView()
        
// делаем кнопку дальше изначально не активной
        nextButtonOut.layer.cornerRadius = 5
        
        updateNextButtonState()
        
    }
//------------------------------------------------------------------
    // перключаю на ищу пилот или пассажир

    @IBAction func changeSegmentUserType(_ sender: UISegmentedControl) {
        
        switch segmentUserType.selectedSegmentIndex {
        case 0:
            modelMotTextField.isHidden = true
            equipment.isHidden = true
            myEquipment.isHidden = false
        case 1:
            modelMotTextField.isHidden = false
            equipment.isHidden = false
            myEquipment.isHidden = true
        default:
            print("Some wrong!")
        }
        
    }
    
// создаем метод вызывающий пикервью в тексвью
    func choiceTime() {
        let elementPicker = UIPickerView()
        elementPicker.delegate = self
        lookingHoursTextFild.inputView = elementPicker
        
    }

// создаем кнопу Готово для пикервью
    func createToolBar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(dismissKeyboard))
        
        toolbar.setItems([spaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        lookingHoursTextFild.inputAccessoryView = toolbar
        
// customization
        toolbar.tintColor = .systemGray
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
//------------------------------------------------------------------
// нажатие на кнопку Дальше
    @IBAction func nextButton(_ sender: UIButton) {
    }
    
    //------------------------------------------------------------------
    //Кнопка дальше активируется после заполнения поля Имя и Часы

    private func updateNextButtonState() {

        
        let nameTF = nameTextField.text ?? ""
        let lookingHoursTF = lookingHoursTextFild.text ?? ""
        nextButtonOut.isEnabled = !nameTF.isEmpty && !lookingHoursTF.isEmpty
        
        if nextButtonOut.isEnabled {
            nextButtonOut.backgroundColor = #colorLiteral(red: 0.2666385472, green: 0.4405331612, blue: 0.5936046839, alpha: 1)
            nextButtonOut.setTitleColor(.white, for: .normal)
        } else {
            nextButtonOut.backgroundColor = .systemGray5
            nextButtonOut.setTitleColor(.gray, for: .normal)
        }
    }
    
    //------------------------------------------------------------------

    @IBAction func textChanged(_ sender: UITextField) {
        updateNextButtonState()
    }
}


// делаем пикервью для выбора продолжительности поездки
extension ViewController : UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return timeFrom1to24.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timeFrom1to24[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedElement = timeFrom1to24[row]
        lookingHoursTextFild.text = selectedElement
        
    }
    
// скрываем клавиаутуру после нажатия кнопки готово
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
        modelMotTextField.resignFirstResponder()
        return true
    }
    
}

//------------------------------------------------------------------
// скрываем клавиатуру после нажатия на другое поле
extension UIViewController
{
    func setupToHideKeyboardOnTapOnView()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboardall))

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboardall()
    {
        view.endEditing(true)
    }
}


