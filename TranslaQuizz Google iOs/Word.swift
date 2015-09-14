//
//  Word.swift
//  TranslaQuizz Google iOs
//
//  Created by Nicolas GHEUNG on 03/06/15.
//  Copyright (c) 2015 Nicolas GHEUNG. All rights reserved.
//

import Foundation

public class Word
{
    private let fromLanguage:String
    private let toLanguage:String
    private let rawText:String
    private var translatedText:String
    private let createdTime:NSDate
    private var priority:Int
    
    init(fromLanguage:String,toLanguage:String,rawText:String,translatedText:String)
    {
        self.fromLanguage = fromLanguage
        self.toLanguage = toLanguage
        self.rawText = rawText
        self.translatedText = translatedText
        self.createdTime = NSDate()
        self.priority = 5
    }
    
    public func ToString()->String
    {
        return ("raw text: \(self.rawText)\nfrom:\(self.fromLanguage)\nto:\(self.toLanguage)\nTranslated text: \(self.translatedText)")
    }
    
    public func GETDataTranslateDictionary() -> NSArray
    {
        var dict = [String : AnyObject]()
        var array = [NSDictionary]()
        dict["From Language"] = self.fromLanguage
        dict["To Language"] = self.toLanguage
        dict["Raw Language"] = self.rawText
        dict["Translated Text"] = self.translatedText
        dict["Created Time"] = self.createdTime
        dict["Priority"] = self.priority
        for (key, value) in dict
        {
            array.append([key:value])
        }
    return array
    }
    
    public func GETWordRawKey() -> String
    {
        return self.rawText
    }
    
    public func GETFromLanguage() -> String
    {
        return self.fromLanguage
    }
    
    public func GETToLanguage() -> String
    {
        return self.toLanguage
    }
    
    public func ModifierTraduction(value:String)
    {
        self.translatedText = value
    }

}