//
//  SetsTableViewCell.swift
//  1o1 Fitness
//
//  Created by Mounika.x.muduganti on 26/05/20.
//  Copyright © 2020 Mounika.x.muduganti. All rights reserved.
//

import UIKit

class SetsTableViewCell: UITableViewCell {

    @IBOutlet weak var recRest: UILabel!
    @IBOutlet weak var recWeight: UILabel!
    @IBOutlet weak var recReps: UILabel!
    @IBOutlet weak var compSet: UILabel!
    @IBOutlet weak var recomSet: UILabel!
    @IBOutlet weak var restTxtField: UITextField!
    @IBOutlet weak var weightTxtField: UITextField!
    @IBOutlet weak var repTxtField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SetsTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn:"0123456789").inverted
            let components = string.components(separatedBy: allowedCharacters)
            let filtered = components.joined(separator: "")
            
            if string == filtered {
                
               let maxLength = 4
                let currentString: NSString = textField.text! as NSString
                let newString: NSString =
                    currentString.replacingCharacters(in: range, with: string) as NSString
               
                return newString.length <= maxLength

            } else {
                
                return false
            }
        }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}
