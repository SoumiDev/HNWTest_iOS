//
//  HomeViewController.swift
//  HoneywellPhotoViewer
//
//  Created by Dutta, Soumitra on 1/20/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tablePhoto: UITableView!
    lazy var photoServiceHelper : PhotoServiceHelperProtocol = PhotoServiceHelper()
    var isPhotoServiceRunning = false
    lazy var viewModel : PhotoViewModel =
        {
            return PhotoViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        registerCells()
        initViewModel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.isHidden = false
        tablePhoto.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        PhotoDownloadManager.shared.clearCache()
    }
    
    func setUpTableView(){
        tablePhoto.estimatedRowHeight = CGFloat(AppConstants.tablePhotoEstimatedRowHeight)
        tablePhoto.rowHeight = UITableView.automaticDimension
        tablePhoto.estimatedSectionHeaderHeight = CGFloat(AppConstants.tablePhotoEstimatedHeaderHeight)
        tablePhoto.sectionHeaderHeight = UITableView.automaticDimension
        tablePhoto.layer.masksToBounds = true
        tablePhoto.layer.borderWidth = 2
        tablePhoto.layer.borderColor = AppConstants.customColor.customBlue.cgColor
    }
    
    func registerCells() {
        tablePhoto.register(UINib(nibName: AppConstants.defaultTableHeaderViewName, bundle: nil), forHeaderFooterViewReuseIdentifier: DefaultTableHeaderView.reuseIdentifier)
    }
    
    
    
    
    
}

extension HomeViewController {
    
    func initViewModel() {
        if NetworkMonitoringManager.shared.isConnectionAvailable{
            viewModel.initFetch()
        }
        else {
                   
            CommonAlertView.showCommonAlert(viewController: self, title: AppConstants.projectName, message: AppConstants.networkNotAvailable, OkButtonTitle: AppConstants.okAlertTitle)
        }
        
        viewModel.reloadNotificationListListTable = {
            DispatchQueue.main.async { [weak self] in
                self?.tablePhoto.reloadData()
                self?.title = self?.viewModel.title
            }
        }
        
        viewModel.showLoader = { [weak self] in
            DispatchQueue.main.async {
            LoadingOverlay.shared.showOverlay(view: self?.view)
            }
        }
        
        viewModel.hideLoader = {
            DispatchQueue.main.async {
                LoadingOverlay.shared.hideOverlayView()
            }
        }
        
        
        viewModel.refreshUI = { [weak self] in
            self!.refreshView()
        }
        
        viewModel.showAlert = { [weak self] in
            DispatchQueue.main.async {
            CommonAlertView.showCommonAlert(viewController: self!, title: AppConstants.projectName, message: self!.viewModel.alertMessage, OkButtonTitle: AppConstants.okAlertTitle)
            }
        }
        
    }
}

extension HomeViewController {
    
    func refreshView() {
        DispatchQueue.main.async { [weak self] in
            self?.tablePhoto.reloadData()
        }
    }
}

// MARK: - Table view data source & Delegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.Identifier.photoItemCell, for: indexPath) as! PhotoItemCell
        // Configure the cell...
        let cellViewModel = viewModel.getPhotoCellItemViewModel(indexPath: indexPath)
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        cell.cellItemViewModel = cellViewModel
        
        PhotoDownloadManager.shared.setUpThumbnailImage(imageView: cell.img, tableView: tableView,  indexPath: indexPath, urlString: cellViewModel.imageUrl)
        
        return cell
        
        
    }
    
    
    
    // MARK: Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        viewModel.executeTableDidSelect(viewController: self, index: indexPath)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    
}

