//
//  NowPlayingInfo.swift
//  gtownradio
//
//  Created by Samuel Maffei on 9/10/18.
//  Copyright © 2018 Samuel Maffei. All rights reserved.
//

import Alamofire
import AlamoFuzi

struct NowPlayingInfo
    {
    var song : String = ""
    var artist : String = ""
    var album : String = ""
    var duration : Int = 0
    
    }


class NowPlayingTask
    {
    // MARK: - Properties
    
    static let shared = NowPlayingTask()
    
    var timer: Timer?
    var contentLength : Int = 0
    
    func getGTownNowPlayingInfo()
        {
            Alamofire.request("http://www.gtownradio.com/sam/playing.html").responseHTML { response in
                switch response.result
                {
                case .failure(let error):
                    debugPrint("Error: \(error)")
                    debugPrint(response)
                case .success(let document):
                    // Parsing the HTML data
                    
                    var newNowPlaying = NowPlayingInfo()
                    
                    if let baseNode = document.xpath("//tr[2]").first,
                        let artistTitleNode = baseNode.xpath("./td[1]/font/small").first
                    {
                    let artistTitleComps = artistTitleNode.stringValue.components(separatedBy: " - ")
                        
                    switch artistTitleComps.count
                        {
                        case 2:
                            newNowPlaying.artist = artistTitleComps[0]
                            newNowPlaying.song = artistTitleComps[1]
                        case 3 :
                            newNowPlaying.artist = artistTitleComps[0]
                            
                            newNowPlaying.song = artistTitleComps[1] + " - " + artistTitleComps[2]
                        default:
                            newNowPlaying.artist = artistTitleNode.stringValue

                        }
                        
                    if let albumNameNode = baseNode.xpath("./td[5]/font/small").first
                        {
                        newNowPlaying.album = albumNameNode.stringValue
                        }
                        
                    if let durationNode = baseNode.xpath("./td[6]/p/font/small/strong").first
                        {
                        let durationStr = durationNode.stringValue
                            
                        let subStrs = durationStr.components(separatedBy: ":")
                            
                        if let durMins = Int(subStrs[0]),  let durSecs = Int(subStrs[1])
                            {
                            newNowPlaying.duration = (durMins * 60) + durSecs
                            }
                        }
                    }
                }
            }
        }

    
    func getHeadInfoForNowPlaying()
        {
        Alamofire.request("http://www.gtownradio.com/sam/playing.html", method: .head, parameters: nil, encoding: JSONEncoding.default, headers: nil).response
            {response in
                
                if let theResponse = response.response
                {
                if let contentLengthStr = theResponse.allHeaderFields["Content-Length"] as! String?,
                    let newContentLength = Int(contentLengthStr),
                    newContentLength != self.contentLength
                        {
                        self.contentLength = newContentLength
                            
                        self.getGTownNowPlayingInfo()
                        }
                    }
                }
            }

    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5.0,
                                     target: self,
                                     selector: #selector(eventWith(timer:)),
                                     userInfo: [ "foo" : "bar" ],
                                     repeats: true)
    }
    
    // Timer expects @objc selector
    @objc func eventWith(timer: Timer!)
        {
        getHeadInfoForNowPlaying()
        }
    

    
    init()
        {
        startTimer()
        }
    
    }