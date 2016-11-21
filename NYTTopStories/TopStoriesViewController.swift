//
//  TopStoriesViewController.swift
//  NYTTopStories
//
//  Created by Jermaine Kelly on 11/19/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import UIKit

class TopStoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var stories: [NewsStory] = []
    let refreshControl: UIRefreshControl = UIRefreshControl()
    let endpoint: String = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=dcb60d374c4c4ff298d311fcb1d83273"
    
    @IBOutlet weak var topStoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topStoriesTableView.delegate = self
        topStoriesTableView.dataSource = self
        topStoriesTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(self.handleRefresh), for: .valueChanged)
        
        getStories()
    }
    
    //TableView Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryDetailsTableViewCell.identifier, for: indexPath) as! StoryDetailsTableViewCell
        
        cell.story = stories[indexPath.row]
        //cell.setNeedsLayout()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIApplication.shared.open(stories[indexPath.row].url, options: [:], completionHandler: nil)
        print(indexPath.row)
    }
    
    func handleRefresh(){
        getStories()
    }
    
    func getStories(){
        ApiRequestManager.manager.getData(from: self.endpoint) { (data) in
            self.stories = NewsStory.makeStories(from: data)!
            
            DispatchQueue.main.async {
                self.topStoriesTableView.reloadData()
                print("got data")
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    
}
