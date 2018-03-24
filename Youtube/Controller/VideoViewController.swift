//  VideoViewController.swift
//  Youtube
//
//  Created by Pranoti Kulkarni on 3/8/18.
//  Copyright © 2018 Pranoti Kulkarni. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {
    
    var selectedVideo: Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let keyWindow = UIApplication.shared.keyWindow
        let view = UIView(frame: (keyWindow?.frame)!)
        view.backgroundColor = UIColor.white
        
        let height = (keyWindow?.frame.width)! * 15 / 16
        let myWebView: UIWebView = UIWebView(frame: CGRect(x: 0, y: 0, width: keyWindow!.frame.width, height: height))
        if let vid = self.selectedVideo{
            let videoEmbedString = URL(string: "https://www.youtube.com/embed/\(vid.videoId)")
            
            let request = URLRequest(url: videoEmbedString!)
            
            myWebView.loadRequest(request)
            self.view.addSubview(myWebView)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear,
                           animations: {
                            self.view.frame = myWebView.frame
            },
                           completion: {(completedAnimation) in
                            //UIApplication.shared.setStatusBarHidden(true, with: .fade)
            })
            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
