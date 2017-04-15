//
//  CPFEditView.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/9.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit
import Alamofire

protocol CPFEditViewDelegate {
    func editView(editView:CPFEditView, didChangeText text:String) -> Void
}

class CPFEditView: UITextView {

    var keyboardAccessoryView:CPFKeyboardAccessoryView!
    var titleTextField:UITextField!
    var separateImageView:UIImageView!
    
    var textViewPlaceholderLabel:UILabel!
    
    var editViewDelegate:CPFEditViewDelegate?
    
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
        titleTextField.placeholder = CPFLocalizableTitle("writeArticle_titlePlaceholder")
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
        textViewPlaceholderLabel.text = CPFLocalizableTitle("writeArticle_articlePlaceholder")
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
        editViewDelegate?.editView(editView: self, didChangeText: textView.text)
        highLightText()
    }
    
    func highLightText() -> Void {
        
        let models = CPFMarkdownSyntaxManager.sharedManeger().syntaxModelsFromText(text: text)
        
        let attributedString = NSMutableAttributedString.init(string: text)
        
        let initAttributesDic = [NSFontAttributeName : CPFPingFangSC(weight: .regular, size: 16), NSForegroundColorAttributeName :  UIColor.black]
        attributedString.addAttributes(initAttributesDic, range: NSRange(location: 0, length: attributedString.length))
        
        for item in models {
            var highLightModel = CPFHighLightModel()
            let attributesDic = highLightModel.attributesFromMarkdownSyntaxType(markdownSyntaxType: item.markdownSyntaxType)
            attributedString.addAttributes(attributesDic, range: item.range)
        }
        
        self.isScrollEnabled = false;
        let selectedRange = self.selectedRange;
        self.attributedText = attributedString;
        self.selectedRange = selectedRange;
        self.isScrollEnabled = true;
    }
}

// MARK: - CPFKeyboardAccessoryViewDelegate
extension CPFEditView: CPFKeyboardAccessoryViewDelegate {
    
    func accessoryView(accessoryView: CPFKeyboardAccessoryView, didClickAccessoryItem item: UIButton) {
        
        switch item.tag {
        case 1:
            
            selectImageFromPhotoLibrary()
            
        case 2:
            insertLink(completionHandler: { (linkString) in
                let insertString = "[KaraNotes](\(linkString))"
                self.titleTextField.isFirstResponder ? self.titleTextField.insertText(insertString) : self.insertText(insertString)
                let range = NSRange(location: self.selectedRange.location - insertString.characters.count + 1, length: 9)
                self.selectedRange = range
            })
        case 15:
            resignFirstResponder()
        default:
            resignFirstResponder()
        }
    }
    
    func accessoryView(accessoryView: CPFKeyboardAccessoryView, shouldSendString string: String) {
        titleTextField.isFirstResponder ? titleTextField.insertText(string) : insertText(string)
    }
}

// MARK: - custom methods
extension CPFEditView {
    func insertLink(completionHandler: @escaping (_ linkString:String) -> Void ) -> Void {
        
        let alertCtr = UIAlertController(title: CPFLocalizableTitle("writeArticle_insertLinkAlertTitle"), message: nil, preferredStyle: .alert)
        
        alertCtr.addTextField { (textFiled) in
            textFiled.placeholder = CPFLocalizableTitle("writeArticle_inputLinkPlaceholder")
        }
        let cancelAction = UIAlertAction(title: CPFLocalizableTitle("writeArticle_insertLinkAlertCancel"), style: .cancel) { (alertAction) in
            alertCtr.dismiss(animated: true, completion: nil)
        }
        let insertAction = UIAlertAction(title: CPFLocalizableTitle("writeArticle_insertLinkAlertInsert"), style: .default) { (alertAction) in
            let textField = alertCtr.textFields?.first
            completionHandler((textField?.text)!)
        }
        alertCtr.addAction(cancelAction)
        alertCtr.addAction(insertAction)
        
        let vc = self.viewController(aClass: UIViewController.classForCoder())
        vc?.present(alertCtr, animated: true, completion: nil)
        
    }
    
    func insertImageLink(linkString:String) -> Void {
        
        let insertString = "![KaraNotes](\(linkString))"
        titleTextField.isFirstResponder ? titleTextField.insertText(insertString) :insertText(insertString)
        let range = NSRange(location: self.selectedRange.location - insertString.characters.count + 2, length: 9)
        selectedRange = range
    }
    
    func selectImageFromPhotoLibrary() -> Void {
        let imagePickerCtr = UIImagePickerController()
        imagePickerCtr.sourceType = .photoLibrary
        imagePickerCtr.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        self.viewController(aClass: UIViewController.classForCoder())?.present(imagePickerCtr, animated: true, completion: nil)
    }
    
    
    func uploadData(data:Data, completionHandler: @escaping (_ LinkString:String) -> Void) -> Void {
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(data, withName: "img", fileName: "testName", mimeType: "image/*")
        }, to: CPFNetworkRoute.getAPIFromRouteType(route: .uploadImage),
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (progress) in
                        print("progress...\(progress)")
                    })
                    upload.response { response in
                        print("-------\(response)")
                    }
                case .failure(let encodingError):
                    print("-------\(encodingError)")
                }
        })
    }
}


// MARK: - UIImagePickerController
extension CPFEditView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imageData: Data
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageData = UIImageJPEGRepresentation(image, 0)!
            picker.dismiss(animated: true) {
                self.uploadData(data: imageData, completionHandler: { (linkString) in
                    self.insertImageLink(linkString: linkString)
                })
            }
        }
    }
}
