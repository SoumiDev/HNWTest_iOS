//
//  AppConstants.swift
//  HoneywellPhotoViewer
//
//  Created by Dutta, Soumitra on 1/20/21.
//

import UIKit

struct AppConstants {
    
    static let mainStoryboardName = "Main"
    static let launchScreenName = "LaunchScreen"
    static let defaultTableHeaderViewName = "DefaultTableHeaderView"
    
    struct Identifier {
        static let welcomeViewController = "WelcomeVC"
        static let homeViewController = "HomeVC"
        static let defaultTableHeaderView = "DefaultTableHeaderView"
        static let photoItemCell = "PhotoItemCell"
        static let photoDetailsViewController = "PhotoDetailsVC"
    }
    
    struct ImageName {
        static let noImage = "NoImage"
        static let no_Image = "No_Image"
    }
    struct ViewAnimation {
        static let initialWidth: CGFloat = 500.0
        static let initialHeight: CGFloat = 300.0
        static let finalWidth: CGFloat = 250.0
        static let finalHeight: CGFloat = 150.0
    }
    
    struct PhotoObject {
        static let photoTitle = "title"
        static let description = "description"
        static let photoUrl = "imageHref"
    }
    
    static let photoSectionHeader = "Album"
    static let error = "Error"
    static let projectName = "Honewell PhotViewer"
    static let networkNotAvailable = "Network not available.Please check your internet connection."
    static let noInternetConnection = "No internet connection available. Pease try again later."
    static let  okAlertTitle = "OK"
    static let arrayDownLoadingQueue = "ArrayDownLoadingQueue"
    static let thumbImageDownload = "ThumbImageDownload"
    static let mainImageDownload = "MainImageDownload"
    static let photoDetails = "Photo Details"
    static let serviceUnavailable = "Service is currently unavailable. Please try agagin later."
    static let tablePhotoEstimatedRowHeight = 80
    static let tablePhotoEstimatedHeaderHeight = 60
    static let welcomScreenTitle = "Photo Viewer \n Experince Amazing Photo App."
    
    struct customColor {
       static let customBlue = UIColor(red: 13/255.0, green: 25/255.0, blue: 51/255.0, alpha: 1.0)
    }
}

