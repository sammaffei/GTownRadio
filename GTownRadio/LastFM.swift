//
//  LastFM.swift
//  gtownradio
//
//  Created by Samuel Maffei on 9/11/18.
//  Copyright © 2018 Samuel Maffei. All rights reserved.
//

import Foundation
import Alamofire
import Fuzi


class LastFM
    {
    typealias LoadedImageComp = (UIImage) -> Void
    
    fileprivate static let sLastFMAPIKey = "60df14af04089c099235c73042b2fad9"
    
    fileprivate func getAlbumInfoURL(artist : String, album : String)->URL?
        {
        guard var lastFMLUrlComps = URLComponents(string:"http://ws.audioscrobbler.com/2.0/")
            else {return nil}
            
        lastFMLUrlComps.queryItems = [  URLQueryItem(name: "api_key", value: LastFM.sLastFMAPIKey),
                                        URLQueryItem(name: "method", value: "album.getinfo"),
                                        URLQueryItem(name: "artist", value: artist),
                                        URLQueryItem(name: "album", value: album)   ]
            
        return lastFMLUrlComps.url
        }
    
    fileprivate func getBestQualityImageURL(xmlDoc : Fuzi.XMLDocument)->URL?
        {
        let sImageResStrs = ["mega",  "extralarge", "large", "medium", "small"]
            
        for resStr in sImageResStrs
            {
            let xPathResult = xmlDoc.xpath("//image[@size='\(resStr)']")
                
            if let foundImage = xPathResult.first
                {
                return URL(string: foundImage.stringValue)
                }
            }
            
        return nil
        }
    
    func loadAlbumArt(nowInfo : NowPlayingInfo, loadCompl : @escaping LoadedImageComp)
        {
        if let fmURL = getAlbumInfoURL(artist: nowInfo.artist, album: nowInfo.album)
            {
                Alamofire.request(fmURL).responseXML
                    { (xmlResponse) in
                    switch xmlResponse.result
                        {
                        case .success(let value):
                            
                            if let bestImageURL = self.getBestQualityImageURL(xmlDoc : value)
                                {
                                // Use Alamofire to download the image
                                Alamofire.request(bestImageURL).responseData
                                    { (response) in
                                        if response.error == nil
                                            {
                                            if let data = response.data,
                                                let loadedImage = UIImage(data: data)
                                                {
                                                // Give complettion
                                                    
                                                loadCompl(loadedImage)
                                                }
                                            }
                                    }

                                }
                        
                        case .failure(let error):
                            break
                        }
                    }
            }
        }
    }
