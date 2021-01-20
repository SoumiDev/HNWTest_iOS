//
//  PhotoDownloadManager.swift
//  HoneywellPhotoViewer
//
//  Created by Dutta, Soumitra on 1/20/21.
//

import UIKit
class PhotoDownloadManager {
    
    static let shared = PhotoDownloadManager()
    var task: URLSessionDownloadTask!
    var session: URLSession!
    lazy var cache:NSCache<AnyObject, AnyObject>! = NSCache()
    var arrDownloading = [String]()
    let serialQueue = DispatchQueue(label: AppConstants.arrayDownLoadingQueue)

    // MARK:- Set Up Thumbnail Image

    func setUpThumbnailImage(imageView: UIImageView,tableView: UITableView, indexPath : IndexPath, urlString : String){
        let keyIndex = "\(indexPath.section)_\(indexPath.row)"
        if (self.cache.object(forKey: keyIndex as AnyObject) != nil){
            //Cached image used, no need to download it.
                imageView.image = cache.object(forKey: keyIndex as AnyObject) as? UIImage
        }
        else if arrDownloading.contains(keyIndex) {
            //Current Image is downloading. Wait to get image downloaded.
            return
        }
        else if NetworkMonitoringManager.shared.isConnectionAvailable {
            initiateThumbNailImageDownloading(tableView: tableView, indexPath: indexPath, urlString: urlString)
        }
    }
    
    
    
    // MARK:- Thumbnail Image Download

    func initiateThumbNailImageDownloading(tableView: UITableView, indexPath : IndexPath, urlString : String) {
        let keyIndex = "\(indexPath.section)_\(indexPath.row)"
        let dispatchQueue = DispatchQueue(label: AppConstants.thumbImageDownload + keyIndex)
        //perform task in a background thread
        dispatchQueue.async { [weak self] in
            if let url = URL(string: urlString) {
                // Track Key reference of image downloading
                self?.updateDownLoadingContains(shouldAdd: true, keyIndex: keyIndex)
                let request: URLRequest = URLRequest(url: url)
                let sessionConfig = URLSessionConfiguration.default
                sessionConfig.timeoutIntervalForRequest = Websettings.shared.requestTimeOut
                sessionConfig.timeoutIntervalForResource = Websettings.shared.requestTimeOut
                let session = URLSession(configuration: sessionConfig)
                let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
                    let error = error
                    let data = data
                    if error == nil {
                        // Download Completed. Remove key reference from Array
                        self?.updateDownLoadingContains(shouldAdd: false, keyIndex: keyIndex)
                        // Convert the downloaded data in to a UIImage object
                        if let image = UIImage(data: data!) {
                        // Store the image into cache
                        self!.cache.setObject(image, forKey: keyIndex as AnyObject)
                        // Update the cell content
                        DispatchQueue.main.async(execute: { () -> Void in
                            if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
                                let imageView = cell.contentView.viewWithTag(1) as! UIImageView
                                // Update UIImage
                                imageView.image = image
                            }
                        })
                      }
                    }
                    else {
                        // Download Failed. Remove key reference from Array to redownload image.
                        self?.updateDownLoadingContains(shouldAdd: false, keyIndex: keyIndex)

                    }
                })
                task.resume()
            }
            
        }
        
    }
    
     // MARK:- Set Up Main Image
    
    func setUpMainImage(imageView: UIImageView, urlString : String){
        let keyIndex = urlString
        if (self.cache.object(forKey: keyIndex as AnyObject) != nil){
            //Cached image used, no need to download it
            imageView.image = cache.object(forKey: keyIndex as AnyObject) as? UIImage
        }
        else if arrDownloading.contains(keyIndex) {
            //Current Image is downloading. Wait to get image downloaded.
            return
        }
        else if NetworkMonitoringManager.shared.isConnectionAvailable {
            initiateMainImageDownloading(imageView: imageView, urlString: urlString)
        }
    }
    
    
    // MARK:- Main Image Download
    func initiateMainImageDownloading(imageView: UIImageView?,urlString : String) {
        let keyIndex = urlString
        let dispatchQueue = DispatchQueue(label: AppConstants.mainImageDownload + keyIndex)
        //perform task in a background thread
        dispatchQueue.async { [weak self] in
            // Track Key reference of image downloading
            self?.updateDownLoadingContains(shouldAdd: true, keyIndex: keyIndex)
            if let url = URL(string: urlString) {
                let request: URLRequest = URLRequest(url: url)
                let sessionConfig = URLSessionConfiguration.default
                sessionConfig.timeoutIntervalForRequest = Websettings.shared.requestTimeOut
                sessionConfig.timeoutIntervalForResource = Websettings.shared.requestTimeOut
                let session = URLSession(configuration: sessionConfig)
                let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
                    let error = error
                    let data = data
                    if error == nil {
                        // Download Completed. Remove key reference from Array
                        self?.updateDownLoadingContains(shouldAdd: false, keyIndex: keyIndex)
                        // Convert the downloaded data in to a UIImage object
                        if let image = UIImage(data: data!) {
                            // Store the image into cache
                            self!.cache.setObject(image, forKey: keyIndex as AnyObject)
                            // Update UIImage
                            DispatchQueue.main.async(execute: { () -> Void in
                                if let imageVw = imageView {
                                    imageVw.image = image
                                }
                            })
                            
                        }
                    }
                    else {
                        // Download Failed. Remove key reference from Array to redownload image.
                        self?.updateDownLoadingContains(shouldAdd: false, keyIndex: keyIndex)
                    }

                })
                task.resume()
            }

        }
        
    }
    
}



extension PhotoDownloadManager {
    
    // MARK:- Add/Remove Array Downloading contains
    func updateDownLoadingContains(shouldAdd: Bool, keyIndex : String){
        serialQueue.sync {
            if shouldAdd {
                arrDownloading.append(keyIndex)
            }
            else {
                if let index = arrDownloading.index(of: keyIndex) {
                    arrDownloading.remove(at: index)
                }
            }
            
        }
    }
    // MARK:- Dispose Cache
    func clearCache() {
        URLCache.shared.removeAllCachedResponses()
        cache.removeAllObjects()
    }
}



