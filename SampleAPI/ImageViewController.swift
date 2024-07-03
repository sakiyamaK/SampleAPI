//
//  ViewController.swift
//  SampleAPI
//
//  Created by sakiyamaK on 2024/06/27.
//

import UIKit

extension UIView {
    func applyConstraintSafeArea(toView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: toView.safeAreaLayoutGuide.topAnchor),
            self.leadingAnchor.constraint(equalTo: toView.safeAreaLayoutGuide.leadingAnchor),
            self.bottomAnchor.constraint(equalTo: toView.safeAreaLayoutGuide.bottomAnchor),
            self.trailingAnchor.constraint(equalTo: toView.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}


class ImageViewController: UIViewController {

    private weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        
        self.view.addSubview(stackView)
        
        stackView.applyConstraintSafeArea(toView: self.view)
 
        let searchBar = UISearchBar()
        searchBar.delegate = self
        stackView.addArrangedSubview(searchBar)
                
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.lightGray
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        stackView.addArrangedSubview(imageView)
        
        self.imageView = imageView
    }
}

extension ImageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                
        guard let text = searchBar.text, let url = URL(string: text) else {
            return
        }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                guard let image = UIImage(data: data) else {
                    throw NSError(domain: "dataは画像じゃないよ", code: 100)
                }
                
                self.imageView.image = image
            } catch let error {
                print(error)
            }
        }
    }
}
