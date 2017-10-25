//
//  ViewController.swift
//  JSONDecoderExample
//
//  Created by Vasudha Jags on 10/24/17.
//  Copyright © 2017 Vasudha J. All rights reserved.
//

// Note : Does not work if the response is a dictionary.
//Decoder protocol does not conform if the objects are dictionary
//Decoder protocol does not conform if the objects are dictionary
//Can only be arrays and other data types
//Looking out for an updates in NSDecoder.

import UIKit
/*
 URLs used to check JSONDecoder
 https://api.letsbuildthatapp.com/jsondecodable/course
 https://api.letsbuildthatapp.com/jsondecodable/courses
 https://api.letsbuildthatapp.com/jsondecodable/website_description
 https://api.letsbuildthatapp.com/jsondecodable/courses_missing_fields
 */
//Model Object - WebsiteDescription
struct WebsiteDescription : Decodable{
    let name : String
    let description : String
    let courses : [Course]
}

//Model Object - Course
struct Course : Decodable{
    // Declare properties optional if there are missing fields
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
    
    //for json serialization for Swift 2/3
    /* init(json:[String:Any]){
        id = json["id"] as? Int ?? 0
        name = json["name"] as? String ?? ""
        link = json["link"] as? String ?? ""
        imageURL = json["imageURL"] as? String ?? ""
        
    } */
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       // let course = Course(id: <#T##Int#>, name: <#T##String#>, link: <#T##String#>, imageURL: <#T##String#>)

        let jsonURLString = "https://api.letsbuildthatapp.com/jsondecodable/courses_missing_fields"
        guard let url = URL(string: jsonURLString) else{
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            //Swift 4
            /* let dataAsString = String(data: data, encoding: .utf8)
             print(dataAsString) */
            do{
                //Swift 4 and from Xcode 9.X
                let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                print(websiteDescription.courses)
                let course = try JSONDecoder().decode([Course].self, from: data)
                print(course)
                /* In swift 2 & 3 JSON parsing
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] else { return }
                let course = Course(json: json)
                print(json)
                 */
            }catch let jsonError{
                
                print("Eroor in JSON serialization: ",jsonError)
            }
            
            }.resume()
    }

    


}

