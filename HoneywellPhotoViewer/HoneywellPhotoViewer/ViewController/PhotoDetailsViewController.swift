//
//  PhotoDetailsViewController.swift
//  HoneywellPhotoViewer
//
//  Created by Dutta, Soumitra on 1/20/21.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    @IBOutlet weak var mainImage: UIImageView!
    var urlString = ""
    var header = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI() {
        navigationController?.navigationBar.isHidden = false
        title = header
        mainImage.layer.masksToBounds = true
        mainImage.layer.borderWidth = 2
        mainImage.layer.borderColor = AppConstants.customColor.customBlue.cgColor
        downloadMainImage()
    }
    
    func downloadMainImage() {
        PhotoDownloadManager.shared.setUpMainImage(imageView: mainImage, urlString: urlString)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        PhotoDownloadManager.shared.clearCache()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

