//
//  DetailsViewController.swift
//  iOS-App-Challenge
//
//  Created by Gustavo Travassos on 17/10/20.
//

import UIKit

class DetailsViewController: UIViewController {
    // MARK: - References
    var request = APIRequest()
    
    // MARK: - Outlets
    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var showGenres: UILabel!
    @IBOutlet weak var showRating: UILabel!
    @IBOutlet weak var showPoster: UIImageView!
    @IBOutlet weak var showOverview: UITextView!
    @IBOutlet weak var genreLoadingIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    var show: TVShow?
    var genres: [Genre]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchGenres()
        updateInformation()
    }
    
    // MARK: - Services Functions
    /// Function that fetches the TV Show main genres
    func fetchGenres() {
        genreLoadingIndicator.startAnimating()
        
        guard let id = show?.id else { return }
        request.fetchGenres(id: id, completionHandler: { response, error in
            self.genres = response
            self.updateGenreInformation()
        })
    }
    
    // MARK: - User Interface Functions
    /// Function that updates the UI information with the current selected show
    func updateInformation() {
        guard let show = show else { return }
        
        showTitle.text = show.title
        showRating.text = "\(show.rating ?? 10.0)"
        showOverview.text = show.overview
        
        showPoster.kf.setImage(with: show.imageURL, completionHandler: { result in
            switch result {
            case .failure:
                self.showPoster.image = #imageLiteral(resourceName: "ErrorImage")
            case .success:
                break
            }
        })
    }
    
    func updateGenreInformation() {
        guard let genres = genres else { return }
        
        DispatchQueue.main.async {
            self.showGenres.text = "\(genres[0].name ?? "")"
            self.genreLoadingIndicator.stopAnimating()
        }
    }
}
