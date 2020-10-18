//
//  WeekTableViewCell.swift
//  iOS-App-Challenge
//
//  Created by Gustavo Travassos on 17/10/20.
//

import UIKit
import Kingfisher

class WeekTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var showPoster: UIImageView!
    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var showOverview: UILabel!
    @IBOutlet weak var showRating: UILabel!
    
    
    // MARK: - Auxliar Functions
    func setupTableViewCell(show: TVShow) {
        showTitle.text = show.title
        showOverview.text = show.overview
        showRating.text = "\(show.rating ?? 10)"
        
        if let url = show.imageURL { loadImage(posterPath: url) }
    }
    
    /// Function to try to load an image
    /// - Parameters:
    ///   - tries: Amount of tries (max. 3)
    ///   - posterPath: Image URL
    private func loadImage(_ tries: Int = 0, posterPath: URL) {
        showPoster.kf.setImage(with: posterPath, completionHandler: { result in
            switch result {
            case .failure:
                if tries == 3 {
                    self.showPoster.image = #imageLiteral(resourceName: "ErrorImage")
                } else {
                    self.loadImage(tries+1, posterPath: posterPath)
                }
            case .success:
                break
            }
        })
    }
}
