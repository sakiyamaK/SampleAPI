//
//  GithubAPIViewController.swift
//  SampleAPI
//
//  Created by sakiyamaK on 2024/06/27.
//

import UIKit

class GithubAPIViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        let searchBar = UISearchBar()
        searchBar.delegate = self
        stackView.addArrangedSubview(searchBar)
        
        let tableView = UITableView()
        tableView.dataSource = self
        stackView.addArrangedSubview(tableView)
    }
}

extension GithubAPIViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let text = searchBar.text else {
            return
        }
        
        let urlStr = "https://api.github.com/search/code?q=\(text)"
        guard let url = URL(string: urlStr) else {
            return
        }

        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                guard let jsonStr = String(data: data, encoding: .utf8) else {
                    throw NSError(domain: "dataはjsonじゃないよ", code: 100)
                }
                
                print(jsonStr)
                
            } catch let error {
                print(error)
            }
        }
    }
}

extension GithubAPIViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}
