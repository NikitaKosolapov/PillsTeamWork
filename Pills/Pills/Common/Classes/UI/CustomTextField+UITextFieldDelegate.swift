//
//  CustomTextField+UITextFieldDelegate.swift
//  Pills
//
//  Created by aprirez on 8/30/21.
//

import Foundation
import UIKit

extension CustomTextField: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if datePicker != nil { return true }
        if picker != nil { return true }
        if readOnly { return false }
        if clearOnFocus {
            text = ""
        }
        return true
    }

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        if datePicker != nil { return false }
        if picker != nil { return false }

        if maxLength >= 0 {
            guard let text = self.text,
                  let rangeToReplace = Range(range, in: text)
            else { return false }

            let substringToReplace = text[rangeToReplace]
            let count = text.count - substringToReplace.count + string.count
            if count > maxLength { return false }
        }

        if isNumeric {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }

        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let endEditProcessor = endEditProcessor else {return}
        endEditProcessor(textField.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
    }
	func textFieldDidBeginEditing(_ textField: UITextField) {
		addNewCourseDelegate?.textFieldStartEditing(textField)
	}
}
