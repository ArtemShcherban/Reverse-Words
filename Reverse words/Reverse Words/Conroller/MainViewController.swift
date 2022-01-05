//
//  ViewController.swift
//  Reverse words
//
//  Created by Artem Shcherban on 13.12.2021.
//

import UIKit

final class MainViewController: UIViewController {
    
    private var reverseWordsModel: ReverseWordsModel!
    private var stringToEditing: String!
    private let appTitle = "Reverse Words"
    
    private lazy var topView: UIView = {
        let tempTopView = UIView()
        tempTopView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 88)
        tempTopView.backgroundColor = .white
        tempTopView.layer.backgroundColor = ThemeConstants.AppColors.dirtyWhiteColor.withAlphaComponent(0.94).cgColor
        tempTopView.layer.shadowPath = UIBezierPath(rect: tempTopView.bounds).cgPath
        tempTopView.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        tempTopView.layer.shadowOpacity = 1
        tempTopView.layer.shadowRadius = 0
        tempTopView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        return tempTopView
    }()
    private lazy var inputTextView: UIView = {
        let tempInputTextView = UIView()
        tempInputTextView.backgroundColor = .white
        tempInputTextView.layer.backgroundColor = UIColor.white.cgColor
        return tempInputTextView
    }()
    
    private lazy var separatorView: UIView = {
        let tempSeparatorView = UIView()
        tempSeparatorView.backgroundColor = .black
        tempSeparatorView.alpha = 0.2
        return tempSeparatorView
    }()
    
    private lazy var topTitleTextLabel: UILabel = {
        let tempTopTitleTextLabel = UILabel()
        tempTopTitleTextLabel.backgroundColor = .clear
        tempTopTitleTextLabel.textColor = .black
        tempTopTitleTextLabel.font = UIFont(name: "SFUIDisplay-Semibold", size: TextConstants.AppFontSize.regularFontSize)
        tempTopTitleTextLabel.attributedText =
            NSMutableAttributedString(string: appTitle,
                                      attributes: [NSAttributedString.Key.kern: TextConstants.AppKernSize.regularKernSize])
        tempTopTitleTextLabel.textAlignment = .center
        return tempTopTitleTextLabel
    }()
    
    private lazy var mainTitleTextLable: UILabel = {
        let tempMainTitleTextLable = UILabel()
        tempMainTitleTextLable.backgroundColor = .white
        tempMainTitleTextLable.textColor = .black
        tempMainTitleTextLable.font = UIFont(name: "SFUIDisplay-Bold", size: TextConstants.AppFontSize.titleFontSize)
        tempMainTitleTextLable.attributedText =
            NSMutableAttributedString(string: appTitle,
                                      attributes: [NSAttributedString.Key.kern: 0.37])
        tempMainTitleTextLable.textAlignment = .center
        return tempMainTitleTextLable
    }()
    
    private lazy var subTitleTextLabel: UILabel = {
        let tempSubTitleTextLabel = UILabel()
        tempSubTitleTextLabel.backgroundColor = .white
        tempSubTitleTextLabel.textColor = ThemeConstants.AppColors.greyColor.withAlphaComponent(0.6)
        tempSubTitleTextLabel.font = UIFont(name: "SFUIDisplay-Regular", size: TextConstants.AppFontSize.regularFontSize)
        tempSubTitleTextLabel.numberOfLines = 0
        tempSubTitleTextLabel.lineBreakMode = .byWordWrapping
        let subTitleText = "This application will reverse your words. Please type text below"
        tempSubTitleTextLabel.attributedText = NSMutableAttributedString(string: subTitleText, attributes: [NSAttributedString.Key.kern: TextConstants.AppKernSize.regularKernSize])
        tempSubTitleTextLabel.textAlignment = .center
        return tempSubTitleTextLabel
    }()
    
    private lazy var reverseTextLabel: UILabel = {
        let tempReverseTextLabel = UILabel()
        tempReverseTextLabel.backgroundColor = .white
        tempReverseTextLabel.textColor = ThemeConstants.AppColors.blueColor
        tempReverseTextLabel.font = UIFont(name: "SFUIDisplay-Regular", size: TextConstants.AppFontSize.subTitleFontSize)
        tempReverseTextLabel.attributedText =
            NSMutableAttributedString(string: " ",
                                      attributes: [NSAttributedString.Key.kern: TextConstants.AppKernSize.regularKernSize])
        return tempReverseTextLabel
    }()
    
    private lazy var textToReverseTextField: UITextField = {
        let tempTextToReverseTextField = UITextField()
        tempTextToReverseTextField.backgroundColor = .white
        tempTextToReverseTextField.textColor = ThemeConstants.AppColors.greyColor
        tempTextToReverseTextField.font = UIFont(name: "SFUIDisplay-Regular", size: TextConstants.AppFontSize.regularFontSize)
        tempTextToReverseTextField.placeholder = "Text to reverse"
        tempTextToReverseTextField.clearButtonMode = .whileEditing
        tempTextToReverseTextField.delegate = self
        return tempTextToReverseTextField
    }()
    
    private lazy var reverseButton: UIButton = {
        let tempReverseButton = UIButton()
        tempReverseButton.backgroundColor = .white
        tempReverseButton.alpha = 0.6
        tempReverseButton.layer.backgroundColor = ThemeConstants.AppColors.blueColor.cgColor
        tempReverseButton.layer.cornerRadius = 14
        tempReverseButton.setTitle("Reverse", for: .normal)
        tempReverseButton.setTitle("Clear", for: .selected)
        tempReverseButton.titleLabel?.font = UIFont(name: "SFUIDisplay-Regular", size: TextConstants.AppFontSize.regularFontSize)
        tempReverseButton.addTarget(self, action: #selector(reverseButtonPressed), for: .touchUpInside)
        tempReverseButton.isEnabled = false
        tempReverseButton.isSelected = false
        return tempReverseButton
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reverseWordsModel = ReverseWordsModel()
        
        addSubViews()
        setConstraints()
        
        self.setupHideKeyboardTapGesture()
    }
    
    private func addSubViews() {
        self.view.addSubview(topView)
        self.view.addSubview(inputTextView)
        self.view.addSubview(separatorView)
        self.view.addSubview(topTitleTextLabel)
        self.view.addSubview(mainTitleTextLable)
        self.view.addSubview(subTitleTextLabel)
        self.view.addSubview(reverseTextLabel)
        self.view.addSubview(textToReverseTextField)
        self.view.addSubview(reverseButton)
        
    }
    
    private func setSeparatorViewColor(colorOn: Bool) {
        if colorOn {
            separatorView.alpha = 1
            separatorView.backgroundColor = ThemeConstants.AppColors.blueColor
        } else {
            separatorView.alpha = 0.2
            separatorView.backgroundColor = .black
        }
    }
    
    @objc func reverseButtonPressed() {
        if reverseButton.isSelected {
            textToReverseTextField.text = ""
            reverseTextLabel.text = ""
            reverseButton.isSelected = false
            reverseButton.isEnabled = false
            reverseButton.alpha = 0.6
            
        } else {
            reverseTextLabel.text = (reverseWordsModel.reverseWords(textToReverseTextField.text ?? ""))
            reverseButton.isSelected = true
            setSeparatorViewColor(colorOn: false)
        
        }
    }
    
    private func setConstraints() {
        // Small Title Text Label Constraints
        topTitleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([topTitleTextLabel.heightAnchor.constraint(equalToConstant: 22),
                                     topTitleTextLabel.leadingAnchor.constraint(equalTo: self.topView.leadingAnchor, constant:
                                                                                    SizesConstants.Indents.leftIndent),
                                     topTitleTextLabel.trailingAnchor.constraint(equalTo: self.topView.trailingAnchor, constant:
                                                                                    SizesConstants.Indents.rightIndent),
                                     topTitleTextLabel.topAnchor.constraint(equalTo: self.topView.centerYAnchor, constant: 12)])
        
        // Main Title Text Label Constraints
        mainTitleTextLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([mainTitleTextLable.heightAnchor.constraint(equalToConstant: 41),
                                     mainTitleTextLable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant:
                                                                                    SizesConstants.Indents.leftIndent),
                                     mainTitleTextLable.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:
                                                                                    SizesConstants.Indents.rightIndent),
                                     mainTitleTextLable.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 152)])
        
        // Sub Title Text Label Constraints
        subTitleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([subTitleTextLabel.heightAnchor.constraint(equalToConstant: 44),
                                     subTitleTextLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant:
                                                                                    SizesConstants.Indents.leftIndent),
                                     subTitleTextLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:
                                                                                    SizesConstants.Indents.rightIndent),
                                     subTitleTextLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 209)])
        
        // Input Text View Constraints
        inputTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([inputTextView.heightAnchor.constraint(equalToConstant: 60),
                                     inputTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     inputTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     inputTextView.topAnchor.constraint(equalTo: self.subTitleTextLabel.bottomAnchor, constant: 40)])
        
        // Text For Reverse Text Field Constraint
        textToReverseTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([textToReverseTextField.heightAnchor.constraint(equalToConstant: 22),
                                     textToReverseTextField.leadingAnchor.constraint(equalTo: inputTextView.leadingAnchor, constant:
                                                                                        SizesConstants.Indents.leftIndent),
                                     textToReverseTextField.trailingAnchor.constraint(equalTo: inputTextView.trailingAnchor, constant:
                                                                                        SizesConstants.Indents.rightIndent),
                                     textToReverseTextField.centerYAnchor.constraint(equalTo: inputTextView.centerYAnchor)])
        
        // Separator View Constraint
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([separatorView.heightAnchor.constraint(equalToConstant: 1),
                                     separatorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant:
                                                                                SizesConstants.Indents.leftIndent),
                                     separatorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:
                                                                                SizesConstants.Indents.rightIndent),
                                     separatorView.topAnchor.constraint(equalTo: self.inputTextView.bottomAnchor)])
        
        // Reverse Text Label Constraint
        reverseTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([reverseTextLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant:
                                                                                SizesConstants.Indents.leftIndent),
                                     reverseTextLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:
                                                                                    SizesConstants.Indents.rightIndent),
                                     reverseTextLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 377)])
    }
    
    private func setReverseButtonConstraints() {
        // Reverse Button Constraints
        reverseButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([reverseButton.heightAnchor.constraint(equalToConstant: 56),
                                     reverseButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant:
                                                                                SizesConstants.Indents.leftIndent),
                                     reverseButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:
                                                                                SizesConstants.Indents.rightIndent),
                                     reverseButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -66)])
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
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.hasText == true {
            reverseButton.isEnabled = true
            reverseButton.alpha = 1
            setSeparatorViewColor(colorOn: true)
        } else {
            reverseButton.isEnabled = false
            reverseButton.alpha = 0.6
            setSeparatorViewColor(colorOn: false)
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        setSeparatorViewColor(colorOn: false)
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()
    }
}

private extension MainViewController {
    func setupHideKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
