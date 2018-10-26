import UIKit

class NewsSourcesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var sources: [NewsSource]?
    private var selectedSource: NewsSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Test
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            let modalVC = CustomModalViewController()
            self.present(modalVC, animated: true, completion: nil)
        })
        
        tableView.delegate = self
        tableView.dataSource = self
        
        newsProvider.request(.sources(.all), completion: completion(_:response:error:))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowArticlesSegue"
        {
            if let destination = segue.destination as? ArticlesViewController {
                destination.source = selectedSource
            }
        }
    }
    
    private func completion(_ data: Data?, response: URLResponse?, error: Error?) {
        if let error = error {
            print(error)
        }
        
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let object = try decoder.decode(SourcesResponseObject.self, from: data)
                sources = object.sources
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        }
    }

}

extension NewsSourcesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSource = sources?[indexPath.row]
        performSegue(withIdentifier: "ShowArticlesSegue", sender: nil)
    }
    
}

extension NewsSourcesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = sources?.count { return count }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let sources = sources {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "SourceCell")
            let source = sources[indexPath.row]
            cell.textLabel?.text = source.name
            cell.detailTextLabel?.text = source.category.rawValue
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        return UITableViewCell()
    }
    
}
