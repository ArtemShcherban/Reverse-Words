//
//  ReverseWordsView.swift
//  Reverse words
//
//  Created by Artem Shcherban on 05.01.2022.
//

import UIKit

final class ReverseWordsView: UIView {
    
    private lazy var inputTextView: UIView = {
        let tempInputTextView = UIView()
        tempInputTextView.backgroundColor = .white
        tempInputTextView.layer.backgroundColor = UIColor.white.cgColor
        return tempInputTextView
    }()
    
    lazy var separatorView =  SeparatorView()
    
    private lazy var mainTitleTextLabel: UILabel = {
        let tempMainTitleTextLabel = UILabel()
        tempMainTitleTextLabel.backgroundColor = .white
        tempMainTitleTextLabel.textColor = .black
        tempMainTitleTextLabel.font = UIFont(name: FontConstants.FontName.sfUIDisplayBold,
                                             size: FontConstants.Size.title)
        tempMainTitleTextLabel.attributedText =
        NSMutableAttributedString(string: AppConstants.title,
                                  attributes: [NSAttributedString.Key.kern: 0.37])
        tempMainTitleTextLabel.textAlignment = .center
        return tempMainTitleTextLabel
    }()
    
    private lazy var subTitleTextLabel: UILabel = {
        let tempSubTitleTextLabel = UILabel()
        tempSubTitleTextLabel.backgroundColor = .white
        tempSubTitleTextLabel.textColor = ColorsConstants.greyColor.withAlphaComponent(0.6)
        tempSubTitleTextLabel.font = UIFont(name: FontConstants.FontName.sfUIDisplayRegular,
                                            size: FontConstants.Size.regular)
        tempSubTitleTextLabel.numberOfLines = 0
        tempSubTitleTextLabel.lineBreakMode = .byWordWrapping
        let subTitleText = "This application will reverse your words. Please type text below"
        tempSubTitleTextLabel.attributedText = NSMutableAttributedString(string: subTitleText, attributes: [NSAttributedString.Key.kern: FontConstants.Kern.regular])
        tempSubTitleTextLabel.textAlignment = .center
        return tempSubTitleTextLabel
    }()
    
    lazy var reverseTextLabel: UILabel = {
        let tempReverseTextLabel = UILabel()
        tempReverseTextLabel.backgroundColor = .white
        tempReverseTextLabel.textColor = ColorsConstants.blueColor
        tempReverseTextLabel.font = UIFont(name: FontConstants.FontName.sfUIDisplayRegular,
                                           size: FontConstants.Size.subTitle)
        tempReverseTextLabel.attributedText =
        NSMutableAttributedString(string: " ",
                                  attributes: [NSAttributedString.Key.kern: FontConstants.Kern.regular])
        return tempReverseTextLabel
    }()
    
    lazy var textToReverseTextField: UITextField = {
        let tempTextToReverseTextField = UITextField()
        tempTextToReverseTextField.backgroundColor = .white
        tempTextToReverseTextField.textColor = ColorsConstants.greyColor
        tempTextToReverseTextField.font = UIFont(name: FontConstants.FontName.sfUIDisplayRegular,
                                                 size: FontConstants.Size.regular)
        tempTextToReverseTextField.placeholder = "Text to reverse"
        tempTextToReverseTextField.clearButtonMode = .whileEditing
        return tempTextToReverseTextField
    }()
    
    lazy var reverseButton = ReverseButton()
    
    func addSubViews() {
        self.addSubview(inputTextView)
        self.addSubview(separatorView)
        self.addSubview(mainTitleTextLabel)
        self.addSubview(subTitleTextLabel)
        self.addSubview(reverseTextLabel)
        self.addSubview(textToReverseTextField)
        self.addSubview(reverseButton)
    }
    
    func setupAccessibility() {
        self.accessibilityIdentifier = "ReverseWordsView"
        separatorView.accessibilityIdentifier = "SeparatorView"
        textToReverseTextField.accessibilityIdentifier = "TextToReverse"
        reverseTextLabel.accessibilityIdentifier = "ReverseTextLabel"
        reverseButton.accessibilityIdentifier = "ReverseButton"
    }
    
    func createNavBarAppearence() -> UINavigationBarAppearance {
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 1)
        appearance.shadowColor = UIColor.black.withAlphaComponent(0.3)
        appearance.titleTextAttributes = [NSAttributedString.Key.kern: FontConstants.Kern.regular,
                                          NSAttributedString.Key.font:
                                            UIFont(name: FontConstants.FontName.sfUIDisplaySemibold,
                                                   size: FontConstants.Size.regular) as Any]
        return appearance
    }
    
    func setConstraints() {
        // Main Title Text Label Constraints
        mainTitleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([mainTitleTextLabel.heightAnchor.constraint(equalToConstant: 41),
                                     mainTitleTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                                                 constant:
                                                                                    SizeConstants.Indents.left),
                                     mainTitleTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                                                  constant:
                                                                                    SizeConstants.Indents.right),
                                     mainTitleTextLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 152)])
        
        // Sub Title Text Label Constraints
        subTitleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([subTitleTextLabel.heightAnchor.constraint(equalToConstant: 44),
                                     subTitleTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                                                constant:
                                                                                    SizeConstants.Indents.left),
                                     subTitleTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                                                 constant: SizeConstants.Indents.right),
                                     subTitleTextLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 209)])
        
        // Input Text View Constraints
        inputTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([inputTextView.heightAnchor.constraint(equalToConstant: 60),
                                     inputTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                     inputTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                     inputTextView.topAnchor.constraint(equalTo: self.subTitleTextLabel.bottomAnchor, constant: 40)])
        
        // Text For Reverse Text Field Constraint
        textToReverseTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([textToReverseTextField.heightAnchor.constraint(equalToConstant: 22),
                                     textToReverseTextField.leadingAnchor.constraint(equalTo:
                                                                                        inputTextView.leadingAnchor, constant: SizeConstants.Indents.left),
                                     textToReverseTextField.trailingAnchor.constraint(equalTo:
                                                                                        inputTextView.trailingAnchor,
                                                                               constant: SizeConstants.Indents.right),
                                     textToReverseTextField.centerYAnchor.constraint(equalTo: inputTextView.centerYAnchor)])
        
        // Separator View Constraint
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                                            constant: SizeConstants.Indents.left),
                                     separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                                            constant: SizeConstants.Indents.right),
                                     separatorView.topAnchor.constraint(equalTo: self.inputTextView.bottomAnchor)])
        
        // Reverse Text Label Constraint
        reverseTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([reverseTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                                            constant: SizeConstants.Indents.left),
                                     reverseTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                                            constant: SizeConstants.Indents.right),
                                     reverseTextLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 377)])
    }
    
    func setReverseButtonConstraints() {
        // Reverse Button Constraints
        reverseButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([reverseButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                                            constant: SizeConstants.Indents.left),
                                     reverseButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                                            constant: SizeConstants.Indents.right),
                                     reverseButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -66)])
    }
}
