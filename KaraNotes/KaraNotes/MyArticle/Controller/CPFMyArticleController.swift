//
//  CPFMyArticleController.swift
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/2/15.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

import UIKit

class CPFMyArticleController: BaseViewController {
    
    fileprivate var tableView: UITableView!
    
    fileprivate let CellID: String = "MyArticleCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }

}

extension CPFMyArticleController {
    
    func setupSubviews() -> Void {
        setupTableView()
    }
    
    func setupTableView() -> Void {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(CPFMyArticleCell.self, forCellReuseIdentifier: CellID)
        tableView.separatorStyle = .singleLineEtched
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
    }
}


extension CPFMyArticleController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID) as! CPFMyArticleCell
        cell.selectionStyle = .none
        
        cell.myArticleModel = CPFMyArticleModel()
        
        cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.white : CPFRGB(r: 240, g: 240, b: 240)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("点击:\(indexPath.row)")
    }
}
