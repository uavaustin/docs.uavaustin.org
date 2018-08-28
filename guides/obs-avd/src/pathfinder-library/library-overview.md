# Exposed API
The library is structured as a Pathfinder object which must be initialized before it can process path finding requests.  For initialization, it requires the following parameters:

* `grid_size`: denotes how large a node in the grid is in meters
* `flyzones`: a 2D vector of Point object representing the flyzones due to the possibility of multiple flyzones
* `obstacles`: a vector of Obstacle objects

The following parameters are exposed through getter/setter methods

* `grid_size`: denotes how large a node in the grid is in meters
* `buffer`: a buffer radius that's added to obstacles radius in meters
* `max_process_time`: amount of time to adjust the path before returning in seconds
* `fly_zones`: the list of flyzones boundary
* `obstacles`: the list of obstacles

The main functionality of the pathfinder library is the get_adjust_path method, which takes the plane position and a list of waypoints and returns a modified list of waypoints that circumvents obstacles.

# Library Structure
The code base is divided into several files for organizational purposes.  They are:

* `lib.rs` - contains the definition for the Pathfinder struct and implementation of the obstacle avoidance algorithms
* `node.rs` - defines the node struct which represent a node in the grid and contains methods to convert between node and point representing physical coordinates.
* `obj.rs` - defines other data structures such as Plane, Obstacles, Point, and Waypoint for API interface.
* `util.rs` - contains utility functions
