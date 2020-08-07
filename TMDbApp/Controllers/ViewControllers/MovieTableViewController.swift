//
//  MovieTableViewController.swift
//  TMDbApp
//
//  Created by Colton Swapp on 8/7/20.
//  Copyright © 2020 Colton Swapp. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var movieSearchBar: UISearchBar!
    

    // MARK: - Properties
    var movies: [Movie] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
       
       
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell()}

        let movie = self.movies[indexPath.row]
        cell.movieTitleLabel.text = movie.title
        cell.movieRatingLabel.text = "\(movie.vote_average ?? 0)"
        cell.movieOverviewLabel.text = movie.overview
        
        MovieController.fetchMoviePoster(for: movie) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    cell.moviePosterImageView.image = image
                case .failure(let error):
                    print(error.localizedDescription)
                    cell.moviePosterImageView.image = UIImage(named: "posterNotAvail")
                }
            }
        }
        

        return cell
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MovieTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        MovieController.fetchMovie(for: searchTerm) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let movie):
                    self.movies = movie
                    self.tableView.reloadData()
                    searchBar.text = ""
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
        
    }
}
