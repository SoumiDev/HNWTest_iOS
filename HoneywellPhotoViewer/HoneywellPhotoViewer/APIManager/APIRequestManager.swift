//
//  APIRequestManager.swift
//  HoneywellPhotoViewer
//
//  Created by Dutta, Soumitra on 1/20/21.
//

import Foundation

typealias ResponseDic = [String:Any]

class APIRequestManager {
    static let shared = APIRequestManager()

    func callService ( urlString : String, successBlock: @escaping (_ result: PhotoPayload) -> Void, failureBlock : @escaping (_ result: ResponseDic) -> Void)
    {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = Websettings.shared.requestTimeOut
        sessionConfig.timeoutIntervalForResource = Websettings.shared.requestTimeOut
        let session = URLSession(configuration: sessionConfig)
        let task =  session.dataTask(with: url, completionHandler:{data, response, error -> Void in
            if error != nil
            {
                var errorResponse = ResponseDic()
                errorResponse[AppConstants.error] = error?.localizedDescription
                failureBlock(errorResponse)
            }
            else if let data = data, let value = String(data: data, encoding: String.Encoding.ascii), let jsonData = value.data(using: String.Encoding.utf8) {

                    do {
                    // data we are getting from network request
                    let utf8Text = String(data: jsonData, encoding: .utf8)
                    print(utf8Text)
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(PhotoPayload.self, from: jsonData)
                        if let _ = response.title, let _  = response.rows {
                            successBlock(response)
                        }
                        else{
                            var errorResponse = ResponseDic()
                            errorResponse[AppConstants.error] = AppConstants.error
                            failureBlock(errorResponse)
                        }
                    }
                    catch {
                        debugPrint(error)
                        var errorResponse = ResponseDic()
                        errorResponse[AppConstants.error] = AppConstants.error
                        failureBlock(errorResponse)
                    }

                    
                }
            else
            {
                var errorResponse = ResponseDic()
                errorResponse[AppConstants.error] = AppConstants.error
                failureBlock(errorResponse)
            }
        })
        task.resume()
    }
    
    
}
