# MovieSampleSwift
Its a sample project which illustrate my coding style in swift
This Project downloads a json feed and parse it and displays it inside a UITableView to user.
The Project is tested on the iPhone6 simulator
The Project uses Alamofire Kit for network related calls and a singleton class named “MSNetworkManager” is used for this purpose
Class named “MSListViewController” is used a container to display the table view to display the downloaded items on the screen
A custom cell class named “MSListCell” is used to display image and heading label on the UITableView. This class also downloads and cache images using Alamofire.
