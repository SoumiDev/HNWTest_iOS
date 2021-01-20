//
//  APIServiceCallmanager.swift
//  HoneywellPhotoViewer
//
//  Created by Dutta, Soumitra on 1/20/21.
//

import Foundation

class  APIServiceCallmanager {
    
    static let shared = APIServiceCallmanager()
    
    func callPhotoService(successBlock: @escaping (_ result: PhotoPayload) -> Void, failureBlock : @escaping (_ result: ResponseDic) -> Void){
    
            APIRequestManager.shared.callService(urlString: Websettings.shared.BaseURL, successBlock: {(response) in
            successBlock(response)
                
           
    },
    failureBlock: {(response) in
    
        failureBlock(response)
        
    })
    }
    
}
