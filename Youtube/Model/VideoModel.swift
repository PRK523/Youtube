//
//  VideoModel.swift
//  Youtube
//
//  Created by Pranoti Kulkarni on 3/8/18.
//  Copyright © 2018 Pranoti Kulkarni. All rights reserved.
//

import UIKit
import Alamofire

protocol VideoModelDelegate {
    func dataReady()
}

class VideoModel: NSObject {
    
    
    let API_KEY = "AIzaSyAKYxf9GFeU3aBpD_RHa__1KNZDui0fZO8"
    let CHANNEL_ID = "UC6-UA1FoMnbO2LCLWPCM9aA"
    
    var videoArray = [Video]()
    
    var delegate: VideoModelDelegate?
     
     func getFeedVideos() {
     
     //Fetch the videos dynamically from Youtube API
    
        
        Alamofire.request("https://www.googleapis.com/youtube/v3/playlistItems", method: HTTPMethod.get, parameters: ["part":"snippet", "playlistId":"PLiRG83hKoub8soaZdrLI2CEqU4P5-W39s","key": API_KEY, "channelId": CHANNEL_ID, "maxResults": 20], encoding: URLEncoding.default, headers: nil).responseJSON {(response) in
        print(response)
     
        if let JSON = response.result.value {
            if let dict = JSON as? [String: Any]{
                
                var arrayOfVideos = [Video]()
                for video in dict["items"] as! [AnyObject] {
                    print(video)
                    
                    let videoObj = Video()
                        videoObj.videoId = video.value(forKeyPath: "snippet.resourceId.videoId") as! String
                        videoObj.videoTitle = video.value(forKeyPath: "snippet.title") as! String
                        videoObj.videoDescription = video.value(forKeyPath: "snippet.description") as! String
                        videoObj.videoThumbNailUrl = video.value(forKeyPath: "snippet.thumbnails.high.url") as! String
                    
                    arrayOfVideos.append(videoObj)
                    
                    }
                    self.videoArray = arrayOfVideos
                
                    //notify the delegate data is ready
                    if self.delegate != nil{
                        self.delegate!.dataReady()
                }
                }
            }
        }
    }
    
    /*func getVideos() -> [Video] { //this function returns the video type which the class we declared in video.swift file
        var videos = [Video]()  //here im creating new instance of the class which is actual video type object
        
        //create a video object
        
        let video1 = Video()
        
        //assign the properties
        
        video1.videoId = "FM7MFYoylVs"
        video1.videoTitle = "The Chainsmokers & Coldplay - Something Just Like This (Lyric)"
        video1.videoDescription =  "Category Music License Standard YouTube License Music Something Just Like This ;by Coldplay Listen ad-free with YouTube Red"

        //append it to video array
        
        videos.append(video1)
        
        let video2 = Video()
        
        //assign the properties
        
        video2.videoId = "FM7MFYoylVs"
        video2.videoTitle = "The Chainsmokers & Coldplay - Something Just Like This (Lyric)"
        video2.videoDescription =  "Category Music License Standard YouTube License Music Something Just Like This ;by Coldplay Listen ad-free with YouTube Red"
        
        //append it to video array
        
        videos.append(video2)
        
        let video3 = Video()
        
        //assign the properties
        
        video3.videoId = "FM7MFYoylVs"
        video3.videoTitle = "The Chainsmokers & Coldplay - Something Just Like This (Lyric)"
        video3.videoDescription =  "Category Music License Standard YouTube License Music Something Just Like This ;by Coldplay Listen ad-free with YouTube Red"
        
        //append it to video array
        
        videos.append(video3)
        
        let video4 = Video()
        
        //assign the properties
        
        video4.videoId = "FM7MFYoylVs"
        video4.videoTitle = "The Chainsmokers & Coldplay - Something Just Like This (Lyric)"
        video4.videoDescription =  "Category Music License Standard YouTube License Music Something Just Like This ;by Coldplay Listen ad-free with YouTube Red"
        
        //append it to video array
        
        videos.append(video4)
        
        //return the array to caller
        return videos
        
        
        
        }*/
        
    }
