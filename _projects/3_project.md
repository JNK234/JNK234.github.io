---
layout: page
title: E-yantra Robotics Competition
description: National robotics competition - Automated warehouse system with ROS
img: assets/img/3.jpg
importance: 3
category: work
github: https://github.com/jnk-codes/eyrc-warehouse-automation
github_repo: eyrc-warehouse-automation
tech_stack: [ROS, Python, C++, Gazebo, OpenCV, PCL]
achievement: "Score: 97.96/100 - Top 5% Nationally"
---

## 🏆 Top Performance - National Robotics Competition

E-yantra is India's premier robotics competition hosted by IIT Bombay, where teams from across the country compete to solve real-world problems using robotics and automation. Our team achieved an exceptional score of **97.96/100** in the 2020-21 edition.

## Competition Challenge: Automated Warehouse Management

### Problem Statement
Design and implement a fully automated warehouse management system capable of:
- Autonomous navigation and path planning
- Package identification and sorting
- Multi-robot coordination
- Real-time inventory management
- Optimal delivery scheduling

## Technical Implementation

### System Architecture
```
ROS Master Node
├── Navigation Stack
│   ├── SLAM (gmapping)
│   ├── Path Planning (A* algorithm)
│   └── Obstacle Avoidance
├── Computer Vision
│   ├── ArUco Marker Detection
│   ├── Package Recognition
│   └── Color-based Sorting
└── Control Systems
    ├── PID Controllers
    ├── State Machine
    └── Multi-threading
```

### Key Technologies

#### Robotics & Simulation
- **ROS (Robot Operating System)**: Distributed computing framework
- **Gazebo Simulator**: Physics-based 3D simulation
- **RViz**: Visualization and debugging
- **MoveIt**: Motion planning framework

#### Algorithms & Optimization
- **Path Planning**: Custom A* implementation with dynamic re-routing
- **Task Scheduling**: Priority queue-based package delivery
- **Multi-threading**: 50% performance improvement in simulation
- **State Machine**: Finite state machine for robot behavior

## Competition Performance

### Technical Achievements
- **Score**: 97.96/100 (Top 5% nationally)
- **Simulation Speed**: 50% faster than baseline through optimization
- **Accuracy**: 100% package delivery success rate
- **Efficiency**: 30% reduction in total path distance

### Implementation Highlights

#### 1. Multi-Robot Coordination
```python
# Distributed task allocation algorithm
- Dynamic priority assignment
- Collision-free path planning
- Real-time communication via ROS topics
```

#### 2. Computer Vision Pipeline
```python
# Package identification system
- ArUco marker detection for precise localization
- HSV color space for robust color detection
- Real-time processing at 30 FPS
```

#### 3. Performance Optimization
- Implemented multi-threading for parallel task execution
- Optimized path planning algorithm reducing computation by 40%
- Custom message types for efficient ROS communication

## Team Leadership

As **Team Lead**, I was responsible for:
- System architecture design and integration
- Task delegation and sprint planning
- Code review and quality assurance
- Weekly progress presentations to mentors

### Team Management
- Led 4-person team through 6-month development cycle
- Conducted daily stand-ups and weekly retrospectives
- Managed Git workflow and CI/CD pipeline
- Coordinated with IIT Bombay mentors for technical guidance

## Learning Outcomes

### Technical Skills Gained
- Advanced ROS development and debugging
- Real-time system optimization
- Computer vision implementation
- Distributed system architecture

### Soft Skills Developed
- Technical leadership
- Project management
- Remote collaboration (during COVID-19)
- Problem-solving under pressure

## Competition Timeline

**Sept 2020**: Team formation and problem statement release
**Oct-Nov 2020**: Algorithm development and simulation setup
**Dec 2020-Jan 2021**: Implementation and optimization
**Feb-Mar 2021**: Testing and refinement
**April 2021**: Final submission and evaluation
**May 2021**: Results announcement - Score: 97.96/100

## Impact

This competition experience directly influenced my career trajectory:
- Foundation for robotics and automation expertise
- Led to internship opportunity at Invento Robotics
- Demonstrated leadership capabilities early in career
- Published implementation details on GitHub (1000+ views)

## Repository

<div class="d-flex justify-content-center">
    <a href="https://github.com/jnk-codes/eyrc-warehouse-automation" class="btn btn-primary btn-sm" target="_blank">
        <i class="fa-brands fa-github"></i> View Code
    </a>
    <span class="badge badge-success ml-2">Score: 97.96/100</span>
</div>

The complete implementation includes:
- Comprehensive documentation
- Setup instructions  
- Video demonstrations
- Performance benchmarks