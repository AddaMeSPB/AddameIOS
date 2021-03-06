//
//  EventEnvironment.swift
//  
//
//  Created by Saroar Khandoker on 12.04.2021.
//

import Combine
import ComposableArchitecture
import ComposableCoreLocation
import PathMonitorClient
import EventClient

public struct EventsEnvironment {
    
  let pathMonitorClient: PathMonitorClient
  var locationManager: LocationManager
  let eventClient: EventClient
  public var mainQueue: AnySchedulerOf<DispatchQueue>
  
  public init(
    pathMonitorClient: PathMonitorClient,
    locationManager: LocationManager,
    eventClient: EventClient,
    mainQueue: AnySchedulerOf<DispatchQueue>
  ) {
    self.pathMonitorClient = pathMonitorClient
    self.locationManager = locationManager
    self.eventClient = eventClient
    self.mainQueue = mainQueue
  }
  
}
