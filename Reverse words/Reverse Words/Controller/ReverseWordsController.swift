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
        reverseWordsView?.setReverseButtonConstraints()
        navigationItem.scrollEdgeAppearance = reverseWordsView?.createNavBarAppearence()
        configure()
        setupHideKeyboardTapGesture()
    }
    
    private func configure() {
        reverseWordsView?.textToReverseTextField.delegate = self
        reverseWordsView?.textToReverseTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        reverseWordsView?.reverseButton.addTarget(self, action: #selector(reverseButtonPressed), for: .touchUpInside)
    }
    
    @objc func textFieldDidChange() {
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
    
    @objc func reverseButtonPressed() {
        if reverseWordsView?.reverseButton.isSelected == true {
            reverseWordsView?.textToReverseTextField.text = ""
            resetToInitialState()
        } else {
            reverseWordsView?.reverseTextLabel.text =
            (reverseWordsModel?.reverseWords(reverseWordsView?.textToReverseTextField.text ?? ""))
            reverseWordsView?.reverseButton.isSelected = true
            reverseWordsView?.separatorView.isActive = false
        }
    }
    
    func resetToInitialState() {
        stringToEditing = ""
        reverseWordsView?.reverseTextLabel.text = ""
        reverseWordsView?.reverseButton.isSelected = false
        reverseWordsView?.reverseButton.isActive = false
    }
}

extension ReverseWordsViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        stringToEditing = textField.text
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != stringToEditing {
            reverseWordsView?.reverseTextLabel.text = ""
            reverseWordsView?.separatorView.isActive = true
            textField.textColor = ColorsConstants.greyColor
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        reverseWordsView?.separatorView.isActive = false
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
