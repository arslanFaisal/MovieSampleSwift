//
//  MovieSample.swift
//  MovieSampleSwift
//
//  Created by Arslan  on 28/05/2015.
//  Copyright (c) 2015 Arslan . All rights reserved.
//

import UIKit

class MovieSample: NSObject {
    //we can add properties to this object later but for now we only need these two
    var headline:NSString
    var imageURL:NSString?
    override init(){
        self.headline = "Movie"
    }
    func initWithWithDictionary(sampleDict:NSDictionary) {
        
        self.headline = (sampleDict[Constants.HEADLINE_KEY as String] as? NSString)!
        if sampleDict[Constants.IMAGES_KEY as String] != nil {
            var imgURLArray = (sampleDict[Constants.IMAGES_KEY as String] as? NSArray)!
            if imgURLArray.count > 0 {
                var imageURLDict = (imgURLArray.objectAtIndex(0) as? NSDictionary)!
                self.imageURL = (imageURLDict[Constants.URL_KEY as String] as? NSString)!
            }
        }
        
    }
}
