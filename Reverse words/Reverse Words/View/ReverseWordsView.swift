//
//  ReverseWordsView.swift
//  Reverse words
//
//  Created by Artem Shcherban on 05.01.2022.
//

import UIKit

final class ReverseWordsView: UIView {
    
    private let appTitle = "Reverse Words"
    
    private lazy var topView: UIView = {
        let tempTopView = UIView()
        tempTopView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 88)
        tempTopView.backgroundColor = .white
        tempTopView.layer.backgroundColor = ColorsConstants.dirtyWhiteColor.withAlphaComponent(0.94).cgColor
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
        tempTopTitleTextLabel.font = UIFont(name: "SFUIDisplay-Semibold", size: FontConstants.Size.regular)
        tempTopTitleTextLabel.attributedText =
            NSMutableAttributedString(string: appTitle,
                                      attributes: [NSAttributedString.Key.kern: FontConstants.Kern.regular])
        tempTopTitleTextLabel.textAlignment = .center
        return tempTopTitleTextLabel
    }()
    
    private lazy var mainTitleTextLabel: UILabel = {
        let tempMainTitleTextLabel = UILabel()
        tempMainTitleTextLabel.backgroundColor = .white
        tempMainTitleTextLabel.textColor = .black
        tempMainTitleTextLabel.font = UIFont(name: "SFUIDisplay-Bold", size: FontConstants.Size.title)
        tempMainTitleTextLabel.attributedText =
            NSMutableAttributedString(string: appTitle,
                                      attributes: [NSAttributedString.Key.kern: 0.37])
        tempMainTitleTextLabel.textAlignment = .center
        return tempMainTitleTextLabel
    }()
    
    private lazy var subTitleTextLabel: UILabel = {
        let tempSubTitleTextLabel = UILabel()
        tempSubTitleTextLabel.backgroundColor = .white
        tempSubTitleTextLabel.textColor = ColorsConstants.greyColor.withAlphaComponent(0.6)
        tempSubTitleTextLabel.font = UIFont(name: "SFUIDisplay-Regular", size: FontConstants.Size.regular)
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
        tempReverseTextLabel.font = UIFont(name: "SFUIDisplay-Regular", size: FontConstants.Size.subTitle)
        tempReverseTextLabel.attributedText =
            NSMutableAttributedString(string: " ",
                                      attributes: [NSAttributedString.Key.kern: FontConstants.Kern.regular])
        return tempReverseTextLabel
    }()
    
    lazy var textToReverseTextField: UITextField = {
        let tempTextToReverseTextField = UITextField()
        tempTextToReverseTextField.backgroundColor = .white
        tempTextToReverseTextField.textColor = ColorsConstants.greyColor
        tempTextToReverseTextField.font = UIFont(name: "SFUIDisplay-Regular", size: FontConstants.Size.regular)
        tempTextToReverseTextField.placeholder = "Text to reverse"
        tempTextToReverseTextField.clearButtonMode = .whileEditing
        return tempTextToReverseTextField
    }()
    
    lazy var reverseButton: UIButton = {
        let tempReverseButton = UIButton()
        tempReverseButton.backgroundColor = .white
        tempReverseButton.alpha = 0.6
        tempReverseButton.layer.backgroundColor = ColorsConstants.blueColor.cgColor
        tempReverseButton.layer.cornerRadius = 14
        tempReverseButton.setTitle("Reverse", for: .normal)
        tempReverseButton.setTitle("Clear", for: .selected)
        tempReverseButton.titleLabel?.font = UIFont(name: "SFUIDisplay-Regular", size: FontConstants.Size.regular)
        tempReverseButton.isEnabled = false
        tempReverseButton.isSelected = false
        return tempReverseButton
    }()
    
    func addSubViews() {
        self.addSubview(topView)
        self.addSubview(inputTextView)
        self.addSubview(separatorView)
        self.addSubview(topTitleTextLabel)
        self.addSubview(mainTitleTextLabel)
        self.addSubview(subTitleTextLabel)
        self.addSubview(reverseTextLabel)
        self.addSubview(textToReverseTextField)
        self.addSubview(reverseButton)
    }
    
    func setSeparatorViewColor(colorOn: Bool) {
        if colorOn {
            separatorView.alpha = 1
            separatorView.backgroundColor = ColorsConstants.blueColor
        } else {
            separatorView.alpha = 0.2
            separatorView.backgroundColor = .black
        }
    }
    
    func setConstraints() {
        // Small Title Text Label Constraints
        topTitleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([topTitleTextLabel.heightAnchor.constraint(equalToConstant: 22),
                                     topTitleTextLabel.leadingAnchor.constraint(equalTo: self.topView.leadingAnchor,
                                                                                constant: SizeConstants.Indents.left),
                                     topTitleTextLabel.trailingAnchor.constraint(equalTo: self.topView.trailingAnchor,
                                                                                 constant: SizeConstants.Indents.right),
                                     topTitleTextLabel.topAnchor.constraint(equalTo: self.topView.centerYAnchor, constant: 12)])
        
        // Main Title Text Label Constraints
        mainTitleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([mainTitleTextLabel.heightAnchor.constraint(equalToConstant: 41),
                                     mainTitleTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:
                                                                                    SizeConstants.Indents.left),
                                     mainTitleTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:
                                                                                    SizeConstants.Indents.right),
                                     mainTitleTextLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 152)])
        
        // Sub Title Text Label Constraints
        subTitleTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([subTitleTextLabel.heightAnchor.constraint(equalToConstant: 44),
                                     subTitleTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:
                                                                                    SizeConstants.Indents.left),
                                     subTitleTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:
                                                                                    SizeConstants.Indents.right),
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
                                         inputTextView.trailingAnchor, constant: SizeConstants.Indents.right),
                                     textToReverseTextField.centerYAnchor.constraint(equalTo: inputTextView.centerYAnchor)])
        
        // Separator View Constraint
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([separatorView.heightAnchor.constraint(equalToConstant: 1),
                                     separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:
                                                                                SizeConstants.Indents.left),
                                     separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:
                                                                                SizeConstants.Indents.right),
                                     separatorView.topAnchor.constraint(equalTo: self.inputTextView.bottomAnchor)])
        
        // Reverse Text Label Constraint
        reverseTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([reverseTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:
                                                                                SizeConstants.Indents.left),
                                     reverseTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:
                                                                                    SizeConstants.Indents.right),
                                     reverseTextLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 377)])
    }
    
    func setReverseButtonConstraints() {
        // Reverse Button Constraints
        reverseButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([reverseButton.heightAnchor.constraint(equalToConstant: 56),
                                     reverseButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:
                                                                                SizeConstants.Indents.left),
                                     reverseButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:
                                                                                SizeConstants.Indents.right),
                                     reverseButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -66)])
    }
}
