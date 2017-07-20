//
//  Picture.swift
//  Paint
//
//  Created by My Computer on 2017-07-19.
//  Copyright © 2017 Marwa. All rights reserved.
//

import Foundation

class Picture {
    
    var encodeB64 : String?
    
    
    init(picDict: [String : AnyObject]) {
        self.encodeB64 = picDict["base64"] as? String
    }

    
    static func importPictures() -> [Picture] {
        
        var pictures = [Picture]()
        
        let jsonFile = Bundle.main.path(forResource: "Pictures", ofType: "json")
        let jsonData = NSData(contentsOfFile: jsonFile!)
        
        if let jsonDict = parseJSONData(jsonData: jsonData) {
            let picDicts = jsonDict["pictures"] as! [[String : AnyObject]]
            for picDict in picDicts {
                let picture = Picture(picDict: picDict)
                print(picture.encodeB64)
                pictures.append(picture)
            }
        }
        
        return pictures
        
    }
    
    static func parseJSONData(jsonData: NSData?) -> [String : AnyObject]? {
        
        if let data = jsonData {
            do {
                let jsonDict = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : AnyObject]
                return jsonDict
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        return nil
    }
    
    func decodeBase64(encodedData: String) -> Data {
        let imageData = Data(base64Encoded: encodedData, options: .ignoreUnknownCharacters)
        return imageData!
    }
}
