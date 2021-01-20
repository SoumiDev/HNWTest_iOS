//
//  WelcomeViewController.swift
//  HoneywellPhotoViewer
//
//  Created by Dutta, Soumitra on 1/20/21.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    var isPushedToHome = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = AppConstants.welcomScreenTitle
        navigationController?.navigationBar.isHidden = true
        setUpUIAnimation()
    }
    
    func setUpUIAnimation(){
        /* Do Animations */
        CATransaction.begin()
        CATransaction.setAnimationDuration(2.0)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut))
        
        // View animations
        UIView.animate(withDuration: 2.0) { [weak self] in
            self?.lblTitle.frame = CGRect(x: 0, y: 0, width: AppConstants.ViewAnimation.finalWidth, height: AppConstants.ViewAnimation.finalHeight)
            self?.lblTitle.center = (self?.view.center)!
            self?.lblTitle.font = UIFont.boldSystemFont(ofSize: 24.0)
            self?.preParePushToHomeView()
        }
        
        // Layer animations
        let cornerAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.cornerRadius))
        cornerAnimation.fromValue = AppConstants.ViewAnimation.initialWidth
        cornerAnimation.toValue = AppConstants.ViewAnimation.finalWidth/2
        
        lblTitle.layer.cornerRadius = AppConstants.ViewAnimation.finalWidth/2
        lblTitle.layer.add(cornerAnimation, forKey: #keyPath(CALayer.cornerRadius))
        
        CATransaction.commit()
    }
    
    
    func preParePushToHomeView(){
        //Check Networko Available
        if NetworkMonitoringManager.shared.isConnectionAvailable && !isPushedToHome{
            self.isPushedToHome = true
            let deadlineTime = DispatchTime.now() + .seconds(3)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) { [weak self] in
                self?.pushToHomeView()
            }
        }
    }
    
    func pushToHomeView(){
        let storyboard = UIStoryboard(name: AppConstants.mainStoryboardName, bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: AppConstants.Identifier.homeViewController) as! HomeViewController
        navigationController?.pushViewController(homeViewController, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        PhotoDownloadManager.shared.clearCache()
    }
    
    
}


