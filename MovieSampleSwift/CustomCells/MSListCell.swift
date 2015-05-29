//
//  MSListCell.swift
//  MovieSampleSwift
//
//  Created by Arslan  on 28/05/2015.
//  Copyright (c) 2015 Arslan . All rights reserved.
//

import UIKit
import Alamofire

class MSListCell: UITableViewCell {
    
    @IBOutlet weak var headlineLbl: UILabel?
    @IBOutlet weak var imgView: UIImageView?
    func setCellImageWithURL(urlStr:NSString){
        
        weak var weakCell = self;  // we want to keep the refernece to the cell in case its no longer there to avoid memory allocation based crashes insdie the block
        
        //Dowloading the image using AFNetworking image dowloader category method, AFNetworking class by dfault cache the response to caching is handled here. We could have also used NSURLCache and NSURLConnection but AFNetworking is built on top of these classes and is easy to extend and use.
        
        var error:NSError
        Alamofire.request(.GET, urlStr as String).validate().responseImage({(_, _, image, error) in
            weakCell?.imgView?.image = image
            weakCell?.setNeedsLayout()
        })
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
