/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2013 Mick Grierson, Matthew Yee-King, Marco Gillies
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

function CollisionDetector(physics, applet){
  var contactListener = new Box2D.Dynamics.b2ContactListener;
  contactListener.m_applet = physics.m_sketch;//applet;
  
  contactListener.collisionHappened = false;
  
  //if(contactListener.m_applet.getProcessingSketchId){
  //  contactListener.m_applet = contactListener.m_applet.Processing.getInstanceById(contactListener.m_applet.getProcessingSketchId());
  //}
  
  contactListener.BeginContact = function(contact) {
     this.collisionHappened = true;
  }; 
  
  contactListener.PostSolve = function(contact, impulse) {
    if(this.collisionHappened){
      this.m_applet.collision(contact.GetFixtureA().GetBody(), contact.GetFixtureB().GetBody(), impulse.normalImpulses[0]); 
    }
    this.collisionHappened = false;
  }; 
  physics.getWorld().SetContactListener(contactListener);
  return contactListener;
}
