//
//  ViewController.swift
//  TranslaQuizz Google iOs
//
//  Created by Nicolas GHEUNG on 03/06/15.
//  Copyright (c) 2015 Nicolas GHEUNG. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var WordInput: UITextField!
    var arrayOfLanguages:[String] = []
    var selectedLanguageIn:String?
    var selectedLanguageOut:String = ""
    internal var diction:Dictionary<String,String> = [String:String]()
    
    func PlistToDict() -> NSDictionary
    {
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let PlistDir = NSURL(fileURLWithPath: dirPath[0])
        let path = PlistDir.URLByAppendingPathComponent("/Settings/DictPrefNameLanguage.plist")
        let dict = NSDictionary(contentsOfURL: path) as! Dictionary<String, String>
        self.diction = dict
        return dict
        
    }   //be carfeul, the same method is in ViewController_Quizz
    
    private func DictToKeyArraySorted(dict : NSDictionary)
    {
        var array : Array<String>
        array = Array<String>()
        for (_,value) in dict
        {
            array.append(value as! String)
        }
        arrayOfLanguages = array.sort()
    }
    
    
    @IBAction func EraseIfFirst(sender: AnyObject) {
        
        if ((sender as! UITextField).text=="Enter your word")
        {
            (sender as! UITextField).text = ""
        }
        
    }
    @IBAction func textFielGo(sender: AnyObject)
    {
        sender.resignFirstResponder()
        Translate()
    }
    @IBOutlet weak var PickerView: UIPickerView!
    
    
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0
        {
            return self.arrayOfLanguages.count+1
        }
        else
        {
            return self.arrayOfLanguages.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        let temp = ["Detect. Auto"] + (arrayOfLanguages)
        
        if component == 0
        {
            
            return temp[row]
        }
        if component == 1
        {
            return    arrayOfLanguages[row]
            
        }
        else
        {
            return "error"
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if component == 0
        {
            if (row != 0)
            {
                self.selectedLanguageIn = diction.find(arrayOfLanguages[row-1] as String)
            }
            else
            {
                self.selectedLanguageIn = nil
            }
            
        }
        if component == 1
        {
            self.selectedLanguageOut = diction.find(arrayOfLanguages[row] as String)!
            print(self.selectedLanguageOut)
        }
        
    }
    
    
    @IBOutlet weak var WordTranslated: UITextView!
    @IBAction func translateButton(sender: UIButton)
    {
        Translate()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.PickerView.dataSource = self;
        self.PickerView.delegate = self;
        
        Start()
        
        DictToKeyArraySorted(PlistToDict())
        self.PickerView.selectRow(20, inComponent: 0, animated: true)
        self.PickerView.selectRow(24, inComponent: 1, animated: true)
      //  self.PickerView.reloadAllComponents()
        
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        WordInput.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func Start()
    {
        if CheckIfFirstStart()
        {
            FirstStart(authKey:"AIzaSyAkeI_Xc1Ndu-FKdKDrSSy5xBn81NAo-mc")
        }
    }
    
    func Translate()
    {
        let (request,status) =  (RequestTranslation(fromLanguage: diction.find(arrayOfLanguages.at((PickerView.selectedRowInComponent(0))-1)), toLanguage: diction.find(arrayOfLanguages[PickerView.selectedRowInComponent(1)] as String!)!, textToTranslate: (WordInput.text)!, authKey: "AIzaSyAkeI_Xc1Ndu-FKdKDrSSy5xBn81NAo-mc")).AskTranslation()
       
        
        let resultText:String?

        if (status == "0")
        {
            resultText = "\(request!.ToString())"
            AddRemoveWordForQuizz(word: request!).AddWordToPlist()
            WordTranslated.text = resultText
        }
            else if (status != "nil")
        {
            let alert = UIAlertView()
            alert.title = "Connection Problem"
            alert.message = "Please check your account settings \n Check Window below for further information"
            alert.addButtonWithTitle("Close")
            alert.show()
            WordTranslated.text = status
        }
        
        else
        {
            let alert = UIAlertView()
            alert.title = "Connection Problem"
            alert.message = "Please check your internet connection"
            alert.addButtonWithTitle("Close")
            alert.show()
            WordTranslated.text = "error"
        }        
    }
    
    func CheckIfFirstStart() -> Bool
    {
        let fileManager = NSFileManager.defaultManager()
        let docuPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        let docsDir = docuPaths[0] as String
        
        if fileManager.fileExistsAtPath("\(docsDir)/Settings/DictPrefNameLanguage.plist")
        {
            print("Normal Start")
            print("Working directory \(docsDir)")
            return false
        }
        else
        {
            print("First Start")
            return true
        }
    }
    
    
}