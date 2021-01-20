//
//  DefaultTableHeaderView.swift
//  PhotoViewer
//
//  Created by Dutta, Soumitra on 1/20/21.
//

import UIKit

class DefaultTableHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
   
   // @IBOutlet weak var backgroundImage: UIImageView!
    static let reuseIdentifier = AppConstants.Identifier.defaultTableHeaderView

    
}
