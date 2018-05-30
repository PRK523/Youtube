//
//  SecondViewController.swift
//  Youtube
//
//  Created by Pranoti Kulkarni on 3/7/18.
//  Copyright © 2018 Pranoti Kulkarni. All rights reserved.
//


import UIKit
import GoogleSignIn


class SecondViewController: UIViewController, GIDSignInUIDelegate, UITableViewDelegate, UITableViewDataSource, VideoModelDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var videos: [Video] = [Video]()
    var selectedVideo: Video?
    var model: VideoModel = VideoModel()
    let searchController = UISearchController(searchResultsController: nil)
    var filteredArr = [Video]()
    
    func filterContentForSearch(searchText: String, scope: String = "All"){
        filteredArr = videos.filter({ (video) in
            return video.videoTitle.contains(searchText)
        })
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.model.delegate = self
        model.getFeedVideos()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    
    func dataReady() {
        
        //Access video objects that have been downloaded
        self.videos = self.model.videoArray
        
        //tell the tableView to reload
        self.tableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //Calculate height of row by getting width of screen
        return (self.view.frame.size.width / 300) * 300
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive && searchController.searchBar.text != nil{
            return filteredArr.count
        }
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell")!
        //let videoTitle = videos[indexPath.row].videoTitle
        var res: Video
        //let label = cell.viewWithTag(2) as! UILabel
        //label.text = videoTitle
        
        //customize the cell to display video title
        //cell.textLabel?.text = videos[indexPath.row].videoTitle
        
        if searchController.isActive && searchController.searchBar.text != nil{
            res = filteredArr[indexPath.row]
        }
        else{
         res = videos[indexPath.row]
        }
        //construct videothumnail url
        let videoThumbnailUrlString = videos[indexPath.row].videoThumbNailUrl
        cell.textLabel?.text = videos[indexPath.row].videoTitle
        
        //NSURL object
        let videoThumbNailUrl = URL(string: videoThumbnailUrlString)
        
        if videoThumbNailUrl != nil {
            let request = URLRequest(url: videoThumbNailUrl!)
            
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                
                //get reference to imageview element of cell
                DispatchQueue.main.async(execute: { () -> Void in
                let imageView = cell.viewWithTag(1) as! UIImageView
                
                imageView.image = UIImage(data: data!)
                })
            })
            dataTask.resume()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Take note when user selects a video in a row
        if searchController.isActive && searchController.searchBar.text != nil{
            self.selectedVideo = self.filteredArr[indexPath.row]
        }else{
          self.selectedVideo = self.videos[indexPath.row]
        }
        
        self.performSegue(withIdentifier: "videoSegue", sender: self)
        //let videoLauncher = VideoLauncher()
        //videoLauncher.showVideoPlayer()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let videoViewController = segue.destination as! VideoViewController
        
        videoViewController.selectedVideo = self.selectedVideo
    }
    
    @IBAction func didTapSignOut(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
        navigationController?.dismiss(animated: true, completion: nil) //come back to main viewcontroller
        print("User has Logged Out")
    }

}

extension SecondViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearch(searchText: searchController.searchBar.text!)
    }
}

