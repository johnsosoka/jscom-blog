---
title: 3D Models
permalink: /3d-models/
layout: page
excerpt: Printable 3D models I've designed.
---

A collection of 3D printable models I've designed. These were created using my [AI Powered 3D Printer Object Design Factory](/blog/2025/12/26/ai-3d-printer-design-factory.html).

**On this page:**
- [Schiit Device Mounting Brackets](#schiit-device-mounting-brackets) - Under-desk mounts for audio equipment

---

## Schiit Device Mounting Brackets

3D printable mounting brackets for Schiit Audio equipment, allowing you to mount DACs and amps under a desk or shelf. Print in PETG or ABS for heat resistance.

### Large Chassis (9" x 6")

**Compatible devices:** Jotunheim, Asgard 3, Lyr 3, Valhalla 3, Bifrost 2

<div class="row">
  <div class="col-md-6 mb-4">
    <div class="stl-container" id="jotunheim-left" data-model="https://files.johnsosoka.com/3d-models/schiit-jotunheim-v3-left-bracket.stl"></div>
    <div class="text-center mt-2">
      <strong>Left Bracket</strong><br>
      <a href="https://files.johnsosoka.com/3d-models/schiit-jotunheim-v3-left-bracket.stl" class="btn btn-outline-primary btn-sm" download>Download STL</a>
    </div>
  </div>
  <div class="col-md-6 mb-4">
    <div class="stl-container" id="jotunheim-right" data-model="https://files.johnsosoka.com/3d-models/schiit-jotunheim-v3-right-bracket.stl"></div>
    <div class="text-center mt-2">
      <strong>Right Bracket</strong><br>
      <a href="https://files.johnsosoka.com/3d-models/schiit-jotunheim-v3-right-bracket.stl" class="btn btn-outline-primary btn-sm" download>Download STL</a>
    </div>
  </div>
</div>

### Medium Chassis (9" x 6" slim)

**Compatible devices:** Magnius, Modius, Modius E

<div class="row">
  <div class="col-md-6 mb-4">
    <div class="stl-container" id="magnius-left" data-model="https://files.johnsosoka.com/3d-models/schiit-magnius-v3-left-bracket.stl"></div>
    <div class="text-center mt-2">
      <strong>Left Bracket</strong><br>
      <a href="https://files.johnsosoka.com/3d-models/schiit-magnius-v3-left-bracket.stl" class="btn btn-outline-primary btn-sm" download>Download STL</a>
    </div>
  </div>
  <div class="col-md-6 mb-4">
    <div class="stl-container" id="magnius-right" data-model="https://files.johnsosoka.com/3d-models/schiit-magnius-v3-right-bracket.stl"></div>
    <div class="text-center mt-2">
      <strong>Right Bracket</strong><br>
      <a href="https://files.johnsosoka.com/3d-models/schiit-magnius-v3-right-bracket.stl" class="btn btn-outline-primary btn-sm" download>Download STL</a>
    </div>
  </div>
</div>

### Stacked (Magnius + Modius)

Holds both devices together for under-desk mounting.

<div class="row">
  <div class="col-md-6 mb-4">
    <div class="stl-container" id="stacked-left" data-model="https://files.johnsosoka.com/3d-models/schiit-magnius-stacked-v2-left.stl"></div>
    <div class="text-center mt-2">
      <strong>Left Bracket</strong><br>
      <a href="https://files.johnsosoka.com/3d-models/schiit-magnius-stacked-v2-left.stl" class="btn btn-outline-primary btn-sm" download>Download STL</a>
    </div>
  </div>
  <div class="col-md-6 mb-4">
    <div class="stl-container" id="stacked-right" data-model="https://files.johnsosoka.com/3d-models/schiit-magnius-stacked-v2-right.stl"></div>
    <div class="text-center mt-2">
      <strong>Right Bracket</strong><br>
      <a href="https://files.johnsosoka.com/3d-models/schiit-magnius-stacked-v2-right.stl" class="btn btn-outline-primary btn-sm" download>Download STL</a>
    </div>
  </div>
</div>

### Pilot Template

A template for designing new brackets.

<div class="row">
  <div class="col-md-6 mb-4">
    <div class="stl-container" id="pilot-template" data-model="https://files.johnsosoka.com/3d-models/v3-pilot-template.stl"></div>
    <div class="text-center mt-2">
      <strong>Pilot Template</strong><br>
      <a href="https://files.johnsosoka.com/3d-models/v3-pilot-template.stl" class="btn btn-outline-primary btn-sm" download>Download STL</a>
    </div>
  </div>
</div>

<style>
.stl-container {
  width: 100%;
  height: 300px;
  background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
  border-radius: 8px;
  overflow: hidden;
}
</style>

<script type="importmap">
{
  "imports": {
    "three": "https://unpkg.com/three@0.160.0/build/three.module.js",
    "three/addons/": "https://unpkg.com/three@0.160.0/examples/jsm/"
  }
}
</script>

<script type="module">
import * as THREE from 'three';
import { STLLoader } from 'three/addons/loaders/STLLoader.js';
import { OrbitControls } from 'three/addons/controls/OrbitControls.js';

function initViewer(container) {
  const modelUrl = container.dataset.model;

  const scene = new THREE.Scene();

  const camera = new THREE.PerspectiveCamera(
    50,
    container.clientWidth / container.clientHeight,
    0.1,
    1000
  );

  const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
  renderer.setSize(container.clientWidth, container.clientHeight);
  renderer.setPixelRatio(window.devicePixelRatio);
  renderer.setClearColor(0x1a1a2e, 1);
  container.appendChild(renderer.domElement);

  // Lighting
  const ambientLight = new THREE.AmbientLight(0xffffff, 0.6);
  scene.add(ambientLight);

  const directionalLight = new THREE.DirectionalLight(0xffffff, 0.8);
  directionalLight.position.set(1, 1, 1);
  scene.add(directionalLight);

  const directionalLight2 = new THREE.DirectionalLight(0xffffff, 0.4);
  directionalLight2.position.set(-1, -1, -1);
  scene.add(directionalLight2);

  // Controls
  const controls = new OrbitControls(camera, renderer.domElement);
  controls.enableDamping = true;
  controls.dampingFactor = 0.1;
  controls.autoRotate = true;
  controls.autoRotateSpeed = 1.0;

  // Load STL with CORS mode
  const loader = new STLLoader();
  loader.setCrossOrigin('anonymous');

  loader.load(
    modelUrl,
    function(geometry) {
      const material = new THREE.MeshPhongMaterial({
        color: 0x3498db,
        specular: 0x111111,
        shininess: 100
      });

      const mesh = new THREE.Mesh(geometry, material);

      // Compute bounding box first
      geometry.computeBoundingBox();

      // Get size before centering
      const size = new THREE.Vector3();
      geometry.boundingBox.getSize(size);

      // Center the geometry
      const center = new THREE.Vector3();
      geometry.boundingBox.getCenter(center);
      geometry.translate(-center.x, -center.y, -center.z);

      // Scale to fit (using size calculated before translate)
      const maxDim = Math.max(size.x, size.y, size.z);
      const scale = 100 / maxDim;
      mesh.scale.set(scale, scale, scale);

      scene.add(mesh);

      // Position camera
      camera.position.set(100, 80, 150);
      camera.lookAt(0, 0, 0);

    },
    function(progress) {
      if (progress.lengthComputable) {
        const percentComplete = (progress.loaded / progress.total) * 100;
        console.log(`Loading ${container.id}: ${percentComplete.toFixed(2)}%`);
      }
    },
    function(error) {
      console.error(`Error loading STL for ${container.id}:`, error);
      container.innerHTML = `<div style="color: white; padding: 20px; text-align: center;">
        <p>Failed to load 3D model</p>
        <p style="font-size: 0.8em; opacity: 0.7;">${error.message || 'Unknown error'}</p>
      </div>`;
    }
  );

  // Animation loop
  function animate() {
    requestAnimationFrame(animate);
    controls.update();
    renderer.render(scene, camera);
  }
  animate();

  // Handle resize
  const resizeObserver = new ResizeObserver(() => {
    camera.aspect = container.clientWidth / container.clientHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(container.clientWidth, container.clientHeight);
  });
  resizeObserver.observe(container);
}

// Wait for DOM to be fully loaded before initializing viewers
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.stl-container').forEach(initViewer);
  });
} else {
  // DOMContentLoaded already fired
  document.querySelectorAll('.stl-container').forEach(initViewer);
}
</script>
