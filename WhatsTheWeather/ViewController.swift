//
//  ViewController.swift
//  WhatsTheWeather
//
//  Created by Charles Martin Reed on 9/13/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
// BACKGROUND IMAGE, "Calm Sky During Daytime" by Kendrick Mills, @kendrickmills: https://unsplash.com/@kenrickmills

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    //MARK:- PROPERTIES
    var startOfURL = "https://api.openweathermap.org/data/2.5/weather?q="
    var endOfURL = "&appid=350009d0e6ca205fae0266ffe8ecc5ea"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = ""
    }

    @IBAction func searchButtonTapped(_ sender: UIButton) {
        
        //take the textfield contents and use it as location
        if textField.text != "" {
            //in case we have a place like "San Francisco or New York"
          var location = NSString(string: textField.text!).capitalized
            
            //make the URL request
            let completeURL = startOfURL + String(location.replacingOccurrences(of: " ", with: "-")) + endOfURL
                print(completeURL)
                if let url = URL(string: completeURL) {
//                    let request = NSMutableURLRequest(url: url)
                
                //build the task
                    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                        
                    var message = ""
                    
                    if error != nil {
                        print(error ?? "Could not retreive data.")
                    } else {
                        //take the data and conver it to a string
                        if let unwrappedData = data {
                            //now using JSON
                            do {
                                let jsonResult = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as! NSDictionary
                                print(jsonResult)
                                
                                //grab the forecast and store it in message var
                                if let forecast = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String {
                                    message = "The weather in \(location) is currently \(forecast)"
                                }
                            } catch {
                                print("Could not retrieve data")
                            }
                            //let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                            
                            //trim the whitespace
                            //var dataSeparator = "<h2>\(location) Weather Today </h2>(1&ndash;3 days)</span><p class=\"b-forecast__table-description-content\"><span class=\"phrase\">"
                            
                            //if let weatherArray = dataString?.components(separatedBy: dataSeparator) {
                                
                                //if the array is not empty
                               // if weatherArray.count > 1 {
                                    
                                    //change the string separator to use the terminating string
                                    //dataSeparator = "</span>"
                                    
                                  //  let newWeatherArray = weatherArray[1].components(separatedBy: dataSeparator)
                                    
                                    //if newWeatherArray.count > 1 {
                                            
                                        //message = newWeatherArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                            
                                        //print(message)
                                    //}
        

                                }
                                //print(weatherArray)
                            }
                            
                            //for testing purposes, print the string we received
                            //print(dataString)
                            
                            DispatchQueue.main.sync {
                                self.textView.text = message
                            }
                        //}
                    //}
                }
                    
                //run the task
                task.resume()
                    
            } else {
                textView.text = "Can't retrieve results"
                return
            }
        } else {
            textView.text = "You have to enter some data."
        }
        
        textField.resignFirstResponder()
    }
    
    
}

