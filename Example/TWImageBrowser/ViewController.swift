//
//  ViewController.swift
//  TWImageBrowser
//
//  Created by Tae Woo Kang on 05/26/2016.
//  Copyright (c) 2016 magicmon. All rights reserved.
//

import UIKit
import TWImageBrowser

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    let interactor = Interactor()
    
    private let kTestCellMenuIdentifier = "kTestCellMenuIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let dequeuedCell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(kTestCellMenuIdentifier)
        var cell: UITableViewCell? = nil
        
        if let dequeuedCell = dequeuedCell {
            cell = dequeuedCell
        } else {
            cell = UITableViewCell(style: .Default, reuseIdentifier: kTestCellMenuIdentifier)
            cell?.selectionStyle = .Gray
        }
        
        switch indexPath.row {
        case 0:
            cell?.textLabel?.text = "Normal Type (Image)"
        case 1:
            cell?.textLabel?.text = "Normal Type (GIF)"
        case 2:
            cell?.textLabel?.text = "Browser Type"
        default:
            break
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            performSegueWithIdentifier("NormalSegue", sender: nil)
        case 1:
            if let controller = self.storyboard?.instantiateViewControllerWithIdentifier("GIFViewController") {
                self.navigationController?.pushViewController(controller, animated: true)
            }
        case 2:
            if let controller = self.storyboard?.instantiateViewControllerWithIdentifier("BannerController") {
                self.navigationController?.pushViewController(controller, animated: true)
            }
        default:
            break
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationViewController = segue.destinationViewController as? UINavigationController {
            
            destinationViewController.transitioningDelegate = self
            if let vc = destinationViewController.viewControllers.first as? NormalController {
                vc.interactor = interactor
            }
        }
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}