🎮 Drag & Motion Animation

This animation demonstrates an interactive drag-based UI where multiple items move smoothly based on user interaction. Each item responds to drag gestures and animates to its position using multiple AnimationController instances.

✨ Key Concepts

Drag-to-Move Elements → UI cards/buttons change position depending on user drag direction.

Multi-Controller Animation
Three independent animations control:

Favorite Section

Music Section

Sensors Section

PageView Fade Animation
controllerOpcityPageView handles opacity transition when changing pages.

Alignment Animation
Moving widgets based on AlignmentDirectional values:

topCenter → center → bottomCenter

🎛️ Animation Setup
controllerFavorite = AnimationController(duration: 400ms);
controllerMusic = AnimationController(duration: 400ms);
controllerSensors = AnimationController(duration: 400ms);
controllerOpcityPageView = AnimationController(duration: 200ms);


Each controller triggers smooth UI motion when the drag state updates.

🧠 State Management (BLoC)

The drag system uses BLoC to sync animation state across the UI.

📍 Bloc State Variables
Variable	Purpose
draging	Tracks the current alignment of dragged item
isActive	Indicates if the dragged item is active (being moved)
📲 Bloc Events
Event	Behavior
DragingEvent	Updates item alignment and triggers animation
ActiveItemEvent	Enables active animation state while dragging
🔁 Flow

User drags an item on screen

UI sends DragingEvent(alignment: newAlignment)

BLoC updates draging value

Corresponding AnimationController runs motion

Page fades or moves according to drag position

🚀 Result

This animation creates:

Smooth drag transitions

Real-time UI alignment updates

Polished motion effects using multiple animation controllers

PageView opacity animation on state change

Perfect for building interactive dashboards, music apps, or gesture-driven interfaces.



🎥 Preview

https://github.com/user-attachments/assets/8fd6ad61-2e9e-4cf5-a202-88c28aa42f42


🧰 Used Technologies

Tech	Role

Flutter AnimationController	Movement & transitions

AlignmentDirectional	Drag position logic

PageController	PageView control

BLoC	Real-time drag state sync
