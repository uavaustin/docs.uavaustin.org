# Orchestra

[Orchestra](https://github.com/uavaustin/orchestra) is a group of Docker Compose-managed services that perform specific facilities for plane-ground communications. Services communicate with each other through [Protocol Buffers](https://developers.google.com/protocol-buffers) over HTTP. Services can also communicate through [JSON](https://www.json.org/json-en.html) by changing the Accept/Content-Type header to 'application/json'.

## Services

Services are sorted in order of dependency; more critical services go first.

### Interop Proxy
Wraps the SUAS interoperability server (the "interop") with a more consistent interface that can be accessed by other services. Login state to interop is saved.

*Languages/Tools*: [Elixir](https://elixir-lang.org), [Phoenix](https://phoenixframework.org)

### MAVProxy
Present on both aircraft and ground station. Allows for communication between Telemetry, Mission Planner, and the aircraft. Communicates through an exposed UDP socket.

*Languages/Tools*: [MAVProxy](https://github.com/ArduPilot/MAVProxy)

### Telemetry
Present on both aircraft and ground station. On the ground, receives telemetry information to be sent to interop (yaw, lat, lon, alt), sends/receives mission data (waypoints), and supplies vital information about the aircraft (GPS, battery, speed, velocity) to the ground station. Communicates with MAVProxy through the MavLINK protocol via UDP.

*Languages/Tools*: Javascript, [Node.JS](https://nodejs.org/en/), [Jest](https://jestjs.io/)

### Forward Interop
Forwards telemetry data to Interop Proxy and keeps track of the upload rate, both unique and raw telemetry.

*Languages/Tools*: Javascript, [Node.JS](https://nodejs.org/en/), [Jest](https://jestjs.io/) 

### Imagery
Present on both aircraft and ground station. Aircraft uses the Z Camera E1 backend, ground uses the sync backend (still a work in progress), and testing uses the file backend. Service captures photos on a specified interval and saves the pictures, telemetry metadata and the assigned ID into a database.

*Languages/Tools*: Javascript, [Node.JS](https://nodejs.org/en/), [SQLite](https://www.sqlite.org/index.html), [Jest](https://jestjs.io/)

### Image Rec Master
Takes in photos (IDs) from imagery and passes them through a pipeline where they are processed (manual or auto), discarded, or submitted into a separate target pipeline. The target pipeline can submit ODLCs to the interop-proxy server or remove targets submitted to the interop server.

*Languages/Tools*: Python, [Redis](https://redis.io/)

### Pong
Pings all the other services (and specified devices via ICMP ping) to check on their health.

*Languages/Tools*: Javascript, [Node.JS](https://nodejs.org/en/), [Jest](https://jestjs.io/)

### Lumberjack
**[In Development]** Logs data from other services into a time-series database (InfluxDB). Currently shows service ping from Pong, upload rate from Forward Interop, and the status of Telemetry on plane and ground.

*Languages/Tools*: Javascript, [Node.JS](https://nodejs.org/en/), [Jest](https://jestjs.io/), [InfluxDB](https://www.influxdata.com/)

### Grafana
**[In Development]** real time dashboard visualization of data being collected in Lumberjack.

*Languages/Tools*: [Grafana](https://grafana.com/)

### Dashboard
**[Deprecated]** text-based dashboard that shows telemetry upload rates and the statuses of other services.

*Languages/Tools*: Javascript, [Node.JS](https://nodejs.org/en/), [Jest](https://jestjs.io/)

## Language Choice

Services that are too critical to tolerate failure were written in Elixir. The only exception is Telemetry, which was written in Node.js due to the complexity in communicating over the MAVLink protocol.

When Orchestra was being developed, there was a brief discussion over which language to use. Originally, Rust was to be used for Telemetry; however, after staring at the sixty lines of Rust that took me three weeks to write, it was decided that Rust had perhaps too steep of a learning curve to start such a complicated project as Telemetry.

Another contender was Python. There were few issues with Python, although dependencies tended to run large, and there may have been perhaps a desire to move toward functional programming, which JavaScript was beginning to support. And since we were intending to make HTTP-based microservices, Node.js seemed to fit the bill from its proven web performance.

----

*This page was derived from the HackMD document* [An Overview of UAV Austin](https://hackmd.io/bzfxlPXtTHemOK_KhwLzRw).
