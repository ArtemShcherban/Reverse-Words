//
//  ReversWordsController.swift
//  Reverse words
//
//  Created by Artem Shcherban on 05.01.2022.
//

import UIKit

class ReverseWordsController: UIViewController {
    
    private var reverseWordsModel: ReverseWordsModel!
    private var stringToEditing: String!
    
    private var reverseWordsView: ReverseWordsView! {
        
        guard isViewLoaded else { return nil }
        return (view as? ReverseWordsView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reverseWordsModel = ReverseWordsModel()
        reverseWordsView.addSubViews()
        reverseWordsView.setConstraints()
        reverseWordsView.setReverseButtonConstraints()
        configure()
        setupHideKeyboardTapGesture()
    }
    
   private func configure() {
        reverseWordsView.textToReverseTextField.delegate = self
        reverseWordsView.reverseButton.addTarget(self, action: #selector(reverseButtonPressed), for: .touchUpInside)
    }
    
    @objc func reverseButtonPressed() {
        if reverseWordsView.reverseButton.isSelected {
            reverseWordsView.textToReverseTextField.text = ""
            reverseWordsView.reverseTextLabel.text = ""
            reverseWordsView.reverseButton.isSelected = false
            reverseWordsView.reverseButton.isEnabled = false
            reverseWordsView.reverseButton.alpha = 0.6
        } else {
            reverseWordsView.reverseTextLabel.text =
                (reverseWordsModel.reverseWords(reverseWordsView.textToReverseTextField.text ?? ""))
            reverseWordsView.reverseButton.isSelected = true
            reverseWordsView.setSeparatorViewColor(colorOn: false)
        }
    }
}

extension ReverseWordsController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        stringToEditing = textField.text
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.hasText == false {
            reverseWordsView.reverseTextLabel.text = ""
            reverseWordsView.reverseButton.isEnabled = false
            reverseWordsView.reverseButton.isSelected = false
            reverseWordsView.reverseButton.alpha = 0.6
            reverseWordsView.setSeparatorViewColor(colorOn: false)
        } else if textField.hasText == true && stringToEditing == textField.text {
            textField.textColor = ThemeConstants.AppColors.greyColor
            return true
        } else if textField.hasText == true && reverseWordsView.reverseButton.isSelected == true {
            textField.textColor = ThemeConstants.AppColors.greyColor
            reverseWordsView.reverseTextLabel.text = ""
            reverseWordsView.reverseButton.isSelected = false
            reverseWordsView.setSeparatorViewColor(colorOn: true)
        } else {
            textField.textColor = ThemeConstants.AppColors.greyColor
            reverseWordsView.reverseButton.isEnabled = true
            reverseWordsView.reverseButton.alpha = 1
            reverseWordsView.setSeparatorViewColor(colorOn: true)
        }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.hasText == true {
            textField.textColor = ThemeConstants.AppColors.blueColor
            reverseWordsView.reverseButton.isEnabled = true
            reverseWordsView.reverseButton.alpha = 1
            reverseWordsView.setSeparatorViewColor(colorOn: true)
        } else {
            reverseWordsView.reverseButton.isEnabled = false
            reverseWordsView.reverseButton.alpha = 0.6
            reverseWordsView.setSeparatorViewColor(colorOn: false)
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        reverseWordsView.setSeparatorViewColor(colorOn: false)
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()
    }
}

private extension ReverseWordsController {
    func setupHideKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
