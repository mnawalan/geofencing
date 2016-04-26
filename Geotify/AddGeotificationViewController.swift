//
//  AddGeotificationViewController.swift
//  Geotify
//
//  Created by Ken Toh on 24/1/15.
//  Copyright (c) 2015 Ken Toh. All rights reserved.
//

import UIKit
import MapKit

protocol AddGeotificationsViewControllerDelegate {
  func addGeotificationViewController(controller: AddGeotificationViewController,didAddCoordinate coordinate: CLLocationCoordinate2D,
    radius: Double, identifier: String, note: String, eventType: EventType)
}

class AddGeotificationViewController: UITableViewController {

  @IBOutlet var addButton: UIBarButtonItem!
  @IBOutlet var zoomButton: UIBarButtonItem!

  @IBOutlet weak var eventTypeSegmentedControl: UISegmentedControl!
  @IBOutlet weak var radiusTextField: UITextField!
  @IBOutlet weak var noteTextField: UITextField!
  @IBOutlet weak var mapView: MKMapView!

  var delegate: AddGeotificationsViewControllerDelegate!
  var Knott = Geotification(coordinate: CLLocationCoordinate2D(latitude: 41.703682, longitude: -86.233733), radius: 500, identifier: "Welcome to Knott Grilled Cheese", note: "Serving the best Grilled Cheese on campus!", eventType: .OnEntry)

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.rightBarButtonItems = [addButton, zoomButton]
    addButton.enabled = false

    tableView.tableFooterView = UIView()
  }

  @IBAction func textFieldEditingChanged(sender: UITextField) {
    addButton.enabled = !radiusTextField.text!.isEmpty && !noteTextField.text!.isEmpty
  }

  @IBAction func onCancel(sender: AnyObject) {
    //delegate!.addGeotificationViewController(self, didAddCoordinate: Knott.coordinate, radius: 500, identifier: Knott.identifier, note: Knott.note, eventType: .OnEntry)
    dismissViewControllerAnimated(true, completion: nil)
  }

  @IBAction private func onAdd(sender: AnyObject) {
    var coordinate = mapView.centerCoordinate
    var radius = (radiusTextField.text! as NSString).doubleValue
    var identifier = NSUUID().UUIDString
    var note = noteTextField.text
    var eventType = (eventTypeSegmentedControl.selectedSegmentIndex == 0) ? EventType.OnEntry : EventType.OnExit
    
   // delegate!.addGeotificationViewController(self, didAddCoordinate: coordinate, radius: radius, identifier: identifier, note: note!, eventType: eventType)
   delegate!.addGeotificationViewController(self, didAddCoordinate: coordinate/*Knott.coordinate*/, radius: 500, identifier: NSUUID().UUIDString, note: Knott.note, eventType: eventType)
    print("coordinate: \(coordinate)")
    print("radius: \(radius)")
    print("identifier: \(identifier)")
    print("note: \(note)")
    print(eventType)
    
    dismissViewControllerAnimated(true, completion: nil)
    
  }

  @IBAction private func onZoomToCurrentLocation(sender: AnyObject) {
    zoomToUserLocationInMapView(mapView)
  }
}
