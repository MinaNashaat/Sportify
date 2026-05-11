//
//  onBoarding1ViewController.swift
//  Sportify
//
//  Created by Mina on 07/05/2026.
//

import UIKit

class onBoarding1ViewController: UIViewController {

    @IBOutlet weak var myButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func nextButton(_ sender: UIButton) {
        if let pageVC = parent as? myPageViewController {
                    pageVC.goToNextPage()
                }
    }
    
    @IBAction func skipButton(_ sender: UIButton) {
        let tabBar =
            AppRouterImpl.createHomeModule()

        navigationController?.pushViewController(tabBar, animated: true)

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
