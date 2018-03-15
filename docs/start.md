## A recipe is born

Having spent the last few days trying a new approach to learning new aspects of code and experimenting with different ideas, I've come to a point where I can begin combining the elements produced into one cohesive package. This approach is to take a very simple set of building blocks (setting up a scene, camera and primitive objects) and implement only one system or component with these limited tools. The reason for doing so was a result of trying an [earlier project](https://louisfoster.github.io/ubiquitous-succotash/) where everything was attempted in single program and it became very confusing for me.

Although something like this could be isolated with something like feature branching in git, I wanted to ensure I could achieve my end goal without any other conflicting code, see if my ideas could be effective in a vacuum and not add extraneous code to the mix simply to fit with what may already be broken. Forunately, this approach was fairly effective, as I was able to combine this with previous learning experiences and other freely available resources.


### Mapping

The intro page refers to the projects I utilised previous. The first of those I chose to provide was the tile map. In order to implement this, I only required the `Map` and `Tile` classes, as well as my functions in `NodeHelpers`, which help generate the common objects to be rendered. The only change between this and the seed project was commenting out the repositioning of the map to offset a corner to the origin point. This was because I wanted to ensure the centre of each tile was a whole integer in world coordinates (not necessary, but I feel as though this may help me down the line).


### Looking

After the map was appearing nicely upon the screen with a basic camera setup, I wanted to utilise my camera harness system so that I could have a slightly more revealing angle and track an avatar. For this, I utilised the `Avatar` and `Harness` classes. The only changes I made to these was moving the automatic animations out into auxillary helper functions, which could be called if I needed them. The implementation was essentially identical as the seed project, and running it revealed my avatar placed upon the first tile in the map, with the camera looking over it in an almost "isometric" style. Sweet!


### Touching

The third part was to implement what was the most intense one to build. There were lots of changes throughout the project in order to use new concepts and ensure maximum portability. It was this project that also led me to want to implement the combination of all three in order to begin understanding how to scale the code base up in order to make it even more decoupled and scalable.

The files I used were the `Notifications` and `Closures` as they provided some necessary constants for the `InputIntent` system to work, which was also implemented. I only required the `GestureInterface` of the interface components in this project as well. Thankfully, none of these projects required alterations either. I found the packaging of the InputIntent along with the camera, harness and avatar was a little convoluted to justify implementing entirely in the setup code, so I moved this into a new system called `Camera`.

The `Camera` class implements the `HorizontalScrollIntentObserverProtocol` and handles the instantiation of the camera and the harness. Because of this, we pass it the global InputIntent system and the target (the avatar) so that the harness can take the camera and target. Additionally, this class can contain the onIntent required by the protocol, as this affects the Camera position based on the user input intent.

As a result of implementing this, I changed the wording used in the harness as it confused me and caused me to lose some time with needles debugging. Previously I had used the term "tracking" and "subject" as in, the "tracking" object to be "tracked" and the subject to be the "subject" of the commanding "tracking" object's position. I reverted these parameter names to master (tracking) and slave (subject), which meant the labels could stay the same and no additional code would need to change.

With the code now all set up, this was the result:


![combination0]({{ "./assets/combination0.gif" | absolute_url }})


### Reflection

I can see now that there are some areas I would like to refactor. The harness is one, as the position of the camera is hardcoded, and the purpose of the harness is singular. I would like to be able to customise the camera position easily, and choose between third and first person views. The requirement for the Camera class reveals the need to contain the different aspects of certain entities together, and operate them according to some kind of rules, but not necessarily package them in this kind of isolated, coupled manner.

There is some code refactoring to be done, as some things appear to be similar and repeat (such as, the helpers). I need to start providing various objects in the scene with similar components, such as the "Select Intent" observer protocol on map tiles and the avatar in order to see how I can manage it more effectively and get closer to the ECS pattern.

I would also like to see a slightly larger and more complex map, but also figure out how to, across various screen sizes, maintain a maximum number of visible tiles on the screen surrounding the avatar. Additionally, I would like a larger map that comes from either a data file or is procedurally generated.


[Home](./)