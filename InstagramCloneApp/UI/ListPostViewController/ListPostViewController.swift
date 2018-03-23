//
//  ViewController.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import UIKit
import RxSwift
import NSObject_Rx
import RxCocoa


class ListPostViewController: UIViewController, BindableType {
   
   var viewModel: ListPostViewModel!
   private let bag = DisposeBag()
   fileprivate var tableView: UITableView!
   fileprivate var isLoading = false
  
  fileprivate lazy var loadingView:UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    activityIndicator.hidesWhenStopped = true
    return activityIndicator
    
  }()
  
  fileprivate lazy var refresher:UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    refreshControl.addTarget(self, action: #selector(self.refreshing), for: .valueChanged)
    return refreshControl
  }()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // view appearance setup
      setupAppearance()
      setupTableView()
      setupLoadingView()
      
      ReachabilityManager.shared.isConnected
         .subscribe(onNext: { [weak self] value in
            self?.isLoading = value
         }).disposed(by: bag)
      
   }
  
   //MARK: - Setup View appearance
   fileprivate func setupAppearance() {
      view.backgroundColor = .white
      self.navigationItem.title = "Instagram"
      let leftButtonItem = UIBarButtonItem(image: UIImage(named: "camera"), style: .done, target: nil, action: nil)
      let rightButtonItem = UIBarButtonItem(image: UIImage(named: "share"), style: .done, target: nil, action: nil)
      self.navigationItem.leftBarButtonItem = leftButtonItem
      self.navigationItem.rightBarButtonItem = rightButtonItem
      self.navigationItem.leftBarButtonItem?.tintColor = .black
      self.navigationItem.rightBarButtonItem?.tintColor = .black
   }
   
    //MARK: - Setup Tableview appearance
   fileprivate func setupTableView() {
      tableView = UITableView(frame: UIScreen.main.bounds)
      tableView.contentMode = .redraw
      view.addSubview(tableView)
      tableView.register(ListPostTableViewCell.self)
      tableView.estimatedRowHeight  = 500
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.separatorStyle = .none
      tableView.addSubview(refresher)
   }
   
   //MARK: - Setup loading indicator
  fileprivate func setupLoadingView() {
    loadingView.center = self.view.center
    self.view.addSubview(loadingView)
    loadingView.startAnimating()
  }
  
   @objc fileprivate func refreshing() {
      guard isLoading else {
          refresher.endRefreshing()
         return
      }
      viewModel.loadData()
   }
     
}

// MARK: - Rxbinding main
extension ListPostViewController {
   func bindViewModel() {
      
      // Bind value to table view
      viewModel.posts.asDriver()
         .do(onNext: { [weak self] posts in
            guard posts.count > 0 else { return }
            self?.loadingView.stopAnimating()
            self?.refresher.endRefreshing()
         })
         .drive(tableView.rx.items(cellIdentifier: ListPostTableViewCell.identifier, cellType:  ListPostTableViewCell.self)) { index, model, cell in
            cell.configure(with: model)
         }
         .disposed(by: self.rx.disposeBag)
      
      // Bind item selected to view model detail
      tableView.rx.itemSelected
         .do(onNext: { [unowned self] indexPath in
            self.tableView.deselectRow(at: indexPath, animated: false)
         })
         .map { [unowned self] indexPath -> Post in
            return self.viewModel.posts.value[indexPath.row]
         }
         .subscribe(viewModel.detailAction.inputs)
         .disposed(by: self.rx.disposeBag)
      
      // Bind loading more pagaintion
      tableView.rx.didEndDragging
         .debounce(0.5, scheduler: MainScheduler.instance)
         .withLatestFrom(tableView.rx.contentOffset)
         .filter { [unowned self] _ -> Bool in
            return self.tableView.isReachBottom(with: 500)
         }
         .subscribe(onNext: { [weak self] value in
            self?.viewModel.fetchMorePage()
         }).disposed(by: self.rx.disposeBag)
      
      // Bind screen orientation
      self.rx.sentMessage(#selector(viewWillTransition(to:with:)))
         .map { return $0[0] as! CGSize }
         .subscribe(onNext: { [unowned self] size in
            self.tableView.frame.size = size
         }).disposed(by: self.rx.disposeBag)
   }
   
}

// MARK: -  Helper
fileprivate extension UIScrollView {
    fileprivate func isReachBottom(with offset: CGFloat) -> Bool {
      return self.contentOffset.y + self.frame.size.height + offset > self.contentSize.height
   }
}





