////
////  Request.swift
////  TranslaQuizz
////
////  Created by Nicolas GHEUNG on 01/06/15.
////  Copyright (c) 2015 Nicolas GHEUNG. All rights reserved.
////
//
import Foundation


public class RequestLanguages{
    private var dicoLang:[String: String]
    private let key:String
    
    init(key:String)
    {
        self.dicoLang = NSDictionary() as! [String : String]
        self.key = key
    }
    
    public func GetLanguagesFromEnglish()
    {
        let uRL = NSURL(string: "https://www.googleapis.com/language/translate/v2/languages?key="+self.key+"&target=en")
        let request = NSMutableURLRequest(URL: uRL!)
        request.HTTPMethod = "GET"
        var termine = false
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
            {
                (data, response, error) in
                do{
                    
                let resultsDict: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                
                let reponseBrute = NSString(data: data!, encoding: NSUTF8StringEncoding)
                
                let ldata = resultsDict["data"] as! NSDictionary
                var dict = NSDictionary() as! [String : String]
                let languages = ldata["languages"] as! NSArray
                
                for index in 0...languages.count-1
                {
                    let langage = languages[index]  as! NSDictionary
                    dict[langage["language"] as! String] = langage["name"] as? String
                }
                self.SaveLanguageDictionary(dict , fileName: "DictPrefNameLanguage.plist")
                termine=true
                }
                catch{
                    print(error)
                }
        }
        
        let requestTime = NSDate()
        task.resume()
        
        while (termine != true && (requestTime.timeIntervalSinceNow > -15))
        {
            NSThread.sleepForTimeInterval(0.05)
        }
        if (termine != true)
        {
            print("Erreur de connexion : délai d'attente trop long (request language 12121)")
        }
        
    }
    
    private func SaveLanguageDictionary(dict :NSDictionary, fileName:String)
    {
        
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        let docsDir = NSURL(fileURLWithPath: dirPaths[0])
        let path = docsDir.URLByAppendingPathComponent("/Settings/"+fileName)
        let filemgr = NSFileManager.defaultManager()
        dict.writeToURL(path, atomically: false)
        
        let resultDictionary = NSMutableDictionary(contentsOfURL: path)
        if filemgr.fileExistsAtPath("\(docsDir)/Settings/\(fileName)")
        {
            print("File \(docsDir)/Settings/\(fileName) correctly created ")
        }
        else
        {
            print("Error found will creating \(fileName)  (request language 232111)")
        }
    }
}

