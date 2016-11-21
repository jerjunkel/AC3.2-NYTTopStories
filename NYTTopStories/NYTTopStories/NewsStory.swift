//
//  NewsStory.swift
//  NYTTopStories
//
//  Created by Jermaine Kelly on 11/19/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import Foundation

class NewsStory{
    
    let title: String
    let abstract: String
    let byline:String
    let subsection: String
    let url: URL
    let publishedDate: String
    
    //Instantiates Object
    init?(using dicitonary:[String:Any]){
        
        if let title = dicitonary["title"] as? String,
            let abstract = dicitonary["abstract"] as? String,
            let byline = dicitonary["byline"] as? String,
            let subsection = dicitonary["subsection"] as? String,
            let urlString = dicitonary["short_url"] as? String,
            let publishedDate = dicitonary["published_date"] as? String{
            
            self.title = title
            self.abstract = abstract
            self.byline = byline
            self.subsection = subsection
            self.url = URL(string: urlString)!
            self.publishedDate = publishedDate
            
        }else{
            return nil
        }
    }
    

    
   static func makeStories(from data:Data)->[NewsStory]?{
        var stories:[NewsStory] = []
        
        do{
            guard let jsonData: [String:Any] = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any],let results: [[String:Any]] = jsonData["results"] as? [[String:Any]] else { return nil }
            
            for story in results{
                if let storyObject = NewsStory(using: story){
                    stories.append(storyObject)
                }
            }
        }catch{
            print(error)
        }

        return stories
    }
}
