//
//  PhotoViewModel.swift
//  HoneywellPhotoViewer
//
//  Created by Dutta, Soumitra on 1/20/21.
//

import UIKit

class PhotoViewModel {
   // var notificationDataProvider : notificationDataProviderProtocol
    var reloadNotificationListListTable : (() -> ())?
    lazy var alertMessage = ""
    var showAlert : (() -> ())?
    var isPhotoServiceRunning = false
    
    var showLoader : (() -> ())?
    var hideLoader : (() -> ())?
    var refreshUI : (() -> ())?
    var title = ""
    lazy var photoServiceHelper : PhotoServiceHelperProtocol = PhotoServiceHelper()




    private var arrCellItemViewModels = [PhotoCellItemViewModel]() {
        didSet {
            reloadNotificationListListTable?()
        }
    }
    
    func initFetch() {
    
        photoServiceCall()
    }
    
    private func photoServiceCall(){
        isPhotoServiceRunning = true
        showLoader?()
        photoServiceHelper.photoServiceRequest( successBlock: { [weak self]
            response in
            self?.title = response.title ?? ""
            self?.hideLoader?()
            self?.setupViewModels(arr: response.rows ?? nil)
            self?.refreshUI?()
            self?.isPhotoServiceRunning = false
            },
            failureBlock: { [weak self] response in
                self?.hideLoader?()
                self?.setupViewModels(arr: nil)
                self?.refreshUI?()
                self?.isPhotoServiceRunning = false
                self?.alertMessage = AppConstants.serviceUnavailable
                self?.showAlert?()
        })
    }

    // MARK: - Setup Model List Data Source
    var  numberOfSections : Int {
            return 1
    }
    
    var numberOfRows : Int {
        
        return arrCellItemViewModels.count
    }
    
    var rowHeight : CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: Setup Model And View Model
extension PhotoViewModel {
    
    func setupViewModels(arr: [PhotoData]?){
        var arrViewModels = [PhotoCellItemViewModel]()
        if let arrayPhotos = arr {
        for photo in arrayPhotos {
           arrViewModels.append(createPhotoCellItemViewModel(photo: photo, index: arrViewModels.count))
        }
        }
        arrCellItemViewModels = arrViewModels

        
    }
    
    func createPhotoCellItemViewModel(photo : PhotoData, index: Int) -> PhotoCellItemViewModel {
        
       
        return PhotoCellItemViewModel(lblTitle : photo.title, lblDetails: photo.description, imageUrl: photo.imageHref ?? "", cellIndex : IndexPath(row: index, section: 0))
    }
    
    // MARK: - View Model from Table did select execution
    func executeTableDidSelect(viewController: UIViewController, index: IndexPath) {
        let cellViewModel = getPhotoCellItemViewModel(indexPath: index)
        let storyboard = UIStoryboard(name: AppConstants.mainStoryboardName, bundle: nil)
        let photoDetailsViewController = storyboard.instantiateViewController(withIdentifier: AppConstants.Identifier.photoDetailsViewController) as! PhotoDetailsViewController
        photoDetailsViewController.urlString = cellViewModel.imageUrl
        photoDetailsViewController.header = title
        viewController.navigationController?.pushViewController(photoDetailsViewController, animated: true)
        
    }
}

// MARK: - Fetch ViewModel from Date Source
extension PhotoViewModel{
    func getPhotoCellItemViewModel( indexPath : IndexPath) -> PhotoCellItemViewModel{
        let photCellItemViewModel = arrCellItemViewModels[indexPath.row]
        return photCellItemViewModel
    }
}


struct PhotoCellItemViewModel {
    let lblTitle : String?
    let lblDetails : String?
    let imageUrl : String
    let cellIndex : IndexPath??
}
