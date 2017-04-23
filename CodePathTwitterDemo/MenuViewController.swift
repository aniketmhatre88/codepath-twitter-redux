//
//  MenuViewController.swift
//  CodePathTwitterDemo
//
//  Created by Mhatre, Aniket on 4/22/17.
//  Copyright © 2017 Mhatre, Aniket. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var viewControllers = [String: UIViewController]()
    var hamburgerViewController: HamburgerViewController!
    
    @IBOutlet weak var menuTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profileNavigationController = storyboard.instantiateViewController(withIdentifier: "ProfileNavigationController") as! UINavigationController
        let profileViewController = profileNavigationController.topViewController as! ProfileViewController
        profileViewController.user = User.currentUser
        
        viewControllers["Profile"] = profileNavigationController
        viewControllers["Timeline"] = storyboard.instantiateViewController(withIdentifier: "TweetsNavigationController")
        
        hamburgerViewController.contentViewController = profileNavigationController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let menuItems = Array(viewControllers.keys)
        
        let cell = menuTableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.menuItemLabel.text = menuItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menuTableView.deselectRow(at: indexPath, animated: true)
        
        let menuItems = Array(viewControllers.keys)
        let selectedItem = menuItems[indexPath.row]
        
        hamburgerViewController.contentViewController = viewControllers[selectedItem]!
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
