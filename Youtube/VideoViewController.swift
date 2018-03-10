//  VideoViewController.swift
//  Youtube
//
//  Created by Pranoti Kulkarni on 3/8/18.
//  Copyright © 2018 Pranoti Kulkarni. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {

    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var selectedVideo: Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let vid = self.selectedVideo{
            self.titleLabel.text = vid.videoTitle
            self.descriptionLabel.text = vid.videoDescription
            
            let videoEmbedString = URL(string: "https://www.youtube.com/embed/" + vid.videoId)
            
            let request = URLRequest(url: videoEmbedString!)
            
            webView.loadRequest(request)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
