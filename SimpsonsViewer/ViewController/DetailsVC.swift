//  Project: SimpsonsViewer 
// Created by Jason Stout on 4/24/23.
//
// Using Swift 5.0
// Running on macOS 13.2
// DetailsVC
//
// "Design is not just what it looks like and feels like. Design is how it works." - Steve Jobs

import UIKit
import SDWebImage

class DetailsVC: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var topic: RelatedTopic?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let topic = topic {
            setupView(topic)
        }
    }
    
    func setupView(_ topic: RelatedTopic) {
        descriptionLbl.text = topic.text
        if !topic.icon.url.isEmpty {
            let url = URL(string: "https://duckduckgo.com\(topic.icon.url)")
            imageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"))
        } else {
            imageView.image = UIImage(named: "noImage")
        }
    }
}
