//
//  PhotoTestData.swift
//  HoneywellPhotoViewerTests
//
//  Created by Dutta, Soumitra on 1/20/21.
//

import Foundation
func getPhotoDataList() -> [PhotoData] {
    
    var arrPhotoData = [PhotoData]()
    var photoData1 = PhotoData()
    photoData1.title = "Test1"
    photoData1.description = "Test ImageUrl 1"
    photoData1.imageHref = "Test Thumbnail Image Url 1"
    arrPhotoData.append(photoData1)
    
    var photoData2 = PhotoData()
    photoData2.title = "Test2"
    photoData2.description = "Test ImageUrl 2"
    photoData2.imageHref = "Test Thumbnail Image Url 2"
    arrPhotoData.append(photoData2)
        
    return arrPhotoData
}
