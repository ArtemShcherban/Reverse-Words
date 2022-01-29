//
//  ReverseWordsController.swift
//  Reverse words
//
//  Created by Artem Shcherban on 05.01.2022.
//

import UIKit

final class ReverseWordsViewController: UIViewController {
    static let reuseIdentifier = String(describing: ReverseWordsViewController.self)
    
    private var reverseWordsModel: ReverseWordsModel!
    private var stringToEditing: String!
    private var customRuleToEditing: String!
    
    private var reverseWordsView: ReverseWordsView? {
        
        view as? ReverseWordsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = AppConstants.title
        reverseWordsModel = ReverseWordsModel()
        reverseWordsView?.addSubViews()
        reverseWordsView?.setupAccessibility()
        reverseWordsView?.setConstraints()
        reverseWordsView?.setResultSwitchConstraint()
        reverseWordsView?.setRulesSegmentControlConstraints()
        reverseWordsView?.setReverseButtonConstraints()
        navigationItem.scrollEdgeAppearance = reverseWordsView?.createNavBarAppearence()
        configure()
        setupHideKeyboardTapGesture()
    }
    
    private func configure() {
        reverseWordsView?.textToReverseTextField.delegate = self
        reverseWordsView?.textToIgnoreTextField.delegate = self
        reverseWordsView?.resultSwitch.addTarget(self, action: #selector(resultSwitchFlipped), for: .valueChanged)
        reverseWordsView?.textToReverseTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        reverseWordsView?.textToIgnoreTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        reverseWordsView?.segmentControl.addTarget(self, action: #selector(segmentControlIndexChanged), for: .valueChanged)
        reverseWordsView?.reverseButton.addTarget(self, action: #selector(reverseButtonPressed), for: .touchUpInside)
    }
        
    @objc func resultSwitchFlipped() {
        if reverseWordsView?.textToReverseTextField.isEditing == true ||
            reverseWordsView?.textToIgnoreTextField.isEditing == true {
            dismissKeyboard()
        }
        if reverseWordsView?.resultSwitch.isOn == true {
            reverseWordsView?.resultSwitchTextLabel.textColor = ColorsConstants.greyColor.withAlphaComponent(0.6)
            if reverseWordsView?.textToReverseTextField.text?.isEmpty == false {
                reverseWordsView?.reverseButton.isActive = false
                reverseWordsView?.reverseButton.isSelected = false
                reverseWordsView?.separatorView.isActive = false
                reverseWordsView?.reverseTextLabel.text = reverseInputedString()
            }
        } else {
            reverseWordsView?.resultSwitchTextLabel.textColor =  ColorsConstants.greyColor.withAlphaComponent(0.2)
            if reverseWordsView?.textToReverseTextField.text?.isEmpty == false {
                reverseWordsView?.reverseButton.isActive = true
                reverseWordsView?.reverseButton.isSelected = true
                reverseWordsView?.separatorView.isActive = false
            }
        }
    }
    
    @objc func textFieldDidChange(sender: ReverseWordsTextField) {
        if sender == reverseWordsView?.textToReverseTextField {
            reverseWordsView?.resultSwitch.isOn == true ?
            textFieldDidChangeResultSwitchIsON() : textFieldDidChangeResultSwitchIsOFF()
            
        } else if sender == reverseWordsView?.textToIgnoreTextField {
            reverseWordsModel.customExceptions = sender.text ?? ""
            
            if  reverseWordsView?.resultSwitch.isOn == true {
                textFieldDidChangeResultSwitchIsON()
            }
        }
    }
    
    private func textFieldDidChangeResultSwitchIsOFF() {
        if reverseWordsView?.textToReverseTextField.hasText == false {
            reverseWordsView?.separatorView.isActive = false
            resetToInitialState()
        } else if reverseWordsView?.textToReverseTextField.hasText == true
                    && stringToEditing == reverseWordsView?.textToReverseTextField.text {
            reverseWordsView?.textToReverseTextField.textColor = ColorsConstants.greyColor
            reverseWordsView?.reverseButton.isSelected = true
            reverseWordsView?.separatorView.isActive = false
        } else if reverseWordsView?.textToReverseTextField.hasText == true
                    && reverseWordsView?.reverseButton.isSelected == true {
            reverseWordsView?.textToReverseTextField.textColor = ColorsConstants.blueColor
            reverseWordsView?.reverseButton.isSelected = false
            reverseWordsView?.separatorView.isActive = true
        } else {
            reverseWordsView?.textToReverseTextField.textColor = ColorsConstants.blueColor
            reverseWordsView?.reverseButton.isActive = true
            reverseWordsView?.separatorView.isActive = true
        }
    }
    
    private func textFieldDidChangeResultSwitchIsON() {
        if reverseWordsView?.textToReverseTextField.hasText == false {
            reverseWordsView?.separatorView.isActive = false
            resetToInitialState()
        } else {
            if reverseWordsView?.textToReverseTextField.isEditing == true {
                reverseWordsView?.textToReverseTextField.textColor = ColorsConstants.blueColor
            }
            reverseWordsView?.separatorView.isActive = true
            reverseWordsView?.reverseTextLabel.text = reverseInputedString()
            stringToEditing = reverseWordsView?.textToReverseTextField.text
        }
    }
    
    @objc func reverseButtonPressed() {
        if reverseWordsView?.reverseButton.isSelected == true {
            reverseWordsView?.textToReverseTextField.text = ""
            resetToInitialState()
        } else {
            reverseWordsView?.reverseTextLabel.text = reverseInputedString()
            reverseWordsView?.reverseButton.isSelected = true
            reverseWordsView?.separatorView.isActive = false
        }
    }
    
    @objc func segmentControlIndexChanged() {
        ruleSelection()
        textToIgnoreTextFieldControl()
        if reverseWordsView?.resultSwitch.isOn == true &&
            reverseWordsView?.textToReverseTextField.text?.isEmpty == false {
            reverseWordsView?.reverseTextLabel.text = reverseInputedString()
            
        } else {
            if reverseWordsView?.reverseButton.isSelected == true {
                reverseWordsView?.reverseTextLabel.text = reverseInputedString()
            }
        }
    }
    
    private func ruleSelection() {
        if reverseWordsView?.segmentControl.selectedSegmentIndex == 0 {
            reverseWordsView?.subTitleTextLabel.text = RulesConstants.alphabetRule
            
        } else if reverseWordsView?.segmentControl.selectedSegmentIndex == 2 {
            reverseWordsView?.subTitleTextLabel.text = RulesConstants.customRule
            
        } else if reverseWordsView?.segmentControl.selectedSegmentIndex == 1 {
            reverseWordsView?.subTitleTextLabel.text = RulesConstants.mainRule
        }
    }
    
    private func textToIgnoreTextFieldControl() {
        if reverseWordsView?.segmentControl.selectedSegmentIndex == 2 {
            reverseWordsView?.addTextToIgnoreTextField()
            reverseWordsView?.setTextToIgnoreTextFieldConstraints()
        } else {
            reverseWordsView?.removeTextToIgnoreTextField()
        }
    }
    
    private func reverseInputedString() -> String {
        let inputedString = reverseWordsView?.textToReverseTextField.text ?? ""
        var reversedString = ""
        
        if reverseWordsView?.segmentControl.selectedSegmentIndex == 1 {
            reversedString = reverseWordsModel.reverseWordsWithNoRules(inputedString)
            
        } else if reverseWordsView?.segmentControl.selectedSegmentIndex == 0 {
            reversedString = reverseWordsModel.reverseWordsWithRule(inputedString, 0)
            
        } else if reverseWordsView?.segmentControl.selectedSegmentIndex == 2 {
            reversedString = reverseWordsModel.reverseWordsWithRule(inputedString, 2)
            
        }
        return reversedString
    }
    
    private func resetToInitialState() {
        stringToEditing = ""
        reverseWordsView?.reverseTextLabel.text = ""
        reverseWordsView?.reverseButton.isSelected = false
        reverseWordsView?.reverseButton.isActive = false
    }
}

extension ReverseWordsViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == reverseWordsView?.textToReverseTextField {
            stringToEditing = textField.text
        }
        
        if textField == reverseWordsView?.textToIgnoreTextField {
            customRuleToEditing = textField.text
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if reverseWordsView?.resultSwitch.isOn == true {
            reverseWordsView?.textToReverseTextField.textColor = ColorsConstants.greyColor
            reverseWordsView?.separatorView.isActive = false
            
        } else if reverseWordsView?.resultSwitch.isOn == false {
            if textField == reverseWordsView?.textToReverseTextField {
                if textField.text != stringToEditing {
                    reverseWordsView?.reverseTextLabel.text = ""
                    reverseWordsView?.separatorView.isActive = true
                    textField.textColor = ColorsConstants.greyColor
                }
            } else if textField == reverseWordsView?.textToIgnoreTextField {
                if reverseWordsView?.reverseButton.isSelected == true && textField.text != customRuleToEditing {
                    reverseWordsView?.reverseTextLabel.text = ""
                    reverseWordsView?.separatorView.isActive = true
                    reverseWordsView?.reverseButton.isSelected = false
                }
            }
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField == reverseWordsView?.textToReverseTextField {
            reverseWordsView?.separatorView.isActive = false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

private extension ReverseWordsViewController {
    func setupHideKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
