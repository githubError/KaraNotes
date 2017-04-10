//
//  CPFEditView.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/9.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFEditView: UITextView {

    var keyboardAccessoryView:CPFKeyboardAccessoryView!
    var titleTextField:UITextField!
    var separateImageView:UIImageView!
    
    var textViewPlaceholderLabel:UILabel!
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
        setupSubviews()
    }

}


// MARK: - setup subviews
extension CPFEditView {
    
    func configure() -> Void {
        keyboardAccessoryView = CPFKeyboardAccessoryView()
        keyboardAccessoryView.accessoryViewDelegate = self
        inputAccessoryView = keyboardAccessoryView
        textContainerInset = UIEdgeInsets(top: 55, left: 10, bottom: 0, right: 10)
        font = CPFPingFangSC(weight: .regular, size: 14)
        delegate = self
    }
    
    func setupSubviews() -> Void {
        titleTextField = UITextField()
        addSubview(titleTextField)
        titleTextField.placeholder = "请输入标题"
        titleTextField.font = CPFPingFangSC(weight: .medium, size: 18)
        titleTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(45)
        }
        
        separateImageView = UIImageView()
        addSubview(separateImageView)
        separateImageView.image = UIImage.init(named: "separateLine")
        separateImageView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleTextField.snp.bottom)
            make.height.equalTo(2)
        }
        
        configureTextViewPlaceholderLabel()
    }
    
    func configureTextViewPlaceholderLabel() -> Void {
        textViewPlaceholderLabel = UILabel()
        textViewPlaceholderLabel.text = "请输入正文"
        textViewPlaceholderLabel.font = CPFPingFangSC(weight: .regular, size: 14)
        textViewPlaceholderLabel.textColor = CPFRGB(r: 185, g: 185, b: 185)
        addSubview(textViewPlaceholderLabel)
        textViewPlaceholderLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleTextField).offset(3)
            make.top.equalTo(separateImageView.snp.bottom).offset(3)
            make.height.equalTo(30)
        }
    }
}


// MARK: - UITextViewDelegate
extension CPFEditView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        textViewPlaceholderLabel.isHidden = hasText
    }
}

// MARK: - CPFKeyboardAccessoryViewDelegate
extension CPFEditView: CPFKeyboardAccessoryViewDelegate {
    
    func accessoryView(accessoryView: CPFKeyboardAccessoryView, didClickAccessoryItem item: UIButton) {
        
        switch item.tag {
        case 1:
            print("插入图片")
        case 2:
            print("插入链接")
        case 15:
            resignFirstResponder()
        default:
            resignFirstResponder()
        }
    }
    
    func accessoryView(accessoryView: CPFKeyboardAccessoryView, shouldSendString string: String) {
        insertText(string)
    }
}
