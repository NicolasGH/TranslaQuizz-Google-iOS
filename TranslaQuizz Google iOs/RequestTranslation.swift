//
//  RequestTranslation.swift
//  TranslaQuizz Google iOs
//
//  Created by Nicolas GHEUNG on 03/06/15.
//  Copyright (c) 2015 Nicolas GHEUNG. All rights reserved.
//

import Foundation

public class RequestTranslation
{
    private var fromLanguage:String?
    private let toLanguage:String
    private let textToTranslate: String
    private let authKey:String
    
    init(fromLanguage:String?, toLanguage:String,textToTranslate: String, authKey:String)
    {
        self.fromLanguage = fromLanguage
        self.toLanguage = toLanguage
        self.textToTranslate = textToTranslate
        self.authKey = authKey
    }
    
    public func AskTranslation() -> (Word?, status :String?)
    {
        var uRL:NSURL
        var translation:String?
        var status:String?
        if(fromLanguage != nil)
        {
            uRL = NSURL(string: "https://www.googleapis.com/language/translate/v2?key=\((self.authKey).urlEncoded!)&source=\(self.fromLanguage!.urlEncoded!)&target=\(self.toLanguage.urlEncoded!)&q=\(self.textToTranslate.urlEncoded!)")!
        }
        else
        {
            uRL = NSURL(string: "https://www.googleapis.com/language/translate/v2?key=\(authKey.urlEncoded!)&target=\(toLanguage.urlEncoded!)&q=\(textToTranslate.urlEncoded!)")!
        }
        var termine = false
        let request = NSMutableURLRequest(URL: uRL)
        request.HTTPMethod = "GET"
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
            {
                (data,reponse,error) in
                do{
                    let resultDict: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    let reponseBrute = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print(self.fromLanguage)
                    let ldata = resultDict["data"] as? NSDictionary
                    let tdata = ldata?["translations"] as? NSArray
                    if (tdata != nil)
                    {
                        for index in 0 ... tdata!.count-1
                        {
                            let translations = tdata![index] as! NSDictionary
                            translation = translations["translatedText"] as? String
                            if (self.fromLanguage == nil)
                            {
                                self.fromLanguage = (translations["detectedSourceLanguage"] as! String)
                            }
                        }
                        status = "0";
                    }
                    else
                    {
                        status = reponseBrute as? String
                    }
                    termine = true
                    
                }
                catch{
                    print(error)
                }
                
        }
        let requestTime = NSDate()
        task.resume()
        
        while (termine != true && (requestTime.timeIntervalSinceNow > -5))
        {
            NSThread.sleepForTimeInterval(0.10)
        }
        if (termine == false && status == nil)
        {
            print("Erreur de connexion : délai d'attente trop long")
            return (nil, nil)
        }
            else if (termine == true && status != nil)
        {
            return (nil, status)
        }
        else
        {
            return (Word(fromLanguage: self.fromLanguage!, toLanguage: self.toLanguage, rawText: self.textToTranslate, translatedText: (translation?.stringByReplacingOccurrencesOfString("&#39;", withString: "'"))!), "0")
        }
    }
}