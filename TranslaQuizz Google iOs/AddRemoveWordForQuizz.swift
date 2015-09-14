//
//  Quizz.swift
//  TranslaQuizz Google iOs
//
//  Created by Nicolas GHEUNG on 03/06/15.
//  Copyright (c) 2015 Nicolas GHEUNG. All rights reserved.
//

import Foundation

public class AddRemoveWordForQuizz
{
    let word:Word
    
    init(word:Word)
    {
        self.word=word
    }
    
    public func AddWordToPlist()
    {
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true) as NSArray
        let documentDirectory = dirPaths[0]
        let path = documentDirectory.stringByAppendingPathComponent("/Content/WordsDataFROM-\(word.GETFromLanguage())-TO-\(word.GETToLanguage())-.plist")
        let filemgr = NSFileManager.defaultManager()
        
        var dict :NSDictionary
        if (!filemgr.fileExistsAtPath(path))
        {
            var DictionnaryOfTranslations = [String : NSArray]()
            DictionnaryOfTranslations[word.GETWordRawKey()] = self.word.GETDataTranslateDictionary()
            
            let words = ["Saved Words" : DictionnaryOfTranslations] as NSDictionary
            words.writeToFile(path, atomically:false)
            print("File : " + path + " correctly created.")
        }
        else
        {
            let dict = NSMutableDictionary(contentsOfFile: path)!
            let mySavedWords: AnyObject = dict.objectForKey("Saved Words")!
            let mySavedWordsArray = (mySavedWords as! NSMutableDictionary) as NSMutableDictionary
            mySavedWordsArray[word.GETWordRawKey()]=(self.word.GETDataTranslateDictionary())
            let words = ["Saved Words" : mySavedWordsArray] as NSDictionary
            words.writeToFile(path, atomically:true)
            print("PLIST Updated Add : \(word.GETWordRawKey())")
        }
    }
    
    public func RemoveWordOFPLIST()
    {
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true) as NSArray
        let documentDirectory = dirPaths[0]
        let path = documentDirectory.stringByAppendingPathComponent("/Content/WordsDataFROM-\(word.GETFromLanguage())-TO-\(word.GETToLanguage())-.plist")
        let filemgr = NSFileManager.defaultManager()
        
        var dict :NSDictionary
        if (filemgr.fileExistsAtPath(path))
        {
            let dict = NSMutableDictionary(contentsOfFile: path)!
            let mySavedWords: AnyObject = dict.objectForKey("Saved Words")!
            let mySavedWordsArray = (mySavedWords as! NSMutableDictionary) as NSMutableDictionary
            mySavedWordsArray.removeObjectForKey(word.GETWordRawKey())
                            let words = ["Saved Words" : mySavedWordsArray] as NSDictionary
            words.writeToFile(path, atomically:true)
            print("PLIST Updated Word Removed : \(word.GETWordRawKey())")
        }
        else
        {
           print("Error RemoveWordOFPLIST, file doesn't exists")
        }
    }   
}

