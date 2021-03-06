//
//  TabControlViewController.swift
//  ClanManager
//
//  Created by Jeffrey Wu on 2017-01-22.
//  Copyright (c) 2017 Cheeseonhead. All rights reserved.
//
//  This file was generated by the Clean Swift HELM Xcode Templates
//

import UIKit

protocol TabControlViewControllerInput
{
    func displaySettings(viewModel: TabControl.FetchSettings.ViewModel)
}

protocol TabControlViewControllerOutput
{
    func fetchSettings(request: TabControl.FetchSettings.Request)
}

protocol TabControlViewControllerRouter
{
    func openSettingsViewController()
    func passDataToViewUserViewController()
}

class TabControlViewController: UITabBarController, TabControlViewControllerInput
{
    var output: TabControlViewControllerOutput!
    var router: TabControlViewControllerRouter!

    fileprivate var currentPlayerTag: String!

    // MARK: Object lifecycle

    override func awakeFromNib()
    {
        super.awakeFromNib()
        TabControlConfigurator.sharedInstance.configure(viewController: self)
    }

    // MARK: View lifecycle

    override func viewDidAppear(_: Bool)
    {
        fetchSettingsOnAppear()
    }

    // MARK: Display
    func displaySettings(viewModel: TabControl.FetchSettings.ViewModel)
    {
        currentPlayerTag = viewModel.playerTag
        updateChildViewControllersIfVisible()
    }
}

fileprivate extension TabControlViewController
{
    func fetchSettingsOnAppear()
    {
        output.fetchSettings(request: TabControl.FetchSettings.Request())
    }

    func updateChildViewControllersIfVisible()
    {
        guard self.isViewVisible() && currentPlayerTag != nil else
        {
            return
        }

        if currentPlayerTag.characters.count > 0 {
            router.passDataToViewUserViewController()
        }
        else
        {
            router.openSettingsViewController()
        }
    }
}

extension TabControlViewController
{
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
}
