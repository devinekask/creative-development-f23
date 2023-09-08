import * as THREE from 'three';
import { createCloud } from "./cloud";

export const createSky = () => {
  // Create an empty container
  const mesh = new THREE.Object3D();
  
  // choose a number of clouds to be scattered in the sky
  const nClouds = 20;
  
  // To distribute the clouds consistently,
  // we need to place them according to a uniform angle
  const stepAngle = Math.PI*2 / nClouds;
  
  // create the clouds
  for(let i=0; i<nClouds; i++){
    const { mesh: cloudMesh } = createCloud();
   
    // set the rotation and the position of each cloud;
    // for that we use a bit of trigonometry
    const a = stepAngle*i; // this is the final angle of the cloud
    const h = 750 + Math.random()*200; // this is the distance between the center of the axis and the cloud itself

    // Trigonometry!!! I hope you remember what you've learned in Math :)
    // in case you don't: 
    // we are simply converting polar coordinates (angle, distance) into Cartesian coordinates (x, y)
    cloudMesh.position.y = Math.sin(a)*h;
    cloudMesh.position.x = Math.cos(a)*h;

    // rotate the cloud according to its position
    cloudMesh.rotation.z = a + Math.PI/2;

    // for a better result, we position the clouds 
    // at random depths inside of the scene
    cloudMesh.position.z = -400-Math.random()*400;
    
    // we also set a random scale for each cloud
    const s = 1+Math.random()*2;
    cloudMesh.scale.set(s,s,s);

    // do not forget to add the mesh of each cloud in the scene
    mesh.add(cloudMesh);  
  }

  return {
    mesh
  };
}