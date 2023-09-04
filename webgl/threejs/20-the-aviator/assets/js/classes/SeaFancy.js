import * as THREE from 'three';
import * as BufferGeometryUtils from 'three/addons/utils/BufferGeometryUtils.js';
import { COLORS, randomBetween } from '../static/helpers.js';

export default class Sea {
  constructor() {
    let geom = new THREE.CylinderGeometry(600, 600, 800, 40, 10);
    geom.applyMatrix4(new THREE.Matrix4().makeRotationX(-Math.PI / 2));

    // mergeVertices only works without normal and uv attribute
    // duplicate the normal and uv
    const normal = geom.attributes.normal;
    const uv = geom.attributes.uv;

    geom.deleteAttribute( 'normal' );
    geom.deleteAttribute( 'uv' );
    geom = BufferGeometryUtils.mergeVertices( geom );

    // add the attributes back to the geometry
    geom.setAttribute( 'normal', normal );
    geom.setAttribute( 'uv', uv );

    // get the vertices
    const positions = geom.attributes.position.array;

    // create an array to store new data associated to each vertex
    this.waves = [];

    for (let i = 0; i < positions.length; i+=3) {
      // get each vertex
      const x = positions[i];
      const y = positions[i+1];
      const z = positions[i+2];

      // store some data associated to it
      this.waves.push({
        y: y,
        x: x,
        z: z,
        // a random angle
        ang: randomBetween(0, Math.PI * 2),
        // a random distance
        amp: randomBetween(5, 15),
        // a random speed between 0.016 and 0.048 radians / frame
        speed: randomBetween(0.016, 0.032),
      });
    };
    const mat = new THREE.MeshPhongMaterial({
      color: COLORS.blue,
      transparent: true,
      opacity: .8,
      flatShading: true,
    });

    this.mesh = new THREE.Mesh(geom, mat);
    this.mesh.receiveShadow = true;
  }

  moveWaves() {
    // get the vertices
    const positions = this.mesh.geometry.attributes.position.array;

    for (let i = 0; i < positions.length; i+=3) {

      // get the data associated to it
      const vprops = this.waves[i/3];

      // update the position of the vertex
      positions[i] = vprops.x + Math.cos(vprops.ang) * vprops.amp;
      positions[i+1] = vprops.y + Math.sin(vprops.ang) * vprops.amp;

      // increment the angle for the next frame
      vprops.ang += vprops.speed;
    }

    // Tell the renderer that the geometry of the sea has changed.
    this.mesh.geometry.attributes.position.needsUpdate = true;
  }
}
