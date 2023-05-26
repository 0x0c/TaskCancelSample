//
//  ViewController.swift
//  TaskCancelSample
//
//  Created by Akira Matsuda on 2023/05/26.
//

import UIKit

class ViewController: UIViewController {

    var currentTask: Task<Void, Never>?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startTask(_ sender: Any) {
        currentTask = Task { [unowned self] in
            print("Main thread: \(Thread.current.isMainThread)")
            activityIndicator.startAnimating()
            await withTaskCancellationHandler(operation: {
                print("Start task")
                sleep(1)
                print("1")
                sleep(1)
                print("2")
                sleep(1)
                print("3")
                sleep(1)
                print("finish")
            }, onCancel: {
                print("Cancel")
            })
            activityIndicator.stopAnimating()
        }
    }

    @IBAction func startDetachedTask(_ sender: Any) {
        currentTask = Task.detached { [unowned self] in
            print("Main thread: \(Thread.current.isMainThread)")
            await self.activityIndicator.startAnimating()
            await withTaskCancellationHandler(operation: {
                print("Start task")
                sleep(1)
                print("1")
                sleep(1)
                print("2")
                sleep(1)
                print("3")
                sleep(1)
                print("finish")
            }, onCancel: {
                print("Cancel")
            })
            await self.activityIndicator.stopAnimating()
        }
    }

    @IBAction func cancelTask(_ sender: Any) {
        currentTask?.cancel()
    }
}
