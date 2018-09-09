import UIKit

class ArticlesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var source: NewsSource?
    
    private var articles: [Article]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = source?.name

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        if let sourceId = source?.id {
            newsProvider.request(.articles(sourceId), completion: completion(_:response:error:))
        }
    }
    
    private func completion(_ data: Data?, response: URLResponse?, error: Error?) {
        if let error = error {
            print(error)
        }
        
        if let data = data {
            do {
                let decoder = JSONDecoder()
                let object = try decoder.decode(ArticlesResponseObject.self, from: data)
                articles = object.articles
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        }
    }

}

extension ArticlesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Open article in Safari
        if let urlString = articles?[indexPath.row].url, let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
}

extension ArticlesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = articles?.count {
            tableView.message("No articles available.", isHidden: count == 0 ? false : true)
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let articles = articles {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
            let article = articles[indexPath.row]
            cell.titleLabel.text = article.title
            cell.descriptionLabel.text = article.description
            if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
                cell.articleImageView.load(url: url)
                cell.articleImageView.contentMode = .scaleAspectFit
            }
            return cell
        }
        return UITableViewCell()
    }
    
}
