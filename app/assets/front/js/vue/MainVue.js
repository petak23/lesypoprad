/* 
 * Main Vue.js app file
 * Posledná zmena(last change): 05.10.2022
 *
 * @author Ing. Peter VOJTECH ml <petak23@gmail.com>
 * @copyright Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link http://petak23.echo-msz.eu
 * @version 1.0.0
 */

import Vue from 'vue';
import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
import VueDndZone from 'vue-dnd-zone'
import 'vue-dnd-zone/vue-dnd-zone.css'
import SingleUpload from './components/Uploader/SingleUpload'
import MultipleUpload from './components/Uploader/MultipleUpload'
import FlashMessage from "./components/FlashMessage"
import FakturyMain from './components/Faktury/FakturyMain.vue'
import moment from 'moment'

Vue.filter('formatDate', function(value) {
  if (value) {
    return moment(String(value)).format('DD.MM.YYYY')
  }
})

// Make BootstrapVue available throughout your project
Vue.use(BootstrapVue);
// Optionally install the BootstrapVue icon components plugin
Vue.use(IconsPlugin);

Vue.use(VueDndZone);

Vue.config.ignoredElements = ["trix-editor"]

let vm = new Vue({
  el: '#vueapp',
  components: { 
    SingleUpload,
    MultipleUpload,
    FlashMessage,
    FakturyMain,
  },
});   