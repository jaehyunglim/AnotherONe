//
//  ViewController.swift
//  AnotherONe
//
//  Created by Jae Lim on 10/12/18.
//  Copyright © 2018 How. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Department: UITextField!
    @IBOutlet weak var Number: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        var hellocontroller = segue.destination as! HelloViewController
        let text: String = Department.text!
        let text1: String = Number.text!
        let url = URL(string: "https://stardock.cs.virginia.edu/louslist/Courses/view/" + text + "/" + text1 + "?json")
        
        //CS/2150?json")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil
            {
                
                print ("ERROR")
            }
            else
            {
                if let content = data
                {
                    do
                    {
                        //Array
                        
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        for anItem in myJson as! [Dictionary<String, AnyObject>] { // or [[String:AnyObject]]
                            var time:String = anItem["meetingTime"] as! String
                            var personName:String = anItem["instructor"] as! String
                            var x = true
                            if x==true {
                                print(personName)
                                print(time)
                                hellocontroller.myString = personName
                                x = false
                            }
                            
                        }
                        
                    }
                    catch
                    {
                        
                        
                    }
                }
            }
        }
        
        task.resume()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Send(_ sender: Any) {
        if Department.text != nil && Number.text != nil {
        performSegue(withIdentifier: "segue1", sender: self)
        }
    }
    
}

