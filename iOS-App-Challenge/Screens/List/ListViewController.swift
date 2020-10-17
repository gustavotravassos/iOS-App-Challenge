//
//  ListViewController.swift
//  iOS-App-Challenge
//
//  Created by Gustavo Travassos on 17/10/20.
//

import UIKit
import Kingfisher

class ListViewController: UIViewController {
    // MARK: - References
    var request = APIRequest()
    
    // MARK: - Variables
    var popularShowsDay: [TVShow]?
    var popularShowsWeek: [TVShow]?
    
    // MARK: - Outlets
    @IBOutlet weak var mainTableView: UITableView!
    
    // MARK: - ColletionView & TableView ReuseIdentifiers
    let weekReuseIdentifier = "weekTableViewCell"
    let dayTableViewReuseIdentifier = "dayTableViewCell"
    let dayCollectionViewReuseIdentifier = "dayColletionViewCell"
    
    // MARK: - ViewController Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        fetchWeekPopularShows()
        fetchDayPopularShows()
    }
    
    // MARK: - Services Functions
    /// Function to fetch the daily most popular TV Shows list
    func fetchDayPopularShows() {
        request.fetchMostPopularShowsDay() { response, error in
            self.popularShowsDay = response
            self.updateDailyPopularShows()
        }
    }
    
    /// Function to fetch the weekly most popular TV Shows list
    func fetchWeekPopularShows() {
        request.fetchMostPopularShowsWeek() { response, error in
            self.popularShowsWeek = response
            self.updateWeeklyPopularShows()
        }
    }
    
    
    // MARK: - User Interface Functions
    /// Function to update the Daily Popular TV Shows CollectionView
    func updateDailyPopularShows() {
        DispatchQueue.main.async {
            self.mainTableView.reloadSections(IndexSet(arrayLiteral: 0), with: UITableView.RowAnimation.top)
            self.mainTableView.reloadData()
        }
    }
    
    /// Function to update the Weekly Popular TV Shows TableView
    func updateWeeklyPopularShows() {
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
    }
}

// MARK: - TableView DataSource & Delegate
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return popularShowsWeek?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section ==  0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: dayTableViewReuseIdentifier, for: indexPath) as! DayTableViewCell
            
            cell.popularDayCollectionView.delegate = self
            cell.popularDayCollectionView.dataSource = self
            cell.selectionStyle = .none
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: weekReuseIdentifier, for: indexPath) as! WeekTableViewCell
            
            let show = popularShowsWeek?[indexPath.row]
            cell.showTitle.text = show?.title
            cell.showOverview.text = show?.overview
            cell.selectionStyle = .none
            
            cell.showPoster.kf.setImage(with: show?.imageURL, completionHandler: { result in
                switch result {
                case .failure:
                    cell.showPoster.image = #imageLiteral(resourceName: "ErrorImage")
                case .success:
                    break
                }
            })
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Click")
    }
}

// MARK: - ColletionView DataSource & Delegate
extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dayCollectionViewReuseIdentifier, for: indexPath) as! DayCollectionViewCell
        let show = popularShowsDay?[indexPath.row]
        cell.showTitle.text = show?.title
        
        cell.showPoster.kf.setImage(with: show?.imageURL, completionHandler: { result in
            switch result {
            case .failure:
                cell.showPoster.image = #imageLiteral(resourceName: "ErrorImage")
            case .success:
                break
            }
        })
        return cell
    }
}
