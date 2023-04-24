//  Project: SimpsonsViewer 
// Created by Jason Stout on 4/24/23.
//
// Using Swift 5.0
// Running on macOS 13.2
// TopicRow
//
// "Design is not just what it looks like and feels like. Design is how it works." - Steve Jobs

import UIKit

class TopicCell: UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configCell(topic: RelatedTopic) {
        nameLbl.text = topic.parseName()
    }
}
