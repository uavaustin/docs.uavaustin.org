# Timeline

This section is divided into hardware and software, in alignment with the historical division of the hardware and software teams. Other known competition history is documented below.

## Hardware History

### *Phoenix* (2009)

*Phoenix* was derived from the Senior Telemaster, a tail-dragger kit plane with a 11.5cc engine. It was the UAV Group's first aircraft entered into the AUVSI SUAS competition.

### *Phoenix II* (2010-2012)

*Phoenix II* was a custom-built aircraft using carbon/Kevlar composites.
See the [2010 paper](http://www.auvsi-suas.org/static/competitions/2010/journals/auvsi_suas-2010-journals-university_of_texas_austin.pdf) for more information.

### *Kratos* (2014)

*Kratos* was a high-wing plane derived from the Sig Kadet Senior kit plane. 
(UAV Austin did not compete in 2013 - this was essentially a reboot of the "UT Unmanned Aerial Vehicle Group" with new members.)

### *Darth Bevo* (2015-2016)

"It was awful." -- Bradley Bridges, probably

*Darth Bevo* was a rebuilt version of *Kratos*, as *Kratos* had been heavily modified to the point of unmaintainability.

### *Hugin II* (2017)

*Hugin II* was a standard pusher design derived from a kit plane of the same name.

### *Sir-Vay-Lance (SVL)* (2018)

*SVL* was a pusher plane based on the heavily modified *Hugin II*. While its flight profile and maneuverability were satisfactory, its setup time and decline into disrepair rendered it unusable for the long term. (However, it still makes for a decent trainer.)

### *Phoenix III* (2019)

A polished boom-prop design made as a work of passion by Evan Wilde, *Phoenix III* is anticipated to meet the design needs of UAV Austin for the distant future.

## Software History

### Unnamed systems (the past)

Due to a rapidly-changing software environment, the software stack was in constant flux. While image recognition was always an attempted mission objective, its effectiveness could never be proven in flight. Image recognition software ranged from the NI Vision Development Module (via LabVIEW) to OpenCV.

### MATLAB (?-2017)

Most calculations depended on a set of MATLAB scripts.

### Orchestra (2017-)

With the work of Bradley Bridges, the entire software stack was rewritten to use containerized microservices that communicate with each other. By 2018, there were microservices written in Elixir, Node.js, Python, and Rust, all performing different tasks.

## Competition History

### 2017

The Flight Readiness Review was changed from an in-person presentation to a 15-minute video.

### 2019

The water bottle drop was changed to an unmanned ground vehicle (UGV) drop.

Tischler added a "mission ID" header requirement in anticipation of allowing multiple planes to fly simultaneously. This major change to the interop server was only made two months before the competition.

Waypoints were no longer provided at the opening banquet; instead, they were provided at mission setup time.

### 2020

Judges no longer require a dedicated monitor to see what is going on.

The FRR's length was reduced from 15 minutes to 10. The maximum length of the tech paper was also cut.

Two aircraft will be flown simultaneously.

----

*This page was derived from the HackMD document* [An Overview of UAV Austin](https://hackmd.io/bzfxlPXtTHemOK_KhwLzRw).
