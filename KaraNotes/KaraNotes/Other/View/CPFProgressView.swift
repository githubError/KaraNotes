//
//  CPFProgressView.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/11.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFProgressView: UIView {

    static let instance:CPFProgressView = CPFProgressView()
    
    var progressValue:CGFloat! = 0.0 {
        didSet{
            progressFrontgroundBezierPath = UIBezierPath(arcCenter: progressView.center, radius: (progressViewSize.width - progressStrokeWidth - progressCircleMargin) / 2.0, startAngle: -CGFloat(Double.pi / 2.0), endAngle: CGFloat(Double.pi * 2.0) * progressValue - CGFloat(Double.pi / 2.0), clockwise: true)
            progressFrontgroundLayer.path = progressFrontgroundBezierPath.cgPath
        }
    }
    
    var progressPromptText:String! = ""{
        didSet{
            progressPromptLabel.text = ""
            progressPromptLabel.text = progressPromptText
        }
    }
    
    var progressStrokeWidth:CGFloat = 5.0
    var progressColor:UIColor = CPFRGBA(r: 0, g: 118, b: 255, a: 1.0)
    var progressTrackColor:UIColor = CPFRGBA(r: 200, g: 200, b: 200, a: 0.8)
    var progressViewColor:UIColor = UIColor.white
    var dismissBtnTitleColor:UIColor = UIColor.black
    var progressViewSize:CGSize = CGSize(width: 100, height: 100)
    
    fileprivate var progressView:UIView!
    fileprivate var progressPromptLabel:UILabel!
    fileprivate var separateLineView:UIView!
    fileprivate var dismissProgressViewBtn:UIButton!
    fileprivate var progressBackgroundView:UIView!
    fileprivate var progressBackgroundLayer: CAShapeLayer!
    fileprivate var progressFrontgroundLayer: CAShapeLayer!
    fileprivate var progressBackgroundBezierPath:UIBezierPath!
    fileprivate var progressFrontgroundBezierPath:UIBezierPath!
    
    fileprivate let progressCircleMargin:CGFloat = 10.0
    fileprivate let separateLineViewHeight:CGFloat = 1.0
    
    fileprivate var once:Bool = true
    
    static func sharedInstance() -> CPFProgressView {
        if instance.once {
            let window = UIApplication.shared.keyWindow
            instance.frame = (window?.bounds)!
            instance.backgroundColor = CPFRGBA(r: 0, g: 0, b: 0, a: 0.2)
            window?.addSubview(instance)
            instance.setupSubviews()
            
            instance.once = false
        }
        return instance
    }
}

extension CPFProgressView {
    
    func showProgressView(progress:CGFloat, promptMessage message:String) -> Void {
        
        progressValue = progress
        progressPromptText = message
    }
    
    func dismissProgressView() -> Void {
        
        progressView.layer.sublayers?.forEach({ (layer) in
            layer.removeFromSuperlayer()
        })
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        once = true
        removeFromSuperview()
    }
}


// MARK:- setup subviews
extension CPFProgressView {
    
    func setupSubviews() -> Void {
        setupProgressView()
        setupProgressPromptLabel()
        setupSeparateLine()
        setupDismissProgressViewBtn()
        setupProgressBackgroundView()
        
        setupLayer()
    }
    
    func setupProgressView() -> Void {
        let point = CGPoint(x: center.x - progressViewSize.width / 2.0 , y: center.y - progressViewSize.height / 2.0)
        progressView = UIView(frame: CGRect(origin: point, size: progressViewSize))
        addSubview(progressView)
    }
    
    func setupProgressPromptLabel() -> Void {
        progressPromptLabel = UILabel()
        let labelW = progressViewSize.width - 3.0 * progressCircleMargin
        let labelH = CGFloat(50.0)
        let labelX = (progressViewSize.width - labelW) / 2.0
        let labelY = (progressViewSize.height - labelH) / 2.0
        progressPromptLabel.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
        progressPromptLabel.font = CPFPingFangSC(weight: .light, size: 12)
        progressPromptLabel.textAlignment = .center
        progressPromptLabel.numberOfLines = 0
        progressView.addSubview(progressPromptLabel)
    }
    
    func setupSeparateLine() -> Void {
        separateLineView = UIView()
        let x = progressView.frame.origin.x
        let y = progressView.frame.origin.y + progressViewSize.height
        separateLineView.frame = CGRect(x: x, y: y, width: progressViewSize.width, height: separateLineViewHeight)
        separateLineView.backgroundColor = CPFRGBA(r: 158, g: 158, b: 158, a: 0.8)
        addSubview(separateLineView)
    }
    
    func setupDismissProgressViewBtn() -> Void {
        dismissProgressViewBtn = UIButton(type: .custom)
        let btnX = progressView.frame.origin.x
        let btnY = progressView.frame.origin.y + progressViewSize.height + separateLineViewHeight
        dismissProgressViewBtn.frame = CGRect(x: btnX, y: btnY, width: progressViewSize.width, height: 20)
        dismissProgressViewBtn.setTitle(CPFLocalizableTitle("progressView_dismissBtn"), for: .normal)
        dismissProgressViewBtn.titleLabel?.font = CPFPingFangSC(weight: .regular, size: 15)
        dismissProgressViewBtn.setTitleColor(dismissBtnTitleColor, for: .normal)
        dismissProgressViewBtn.addTarget(self, action: #selector(dismissProgressView), for: .touchUpInside)
        addSubview(dismissProgressViewBtn)
    }
    
    func setupProgressBackgroundView() -> Void {
        progressBackgroundView = UIView()
        let x = progressView.frame.origin.x
        let y = progressView.frame.origin.y
        progressBackgroundView.frame = CGRect(x: x, y: y, width: progressViewSize.width, height: progressViewSize.height + dismissProgressViewBtn.frame.size.height + separateLineViewHeight)
        insertSubview(progressBackgroundView, at: 0)
        progressBackgroundView.backgroundColor = progressViewColor
        progressBackgroundView.makeRound(round: 10)
    }
    
    func setupLayer() -> Void {
        
        let point = CGPoint(x: -(center.x - progressViewSize.width / 2.0) , y: -(center.y - progressViewSize.height / 2.0))
        progressBackgroundLayer = CAShapeLayer()
        progressBackgroundLayer.frame = CGRect(origin: point, size: progressViewSize)
        progressView.layer.addSublayer(progressBackgroundLayer)
        progressBackgroundLayer.fillColor = nil
        progressBackgroundLayer.strokeColor = progressTrackColor.cgColor
        progressBackgroundLayer.lineWidth = progressStrokeWidth
        
        progressFrontgroundLayer = CAShapeLayer()
        progressFrontgroundLayer.frame = CGRect(origin: point, size: progressViewSize)
        progressView.layer.addSublayer(progressFrontgroundLayer)
        progressFrontgroundLayer.fillColor = nil
        progressFrontgroundLayer.strokeColor = progressColor.cgColor
        progressFrontgroundLayer.lineWidth = progressStrokeWidth
        progressFrontgroundLayer.lineCap = "round"
        
        progressBackgroundBezierPath = UIBezierPath(arcCenter: progressView.center, radius: (progressViewSize.width - progressStrokeWidth - progressCircleMargin) / 2.0, startAngle: 0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        progressBackgroundLayer.path = progressBackgroundBezierPath.cgPath
    }
}
