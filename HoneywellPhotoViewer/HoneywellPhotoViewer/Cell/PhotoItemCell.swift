//
//  PhotoItemCell.swift
//  HoneywellPhotoViewer
//
//  Created by Dutta, Soumitra on 1/20/21.
//

import UIKit

class PhotoItemCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var cellItemViewModel : PhotoCellItemViewModel? {
        
        didSet {
            lblDetails.text = cellItemViewModel!.lblDetails
            lblTitle.text = cellItemViewModel!.lblTitle
            img.layer.borderWidth = 2
            img.layer.borderColor = AppConstants.customColor.customBlue.cgColor

        }
    }

}
