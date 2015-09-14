//
//  Dictionary extension.swift
//  TranslaQuizz Google iOs
//
//  Created by Nicolas GHEUNG on 14/06/15.
//  Copyright © 2015 Nicolas GHEUNG. All rights reserved.
//

import Foundation

extension Dictionary
{
    func find(Value : String?) -> String?
    {
        for (key,value) in self
        {
            if (Value == value as? String)
            {
                return key as? String
            }
        }
        return nil
  
    }
}