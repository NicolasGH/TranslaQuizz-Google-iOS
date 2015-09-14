//
//  AskQuizzes.swift
//  TranslaQuizz Google iOs
//
//  Created by Nicolas GHEUNG on 17/06/15.
//  Copyright © 2015 Nicolas GHEUNG. All rights reserved.
//

import Foundation

//alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
//    switch action.style{
//    case .Default:
//        println("default")
//
//    case .Cancel:
//        println("cancel")
//
//    case .Destructive:
//        println("destructive")
//    }
//}))
class AskQuizzes
{
    private let inputLanguagePrefix:String
    private let outputLanguagePrefix:String
    private var wordDictionnary : [Word]
    
    init(inputLanguagePrefix:String, outputLanguagePrefix:String)
    {
        self.inputLanguagePrefix = inputLanguagePrefix
        self.outputLanguagePrefix = outputLanguagePrefix
        self.wordDictionnary = [Word]()
    }
    
    
    func loadFile()
    {
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true) as NSArray
        let documentDirectory = dirPaths[0]
        let path = documentDirectory.stringByAppendingPathComponent("/Content/WordsDataFROM-\(self.inputLanguagePrefix)-TO-\(self.outputLanguagePrefix)-.plist")
        let filemgr = NSFileManager.defaultManager()
        
        var dict :NSDictionary
        if (filemgr.fileExistsAtPath(path))
        {
            let dict = NSMutableDictionary(contentsOfFile: path)!
            let mySavedWords: AnyObject = dict.objectForKey("Saved Words")!
            let mySavedWordsArray = (mySavedWords as! NSMutableDictionary) as NSMutableDictionary
            print(mySavedWords)
//            mySavedWordsArray[word.GETWordRawKey()]=(self.word.GETDataTranslateDictionary())
//            
            
            //let words = ["Saved Words" : mySavedWordsArray] as NSDictionary
            //words.writeToFile(path, atomically:true)
            //print("PLIST Updated Add : \(word.GETWordRawKey())")
        }
        else
        {
            print("error big line 58 ask quizzes class")
        }
        
        
        func startTheQuizz()
        {
            wordDictionnary.shuffle(wordDictionnary)
        }
    }
    
}