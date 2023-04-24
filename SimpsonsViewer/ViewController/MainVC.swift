//  Project: SimpsonsViewer 
// Created by Jason Stout on 4/24/23.
//
// Using Swift 5.0
// Running on macOS 13.2
// ViewController
//
// "Design is not just what it looks like and feels like. Design is how it works." - Steve Jobs

import UIKit

class MainVC: UIViewController {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var relatedTopics: [RelatedTopic] = [RelatedTopic]()
    private var selectedTopic: RelatedTopic?
    
    var filteredTopics: [RelatedTopic] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleLbl.text = Networking.shared.projectTitle
        fetchTopics()
    }
    
    func fetchTopics() {
        Networking.shared.fetchData { topics in
            DispatchQueue.main.async {
                self.relatedTopics = topics
                self.filteredTopics = topics
                self.tableView.reloadData()
            }
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.destination is DetailsVC {
//            let vc = segue.destination as? DetailsVC
//            vc?.topic = selectedTopic
//        }
//    }
}

extension MainVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            filteredTopics = relatedTopics.filter { $0.parseName().contains(searchText) }
        } else {
            filteredTopics = relatedTopics
        }
        
        tableView.reloadData()
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTopics.count <= 0 ? relatedTopics.count : filteredTopics.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath) as? TopicCell {
            cell.configCell(topic: filteredTopics.count <= 0 ? relatedTopics[indexPath.row] : filteredTopics[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTopic = filteredTopics.count <= 0 ? relatedTopics[indexPath.row] : filteredTopics[indexPath.row]
        self.selectedTopic = selectedTopic
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        vc.topic = selectedTopic
        navigationController?.pushViewController(vc, animated: true)
    }
}
