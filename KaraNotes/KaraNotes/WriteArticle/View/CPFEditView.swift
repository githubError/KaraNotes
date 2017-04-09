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
        self.inputAccessoryView = keyboardAccessoryView
    }
    
    func setupSubviews() -> Void {
        titleTextField = UITextField()
        addSubview(titleTextField)
        titleTextField.placeholder = "请输入标题"
        titleTextField.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
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
