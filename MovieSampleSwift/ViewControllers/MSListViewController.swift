//
//  ViewController.swift
//  MovieSampleSwift
//
//  Created by Arslan  on 28/05/2015.
//  Copyright (c) 2015 Arslan . All rights reserved.
//

import UIKit
import Alamofire

class MSListViewController: UIViewController, MSNetworkManagerDelegate {

    @IBOutlet weak var listTblView : UITableView?
    var listDataArray: NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.downloadJson()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: TableView Deleagte
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(Constants.LIST_ROW_HEIGHT)
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listDataArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.SAMPLE_CELL_IDENTIFIER , forIndexPath: indexPath) as! MSListCell
        
        let row = indexPath.row
        cell.headlineLbl?.text = (listDataArray.objectAtIndex(row) as? MovieSample)!.headline as String
        cell.setCellImageWithURL((listDataArray.objectAtIndex(row) as? MovieSample)!.imageURL!)
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    //MARK: MSNetworkManager Delegate
    func getJsonDidSuccessWithJson(jsonArray:NSArray){
        //call back from Network manager after successful downlaod of json
        self.setUpImagesAndLoadTableWithArray(jsonArray)
    }
    func getJsonDidFail(error:NSError){
        var alertView = UIAlertView(title: "Error Retrieving Json" as String, message: error.localizedDescription as String, delegate:nil, cancelButtonTitle:"OK" as String, otherButtonTitles:"")
        alertView.show()
        NSTimer(timeInterval: 30.0, target: self, selector: Selector ("downloadJson"), userInfo: nil, repeats: false)//setting a timer to check again in 30 sec we can also put a refresh button in the view but just to keep it simple
    }
    //MARK: Custom Methods
    func setUpImagesAndLoadTableWithArray(jsonArray:NSArray){
        listDataArray.removeAllObjects();//remove all the existing items to use with current downloaded list
        for dict in jsonArray {
            var movie : MovieSample = MovieSample()
            movie.initWithWithDictionary((dict as? NSDictionary)!)
            listDataArray.addObject(movie)
        }
        self.listTblView?.reloadData()
    }
    func downloadJson(){
        // Initializing Network Manager to download the json from the url
        var networkManager: MSNetworkManager = MSNetworkManager.sharedManager
        
        networkManager.jsonDelegate = self; //setting delegate for url responses
        
        networkManager.downloadSampleJsonAtURL(Constants.JSON_URL)
    }
}

