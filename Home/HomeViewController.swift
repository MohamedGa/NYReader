//
//  HomeViewController.swift
//  NYReader
//
//  Created by Hp  on 24/01/2022.
//

import UIKit


extension HomeViewController: HomeViewModelProtocol {
    func dataUpdated() {
        alertController?.dismiss(animated: true, completion: {
            self.alertController = nil
        })
        tableView.reloadData()
    }
    
    func showLoader() {
        if alertController == nil {
            alertController = displayActivityIndicator()
        }
    }
}


class HomeViewController: UIViewController {
    //MARK: - Properties
    @IBOutlet var tableView: UITableView!
    var alertController: UIAlertController?
    
    //MARK: Computed
    var viewModel: HomeViewModel?
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HomeViewModel(viewController: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        viewModel?.prepareForDetailsViewController(segue: segue)
    }
    
    
    // MARK: Pivate Methods
    func displayActivityIndicator() -> UIAlertController {
            //create an alert controller
        let pending = UIAlertController(title: "", message: nil, preferredStyle: .alert)

            //create an activity indicator
            let indicator = UIActivityIndicatorView(frame: pending.view.bounds)
            indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            //add the activity indicator as a subview of the alert controller's view
            pending.view.addSubview(indicator)
            indicator.isUserInteractionEnabled = false // required otherwise if there buttons in the UIAlertController you will not be able to press them
            indicator.startAnimating()

            self.present(pending, animated: true, completion: nil)

            return pending
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfArticles() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
        cell.titleLabel.text = viewModel?.title(atIndex: indexPath.row)
        cell.headLineLabel.text = viewModel?.headline(atIndex: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        viewModel?.selectedIndex = indexPath.row
        
        return indexPath
    }
}
