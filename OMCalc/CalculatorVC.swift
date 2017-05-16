//
//  CalculatorVC.swift
//  OMCalc
//
//  Created by Nikita Pokidyshev on 12.05.17.
//  Copyright © 2017 Nikita Pokidyshev. All rights reserved.
//

import UIKit

class CalculatorVC: UIViewController {
  @IBOutlet weak var methodTextBox: UITextField!
  @IBOutlet weak var methodDropDown: UIPickerView!

  override func viewDidLoad() {
    super.viewDidLoad()
    methodTextBox.text = methodsPickerData[0]
  }

  fileprivate let methodsPickerData = [ "Бисекция", "Золотое сечение", "Парабол", "Ньютона" ]
}

extension CalculatorVC: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    view.endEditing(true)
    return methodsPickerData[row]
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    methodTextBox.text = methodsPickerData[row]
  }
}

extension CalculatorVC: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return methodsPickerData.count
  }
}

extension CalculatorVC: UITextFieldDelegate {
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    let dropDownIsHidden = self.methodDropDown.isHidden
    let alphaDuration = dropDownIsHidden ? 0.0 : 0.2

    UIView.animate(withDuration: alphaDuration, delay: 0, options: [], animations: {
      self.methodDropDown.alpha = 1 - self.methodDropDown.alpha
    }) { finished in
      UIView.animate(withDuration: 0.4, animations: {
        self.methodDropDown.isHidden = !self.methodDropDown.isHidden
      })
    }

    return false
  }
}
