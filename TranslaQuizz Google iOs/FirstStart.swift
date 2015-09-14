//
//  FirstStart.swift
//  TranslaQuizz Google iOs
//
//  Created by Nicolas GHEUNG on 03/06/15.
//  Copyright (c) 2015 Nicolas GHEUNG. All rights reserved.
//

import Foundation

public class FirstStart
{
    private let authKey : String
    public init(authKey: String)
    {
        self.authKey = authKey
        WriteSettingsDataInDocuments()
        CreateContentFolder()
    }
    
    private func WriteSettingsDataInDocuments()
    {
        let filemgr = NSFileManager.defaultManager()
        
        let docuPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        
        let docsDir = NSURL(fileURLWithPath: docuPaths[0])
        let newDir = docsDir.URLByAppendingPathComponent("Settings")
        
        
        
        do
        {
            try filemgr.createDirectoryAtURL(newDir,withIntermediateDirectories: true, attributes: nil)
            print("Succes to create dir \"Settings\"")    //Petite erreur
            let r = RequestLanguages(key: self.authKey)
            r.GetLanguagesFromEnglish()
        }
        catch
        {
            print("Failed to create dir: \(error)")
        }
        
    }
    
    private func CreateContentFolder()
    {
        let filemgr = NSFileManager.defaultManager()
        
        let docuPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        
        let docsDir = NSURL(fileURLWithPath: docuPaths[0])
        let newDir = docsDir.URLByAppendingPathComponent("Content")
        
        
        
        do
        {
            
            try filemgr.createDirectoryAtURL(newDir,
                withIntermediateDirectories: true,
                attributes: nil)
            print("Succes to create dir \"Content\"")
            
        }
        catch
        {
            print("Failed to create dir: \(error)")
        }
        
    }
}