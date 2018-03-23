//
//  DetailPostViewController.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class DetailPostViewController: UIViewController, BindableType {
   
   var viewModel: DetailViewModel!
   var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
      
      view.backgroundColor = .white
      self.navigationItem.title = "Detail"
      
      setupTableView()

    }

   //MARK: - Setup Tableview appearance
   fileprivate func setupTableView() {
      tableView = UITableView(frame: self.view.bounds)
      view.addSubview(tableView)
      tableView.register(ListPostTableViewCell.self)
      tableView.rowHeight = 500
      tableView.separatorStyle = .none
   }
   
   
}

extension DetailPostViewController {
   func bindViewModel() {
   
      viewModel.item.asDriver()
         .drive(tableView.rx.items(cellIdentifier: ListPostTableViewCell.identifier, cellType:  ListPostTableViewCell.self)) { index, model, cell in
            cell.configure(with: model)
         }.disposed(by: self.rx.disposeBag)
      
      // Bind screen orientation
      self.rx.sentMessage(#selector(viewWillTransition(to:with:)))
         .map { return $0[0] as! CGSize }
         .subscribe(onNext: { [unowned self] size in
            self.tableView.frame.size = size
         }).disposed(by: self.rx.disposeBag)
   }
}
