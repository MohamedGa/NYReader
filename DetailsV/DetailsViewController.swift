//
//  detailsViewController.swift
//  NYReader
//
//  Created by Hp  on 24/01/2022.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var bodyLabel: UILabel!
    var viewModel : DetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bodyLabel.text = viewModel?.body()
    }
}
