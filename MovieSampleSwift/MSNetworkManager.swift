//
//  MSNetworkManager.swift
//  MovieSampleSwift
//
//  Created by Arslan  on 28/05/2015.
//  Copyright (c) 2015 Arslan . All rights reserved.
//

import UIKit
import Alamofire
extension Alamofire.Request {
    class func imageResponseSerializer() -> Serializer {
        return { request, response, data in
            if data == nil {
                return (nil, nil)
            }
            
            let image = UIImage(data: data!, scale: UIScreen.mainScreen().scale)
            
            return (image, nil)
        }
    }
    
    func responseImage(completionHandler: (NSURLRequest, NSHTTPURLResponse?, UIImage?, NSError?) -> Void) -> Self {
        return response(serializer: Request.imageResponseSerializer(), completionHandler: { (request, response, image, error) in
            completionHandler(request, response, image as? UIImage, error)
        })
    }
}

@objc protocol MSNetworkManagerDelegate{
    //mark: SNetworkManagerDelegate Delegate Methods
    //These methods are optional because this class can be used for other download calls aswell in future so no need to implement these methods in places where not required
    optional func getJsonDidSuccessWithJson(jsonArray:NSArray)
    optional func getJsonDidFail(error:NSError)
}
class MSNetworkManager: NSObject {
    static let sharedManager = MSNetworkManager()
    var jsonDelegate : MSNetworkManagerDelegate?
    override init() {
        super.init()
    }
    func downloadSampleJsonAtURL(fileURL:NSString){
        var string = NSString(format:"%@%@",Constants.BASE_URL,fileURL)
        //var url = NSURL.URLWithString(string)
        //var request = NSURLRequest.requestWithURL(url)
        
        //AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        //operation.responseSerializer = [AFJSONResponseSerializer serializer];
        
        var error:NSError
        Alamofire.request(.GET, string as String).responseJSON(options: nil, completionHandler: {(_,_,data,error) in
            if(error != nil){
                self.jsonDelegate?.getJsonDidFail!(error!)
            }
            else{
                var jsonArray = (data as? NSArray)!
                self.jsonDelegate?.getJsonDidSuccessWithJson!(jsonArray)
            }
        })
        
    }
}

