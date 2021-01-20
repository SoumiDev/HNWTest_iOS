//
//  Websettings.swift
//  HoneywellPhotoViewer
//
//  Created by Dutta, Soumitra on 1/20/21.
//

import Foundation

struct Websettings {
    
    static let shared = Websettings()
    //MARK: - Webservice URL
    //Development Settings
    #if DEBUG
    let BaseURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    let requestTimeOut = 120.0
    // TODO: Additional endpoints...
    
    #elseif TESTING
    let BaseURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    let requestTimeOut = 120.0
    // TODO: Additional endpoints...
    
    
    #elseif RELEASE
    let BaseURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    let requestTimeOut = 60.0
    // TODO: Additional endpoints...
    
    #endif
}
