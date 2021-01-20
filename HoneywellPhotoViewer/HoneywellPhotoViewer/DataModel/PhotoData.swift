//
//  PhotoData.swift
//  HoneywellPhotoViewer
//
//  Created by Dutta, Soumitra on 1/20/21.
//

import Foundation

struct PhotoData : Codable {
    var title : String?
    var description : String?
    var imageHref : String?
}

struct PhotoPayload : Codable {
    var title : String?
    var rows : [PhotoData]?
}
