//
//  CustomTextField+UIPickerViewDelegate.swift
//  Pills
//
//  Created by aprirez on 8/30/21.
//

import Foundation
import UIKit

extension CustomTextField: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerOptions[row].localized()
    }
}
