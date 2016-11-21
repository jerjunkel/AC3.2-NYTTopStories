//
//  StoryTableViewCell.swift
//  NYTTopStories
//
//  Created by Jermaine Kelly on 11/19/16.
//  Copyright © 2016 Jermaine Kelly. All rights reserved.
//

import UIKit

class StoryDetailsTableViewCell: UITableViewCell {
    
    static let identifier = "storyDetailsCell"
    var story: NewsStory?{
        didSet{
            setupCell()
        }
    }
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var abstractTextView: UILabel!
    @IBOutlet weak var subsectionLabel: UILabel!
    @IBOutlet weak var datePublishedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(){
        
        title.text = story?.title
        abstractTextView.text = story?.abstract
        subsectionLabel.text = story?.subsection
        datePublishedLabel.text = story?.publishedDate
    }
    
    func getDateFormat(from dateString: String)->String{
        
        let dateFormator: DateFormatter = DateFormatter()
        let properDateString = String(dateString.characters.prefix(10))
        print(properDateString)
        dateFormator.dateFormat = "yyyy-mm-dd"
        dateFormator.dateStyle = .medium
        
        guard let dateObj = dateFormator.date(from: properDateString) else { return ""}
    
        return dateFormator.string(from: dateObj)
    }
    
}
