//
//  ApiRequestManager.swift
//  NYTTopStories
//
//  Created by Jermaine Kelly on 11/19/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import Foundation

class ApiRequestManager{
    static let manager = ApiRequestManager()
    private init(){}

    func getData(from endpoint:String, completion: @escaping (Data)->()){
        
        guard let endpointUrl: URL = URL(string: endpoint) else { print ("Invalid Url"); return }
        let session: URLSession = URLSession(configuration: .default)
        
        session.dataTask(with: endpointUrl) { (data:Data?, reponse:URLResponse?, error:Error?) in
         
            if error != nil{
                print("Error \(error)")
            }
            
            if let validData = data{
                completion(validData)
            }
        }.resume()
    }
}
