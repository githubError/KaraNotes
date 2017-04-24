//
//  CPFSearchController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/4/24.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFSearchController: BaseViewController {
    
    fileprivate var searchBar:UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
    
}


// MARK: - setup subviews
extension CPFSearchController {
    func setupSubviews() -> Void {
        
        view.backgroundColor = UIColor.purple
        
        setupNavSearchBar()
    }
    
    func setupNavSearchBar() -> Void {
        let titleView = UIView()
        titleView.frame = CGRect(x: 0, y: 0, width: CPFScreenW, height: 30)
        
        searchBar = UISearchBar()
        searchBar.setBackgroundImage(UIImage.init(), for: .any, barMetrics: .default)
        searchBar.setImage(UIImage.init(named: "search")?.scaleToSize(newSize: CGSize(width: 15, height: 15)), for: .search, state: .normal)
        searchBar.backgroundColor = UIColor.clear
        searchBar.placeholder = CPFLocalizableTitle("attention_search_placeholder")
        searchBar.tintColor = UIColor.white
        let textFiled:UITextField = searchBar.value(forKeyPath: "_searchField") as! UITextField
        textFiled.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        textFiled.backgroundColor = CPFRGBA(r: 0, g: 0, b: 0, a: 0.4)
        textFiled.textColor = UIColor.white
        titleView.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        navigationItem.titleView = titleView
    }
}
