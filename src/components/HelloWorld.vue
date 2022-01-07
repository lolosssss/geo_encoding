<script lang="ts">
import { ref, defineComponent } from 'vue';
import { Deck } from '@deck.gl/core';
import { BitmapLayer } from '@deck.gl/layers';
import { S2Layer, TileLayer, H3ClusterLayer } from '@deck.gl/geo-layers';
import ConfigView from './ConfigView.vue';

export default {
  setup() {
    return {
      deck: null,
      tileLayer: null,
      viewState: ref({
        // 西湖区
        longitude: 120.142116,
        latitude: 30.245532,
        zoom: 12,
        bearing: 0,
        pitch: 0,
      }),
    };
  },
  mounted() {
    this.initMap();
  },
  methods: {
    initMap() {
      this.tileLayer = new TileLayer({
        data: 'https://c.tile.openstreetmap.org/{z}/{x}/{y}.png',
        minZoom: 0,
        maxZoom: 19,
        tileSize: 256,
        renderSubLayers: (props) => {
          const {
            bbox: { west, south, east, north },
          } = props.tile;
          return new BitmapLayer(props, {
            data: null,
            image: props.data,
            bounds: [west, south, east, north],
          });
        },
      });
      this.deck = new Deck({
        canvas: 'map-container',
        width: '100%',
        height: '100%',
        initialViewState: this.viewState,
        controller: true,
        layers: [this.tileLayer],
      });
    },
    updateLayer(ev) {
      console.log(ev);
      let layer;
      if (ev.selected === 0) {
        return;
      } else if (ev.selected === 1) {
        layer = new S2Layer({
          id: 's2-layer',
          data: ev.tokens.split(','),
          pickable: true,
          wireframe: false,
          lineWidthMaxPixels: 1,
          filled: true,
          extruded: false,
          getS2Token: (d) => d,
          getFillColor: [255, 0, 0, 125],
        });
      } else if (ev.selected === 2) {
        layer = new H3ClusterLayer({});
      }
      this.deck.setProps({
        layers: [this.tileLayer, layer],
      });
    },
  },
  components: {
    ConfigView,
  },
};
</script>

<template>
  <div>
    <canvas id="map-container" class="fixed inset-0"></canvas>
    <ConfigView class="h-1/6 w-1/6 absolute left-0 bottom-0" @load="updateLayer" />
  </div>
</template>

<style scoped>
a {
  color: #42b983;
}

label {
  margin: 0 0.5em;
  font-weight: bold;
}

code {
  background-color: #eee;
  padding: 2px 4px;
  border-radius: 4px;
  color: #304455;
}
</style>
