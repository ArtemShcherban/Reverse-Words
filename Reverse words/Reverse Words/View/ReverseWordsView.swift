//
//  ReverseWordsView.swift
//  Reverse words
//
//  Created by Artem Shcherban on 05.01.2022.
//

import UIKit

final class ReverseWordsView: UIView {
    
    lazy var resultSwitch = ResultSwitch()
    
    lazy var resultSwitchTextLabel: UILabel = {
     let tempResultSwitchTextLabel = UILabel()
        tempResultSwitchTextLabel.backgroundColor = .white
        tempResultSwitchTextLabel.textColor = ColorsConstants.greyColor.withAlphaComponent(0.2)
        tempResultSwitchTextLabel.font = UIFont(name: FontConstants.FontName.sfUIDisplayRegular, size: FontConstants.Size.regular)
        tempResultSwitchTextLabel.numberOfLines = 0
        tempResultSwitchTextLabel.lineBreakMode = .byWordWrapping
        tempResultSwitchTextLabel.attributedText = NSMutableAttributedString(string: "result in real time",
                                                                         attributes: [NSAttributedString.Key.kern:
                                                                                       FontConstants.Kern.regular])
        tempResultSwitchTextLabel.textAlignment = .left
        
        return tempResultSwitchTextLabel
    }()
    
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
    
     lazy var subTitleTextLabel: UILabel = {
        let tempSubTitleTextLabel = UILabel()
         tempSubTitleTextLabel.backgroundColor = .white
         tempSubTitleTextLabel.textColor = ColorsConstants.greyColor.withAlphaComponent(0.6)
         tempSubTitleTextLabel.font = UIFont(name: FontConstants.FontName.sfUIDisplayRegular, size: FontConstants.Size.regular)
         tempSubTitleTextLabel.numberOfLines = 0
         tempSubTitleTextLabel.lineBreakMode = .byWordWrapping
         tempSubTitleTextLabel.attributedText = NSMutableAttributedString(string: RulesConstants.mainRule,
                                                                          attributes: [NSAttributedString.Key.kern:
                                                                                        FontConstants.Kern.regular])
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
    
    lazy var textToReverseTextField: ReverseWordsTextField = {
        let tempTextToReverseTextField = ReverseWordsTextField()
        tempTextToReverseTextField.placeholder = "Text to reverse"
        return tempTextToReverseTextField
    }()
    
    lazy var textToIgnoreTextField: ReverseWordsTextField = {
        let tempTextToIgnoreTextField = ReverseWordsTextField()
        tempTextToIgnoreTextField.placeholder = "Text to ignore"
        tempTextToIgnoreTextField.borderStyle = .roundedRect
        return tempTextToIgnoreTextField
    }()
    
    lazy var segmentControl = RulesSegmentControl(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    lazy var reverseButton = ReverseButton()
    
    func addSubViews() {
        self.addSubview(resultSwitch)
        self.addSubview(resultSwitchTextLabel)
        self.addSubview(inputTextView)
        self.addSubview(separatorView)
        self.addSubview(mainTitleTextLabel)
        self.addSubview(subTitleTextLabel)
        self.addSubview(reverseTextLabel)
        self.addSubview(textToReverseTextField)
        self.addSubview(segmentControl)
        self.addSubview(reverseButton)
    }
    
    func addTextToIgnoreTextField() {
        self.addSubview(textToIgnoreTextField)
    }
    
    func removeTextToIgnoreTextField() {
        textToIgnoreTextField.removeFromSuperview()
    }
    
    func setupAccessibility() {
        self.accessibilityIdentifier = "ReverseWordsView"
        separatorView.accessibilityIdentifier = "SeparatorView"
        textToReverseTextField.accessibilityIdentifier = "TextToReverse"
        reverseTextLabel.accessibilityIdentifier = "ReverseTextLabel"
        reverseButton.accessibilityIdentifier = "ReverseButton"
        segmentControl.accessibilityIdentifier = "RulesSegmentControl"
        textToIgnoreTextField.accessibilityIdentifier = "TextToIgnore"
        resultSwitch.accessibilityIdentifier = "ResultSwitch"
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
        NSLayoutConstraint.activate([subTitleTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
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
                                     inputTextView.topAnchor.constraint(equalTo: self.mainTitleTextLabel.bottomAnchor, constant: 100)])
        
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
                                     reverseTextLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 372)])
    }
    
    func setResultSwitchConstraint() {
        resultSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([resultSwitch.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:
                                                                            SizeConstants.Indents.left),
                                     resultSwitch.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12)])
        
        resultSwitchTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([resultSwitchTextLabel.leadingAnchor.constraint(equalTo: resultSwitch.trailingAnchor,
                                                                                    constant: 10),
                                     resultSwitchTextLabel.topAnchor.constraint(equalTo: resultSwitch.topAnchor),
                                     resultSwitchTextLabel.widthAnchor.constraint(equalToConstant: 120),
                                     resultSwitchTextLabel.heightAnchor.constraint(equalTo: resultSwitch.heightAnchor)])
        
    }
    
    func setRulesSegmentControlConstraints() {
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([segmentControl.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                                                  constant: SizeConstants.Indents.left),
                                     segmentControl.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                                                   constant: SizeConstants.Indents.right),
                                     segmentControl.topAnchor.constraint(equalTo: inputTextView.bottomAnchor,
                                                                              constant: 65)])
    }
    
    func setTextToIgnoreTextFieldConstraints() {
        textToIgnoreTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([textToIgnoreTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                                                  constant: SizeConstants.Indents.left),
                                     textToIgnoreTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                                                   constant: SizeConstants.Indents.right),
                                     textToIgnoreTextField.topAnchor.constraint(equalTo: segmentControl.bottomAnchor,
                                                                              constant: 18)])
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
