//
//  PhotoServiceHelper.swift
//  HoneywellPhotoViewer
//
//  Created by Dutta, Soumitra on 1/20/21.
//

import Foundation

protocol PhotoServiceHelperProtocol {
    func photoServiceRequest(successBlock: @escaping (_ result: PhotoPayload) -> Void, failureBlock : @escaping (_ result: ResponseDic) -> Void)
}
class PhotoServiceHelper: PhotoServiceHelperProtocol {
    
    func photoServiceRequest(successBlock: @escaping (_ result: PhotoPayload) -> Void, failureBlock : @escaping (_ result: ResponseDic) -> Void){
        
        APIRequestManager.shared.callService(urlString: Websettings.shared.BaseURL, successBlock: {(response) in
            successBlock(response)
        },
        failureBlock: {(response) in
            failureBlock(response)
        })
    }
}
