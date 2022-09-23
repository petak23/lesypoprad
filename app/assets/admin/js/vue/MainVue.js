/* 
 * Main Vue.js app file
 * Posledná zmena(last change): 09.06.2022
 *
 * @author Ing. Peter VOJTECH ml <petak23@gmail.com>
 * @copyright Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link http://petak23.echo-msz.eu
 * @version 1.0.2
 */

import Vue from 'vue';
import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
import VueDndZone from 'vue-dnd-zone'
import 'vue-dnd-zone/vue-dnd-zone.css'
import SingleUpload from './components/Uploader/SingleUpload'
import MultipleUpload from './components/Uploader/MultipleUpload'
import lastlogin from './components/MainFrame/LastLogin'
import colorBorderChange from './components/ColorBorderChange.vue'
import Edittexts from '../../../components/EditArticle/EditTexts'
import FlashMessage from "./components/FlashMessage"
import SliderGrid from './components/Slider/SliderGrid'
import MainDocumentsPart from "./components/MainFrame/MainDocumentsPart.vue";


// Make BootstrapVue available throughout your project
Vue.use(BootstrapVue);
// Optionally install the BootstrapVue icon components plugin
Vue.use(IconsPlugin);

Vue.use(VueDndZone);

let vm = new Vue({
  el: '#vueapp',
  components: { 
    SingleUpload,
    lastlogin,
    MultipleUpload,
    colorBorderChange,
    MainDocumentsPart,
    Edittexts,
    FlashMessage,
    SliderGrid,
  },
});   