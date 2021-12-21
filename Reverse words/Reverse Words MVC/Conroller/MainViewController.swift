//
//  ViewController.swift
//  Reverse words
//
//  Created by Artem Shcherban on 13.12.2021.
//

import UIKit

class MainViewController: UIViewController {

    var reverseWordsModel: ReverseWordsModel!
    var topView, inputTextView, separatorView: UIView!
    var topTitleTextLabel, mainTitleTextLable, subTitleTextLabel, reverseTextLabel: UILabel!
    var textToReverseTextField: UITextField!
    var stringToEditing: String!
    var reverseButton: UIButton!
    var appTitle = "Reverse Words"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reverseWordsModel = ReverseWordsModel()
        
        createViews()
        createTextLabels()
        createTextField()
        createButton()
        setConstraints()
        
        self.hideKeyboardWhenTappedAround()
    }
    
    func createViews() {
        // Create Top View
        topView = UIView()
        topView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 88)
        topView.backgroundColor = .white
        topView.layer.backgroundColor = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 0.94).cgColor
        topView.layer.shadowPath = UIBezierPath(rect: topView.bounds).cgPath
        topView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        topView.layer.shadowOpacity = 1
        topView.layer.shadowRadius = 0
        topView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        self.view.addSubview(topView)
        
        // Create Input Text View
        inputTextView = UILabel()
        inputTextView.backgroundColor = .white
        inputTextView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        self.view.addSubview(inputTextView)
        
        // Separator View
        separatorView = UIView()
        separatorView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        separatorView.alpha = 0.2
        self.view.addSubview(separatorView)
    }
    
    func createTextLabels() {
        
        // Create Small Title Text Label
        topTitleTextLabel = UILabel()
        topTitleTextLabel.backgroundColor = .clear
        topTitleTextLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        topTitleTextLabel.font = UIFont(name: "SFUIDisplay-Semibold", size: 17)
        topTitleTextLabel.attributedText =
            NSMutableAttributedString(string: appTitle,
                                      attributes: [NSAttributedString.Key.kern: -0.41])
        topTitleTextLabel.textAlignment = .center
        self.view.addSubview(topTitleTextLabel)
        
        // Create Main Title Text Label
        mainTitleTextLable = UILabel()
        mainTitleTextLable.backgroundColor = .white
        mainTitleTextLable.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        mainTitleTextLable.font = UIFont(name: "SFUIDisplay-Bold", size: 34)
        mainTitleTextLable.attributedText =
            NSMutableAttributedString(string: appTitle,
                                      attributes: [NSAttributedString.Key.kern: 0.37])
        mainTitleTextLable.textAlignment = .center
        self.view.addSubview(mainTitleTextLable)
        
        // Create Sub Title Text Label
        subTitleTextLabel = UILabel()
        subTitleTextLabel.backgroundColor = .white
        subTitleTextLabel.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
        subTitleTextLabel.font = UIFont(name: "SFUIDisplay-Regular", size: 17)
        subTitleTextLabel.numberOfLines = 0
        subTitleTextLabel.lineBreakMode = .byWordWrapping
        subTitleTextLabel.attributedText =
            NSMutableAttributedString(string: "This application will reverse your words. Please type text below",
                                      attributes: [NSAttributedString.Key.kern: -0.41])
        subTitleTextLabel.textAlignment = .center
        self.view.addSubview(subTitleTextLabel)
        
        // Create Esreve Ro Ttxet Text Label
        reverseTextLabel = UILabel()
        reverseTextLabel.backgroundColor = .white
        reverseTextLabel.textColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1)
        reverseTextLabel.font = UIFont(name: "SFUIDisplay-Regular", size: 24)
        reverseTextLabel.attributedText =
            NSMutableAttributedString(string: " ",
                                      attributes: [NSAttributedString.Key.kern: -0.41])
        self.view.addSubview(reverseTextLabel)
    }
    
    func createTextField() {
        textToReverseTextField = UITextField()
        textToReverseTextField.backgroundColor = .white
        textToReverseTextField.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 1)
        textToReverseTextField.font = UIFont(name: "SFUIDisplay-Regular", size: 17)
        textToReverseTextField.placeholder = "Text to reverse"
        textToReverseTextField.clearButtonMode = .whileEditing
        textToReverseTextField.delegate = self
        self.view.addSubview(textToReverseTextField)
    }
    
    func createButton() {
        reverseButton = UIButton()
        reverseButton.backgroundColor = .white
        reverseButton.alpha = 0.6
        reverseButton.layer.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1).cgColor
        reverseButton.layer.cornerRadius = 14
        reverseButton.setTitle("Reverse", for: .normal)
        reverseButton.setTitle("Clear", for: .selected)
        reverseButton.titleLabel?.font = UIFont(name: "SFUIDisplay-Regular", size: 17)
        reverseButton.addTarget(self, action: #selector(reverseButtonPressed), for: .touchUpInside)
        reverseButton.isEnabled = false
        reverseButton.isSelected = false
        self.view.addSubview(reverseButton)
    }
    
    func setSeparatorViewColor(colorOn: Bool) {
        switch colorOn {
        case true:
            separatorView.alpha = 1
            separatorView.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1)
        case false:
            separatorView.alpha = 0.2
            separatorView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    @objc func reverseButtonPressed() {
        switch reverseButton.isSelected {
        case false:
            reverseTextLabel.text = (reverseWordsModel.reverseWords(textToReverseTextField.text ?? ""))
            reverseButton.isSelected = true
            setSeparatorViewColor(colorOn: false)
        case true:
            textToReverseTextField.text = ""
            reverseTextLabel.text = ""
            reverseButton.isSelected = false
            reverseButton.alpha = 0.6
        }
    }
    
    func setConstraints() {
        // Top View Constraints
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 88).isActive = true
        
        // Small Title Text Label Constraints
        topTitleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        topTitleTextLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        topTitleTextLabel.leadingAnchor.constraint(equalTo: self.topView.leadingAnchor, constant: 16).isActive = true
        topTitleTextLabel.trailingAnchor.constraint(equalTo: self.topView.trailingAnchor, constant: -16).isActive = true
        topTitleTextLabel.topAnchor.constraint(equalTo: self.topView.centerYAnchor, constant: 12).isActive = true
        
        // Main Title Text Label Constraints
        mainTitleTextLable.translatesAutoresizingMaskIntoConstraints = false
        mainTitleTextLable.heightAnchor.constraint(equalToConstant: 41).isActive = true
        mainTitleTextLable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        mainTitleTextLable.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        mainTitleTextLable.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 152).isActive = true
        
        // Sub Title Text Label Constraints
        subTitleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleTextLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        subTitleTextLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        subTitleTextLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        subTitleTextLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 209).isActive = true
        
        // Input Text View Constraints
        inputTextView.translatesAutoresizingMaskIntoConstraints = false
        inputTextView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        inputTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        inputTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        inputTextView.topAnchor.constraint(equalTo: self.subTitleTextLabel.bottomAnchor, constant: 40).isActive = true
        
        // Text For Reverse Text Field Constraint
        textToReverseTextField.translatesAutoresizingMaskIntoConstraints = false
        textToReverseTextField.heightAnchor.constraint(equalToConstant: 22).isActive = true
        textToReverseTextField.leadingAnchor.constraint(equalTo: inputTextView.leadingAnchor, constant: 16).isActive = true
        textToReverseTextField.trailingAnchor.constraint(equalTo: inputTextView.trailingAnchor, constant: -16).isActive = true
        textToReverseTextField.centerYAnchor.constraint(equalTo: inputTextView.centerYAnchor, constant: 0).isActive = true
        
        // Separator View Constraint
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        separatorView.topAnchor.constraint(equalTo: self.inputTextView.bottomAnchor).isActive = true
        
        // Esreve Ro Ttxet Text Label Constraint
        reverseTextLabel.translatesAutoresizingMaskIntoConstraints = false
        reverseTextLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        reverseTextLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        reverseTextLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 377).isActive = true
        
        // Reverse Button Constraints
        reverseButton.translatesAutoresizingMaskIntoConstraints = false
        reverseButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        reverseButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        reverseButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        reverseButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -66).isActive = true
    }
}

extension MainViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        stringToEditing = textToReverseTextField.text
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textToReverseTextField.hasText == false {
            reverseTextLabel.text = ""
            reverseButton.isEnabled = false
            reverseButton.isSelected = false
            reverseButton.alpha = 0.6
            setSeparatorViewColor(colorOn: false)
        } else if textToReverseTextField.hasText == true && stringToEditing == textToReverseTextField.text {
            return true
        } else if textToReverseTextField.hasText == true && reverseButton.isSelected == true {
            reverseTextLabel.text = ""
            reverseButton.isSelected = false
            setSeparatorViewColor(colorOn: true)
        } else {
            reverseButton.isEnabled = true
            reverseButton.alpha = 1
            setSeparatorViewColor(colorOn: true)
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        setSeparatorViewColor(colorOn: false)
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

extension MainViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
