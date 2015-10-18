//
//  ViewController Quizz.swift
//  TranslaQuizz Google iOs
//
//  Created by Nicolas GHEUNG on 17/06/15.
//  Copyright © 2015 Nicolas GHEUNG. All rights reserved.
//

import UIKit

class ViewController_Quizz: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate {
    
    var inputLangages = [String]()
    var outputLangages = [String]()
    var diction = Dictionary<String,String>()
    var workingWord:Word?
    var quizz:AskQuizzes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PlistToDict()
        loadAvailableLangages()
        self.pickerViewLangage.dataSource = self;
        self.pickerViewLangage.delegate = self;
      

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var pickerViewLangage: UIPickerView!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponentsInPickerView(pickerViewLangage: UIPickerView) -> Int
    {
        return 2
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerViewLangage: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return outputLangages.count
    }
    
     func pickerView(pickerViewLangage: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
     {
        if (component == 0)
        {
            return  diction[inputLangages[row]]
        }
        if (component == 1)
        {
            return diction[outputLangages[row]]
        }
        else
        {
            return "error LINE 58 VC QUIZZ";
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {

        if (component == 0)
        {
            pickerViewLangage.selectRow(row, inComponent: 1, animated: true)
        }
        else if (component == 1)
        {
            pickerViewLangage.selectRow(row, inComponent: 0, animated: true)
        }    }
    
    func loadAvailableLangages() //-> [[String]]
    {
        let docuPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        let docsDir = NSURL(fileURLWithPath: docuPaths[0])
        let path = docsDir.URLByAppendingPathComponent("/Content/")
        let filemgr = NSFileManager.defaultManager()
        var files = [String]()
        do
        {
            files = try  filemgr.contentsOfDirectoryAtPath (path.path!)
        }
        catch{
         print(" line 83 VC QUIZZ catch error loading")
        }
        
        
        if (files.count != 0 )
        {
            print("\(files) line 104 print files available")
            for (var i = 0 ; i<files.count ; i++)
            {
                if ( files[i].componentsSeparatedByString("-")[0] == ("WordsDataFROM"))
                {
                    let langageArray = files[i].componentsSeparatedByString("-")
                    print("Controle ligne 97 viewcontroler quizz!! uniquement nom du fichier check \(langageArray)")
                    self.inputLangages.append(langageArray[1])
                    self.outputLangages.append(langageArray[3])
                }
            }
            
            
        }

    }
    
    func PlistToDict() -> Dictionary<String, String>
    {
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let PlistDir = NSURL(fileURLWithPath: dirPath[0])
        let path = PlistDir.URLByAppendingPathComponent("/Settings/DictPrefNameLanguage.plist")
    
        let dict = NSDictionary(contentsOfURL: path) as! Dictionary<String, String>
        self.diction = dict
        return dict
    }   //same in view controler

    @IBOutlet weak var LaunchQuizz: UIButton!
    
    @IBOutlet weak var Switch: UISwitch!
    
    @IBOutlet weak var WordToTranslate: UILabel!
    
    
    @IBAction func LaunchQuizzButton(sender: AnyObject) {
        
        self.quizz = AskQuizzes(inputLanguagePrefix: inputLangages[(pickerViewLangage.selectedRowInComponent(0))], outputLanguagePrefix: outputLangages[pickerViewLangage.selectedRowInComponent(1)])
        //self.quizz = AskQuizzes(inputLanguagePrefix: "", outputLanguagePrefix: "")
        
        self.quizz!.loadFile()
        self.workingWord = self.quizz!.wordGenerator()
        if (Switch.on == true )
        {
            WordToTranslate.text = "Word to translate : \(workingWord!.GETTranslation())"
        }
        else
        {
            WordToTranslate.text = "Word to translate : \(workingWord!.GETWordRawKey())"
        }
    }
    
    @IBOutlet weak var Result: UITextField!
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        Result.endEditing(true)
    }
    
    @IBAction func textFielGo(sender: AnyObject)
    {
        sender.resignFirstResponder()
        let res = CheckAnswer()
        if (res == true)
        {
            self.workingWord = self.quizz!.wordGenerator()
            if (Switch.on == true )
            {
                WordToTranslate.text = "Word to translate : \(workingWord!.GETTranslation())"
            }
            else
            {
                WordToTranslate.text = "Word to translate : \(workingWord!.GETWordRawKey())"
            }
        }
        else
        {
            let alert = UIAlertView()
            alert.title = "Wrong Word"
            alert.message = "Try again"
            alert.addButtonWithTitle("Close")
            alert.show()

        }
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    func CheckAnswer() -> Bool
    {
        if (Switch.on == true )
        {
              if (Result.text == workingWord?.GETWordRawKey() )
              {
                return true
            }
            return false
        }
        else
        {
            if (Result.text == workingWord?.GETTranslation() )
            {
                return true
            }
            return false
        }
      
    }
}
