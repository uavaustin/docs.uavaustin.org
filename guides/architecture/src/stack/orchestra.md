# Orchestra

[Orchestra](https://github.com/uavaustin/orchestra) is a group of Docker Compose-managed services that perform specific facilities for plane-ground communications. Services communicate with each other through [Protocol Buffers](https://developers.google.com/protocol-buffers) over HTTP.

## Services

Services are sorted in order of dependency; more critical services go first.

### Interop Proxy
Wraps the SUAS interoperability server (the "interop") with a more consistent interface that can be accessed by other services.

### MAVProxy
Exposes a USB serial modem on a TCP or UDP port, for use by telemetry and Mission Planner.

### Telemetry
Reports vital information about the aircraft, including GPS, battery, and waypoint information. Waypoints can also be modified by other services.

### Forward Interop
Polls data from the telemetry service and forwards it to the interop.

### Imagery
From the aircraft, automatically takes pictures, embeds telemetry metadata, and records them in a local database; from the ground station, automatically synchronizes images from the aircraft's imagery server.

### Image Rec Master
An intake for photos for automatic and manual image recognition. Images pass through a pipeline where they are processed, discarded, or submitted to the interop via the interop proxy.

### Pong
Pings a list of other services and devices to check on their health.

### Lumberjack
Logs other services' data into a time-series database. Currently, only uptime data is recorded, via the Pong service.

### Grafana
Visualizes the data collected by Lumberjack in real time.

### Dashboard
A deprecated text-based dashboard that shows telemetry upload rates and the statuses of other services.

## Language Choice

Services that are too critical to tolerate failure were written in Elixir. The only exception is Telemetry, which was written in Node.js due to the complexity in communicating over the MAVLink protocol.

When Orchestra was being developed, there was a brief discussion over which language to use. Originally, Rust was to be used for Telemetry; however, after staring at the sixty lines of Rust that took me three weeks to write, it was decided that Rust had perhaps too steep of a learning curve to start such a complicated project as Telemetry.

Another contender was Python. There were few issues with Python, although dependencies tended to run large, and there may have been perhaps a desire to move toward functional programming, which JavaScript was beginning to support. And since we were intending to make HTTP-based microservices, Node.js seemed to fit the bill from its proven web performance.

----

*This page was derived from the HackMD document* [An Overview of UAV Austin](https://hackmd.io/bzfxlPXtTHemOK_KhwLzRw).
