/* 
 * Main Vue.js app file
 * Posledná zmena(last change): 10.05.2022
 *
 * @author Ing. Peter VOJTECH ml <petak23@gmail.com>
 * @copyright Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link http://petak23.echo-msz.eu
 * @version 1.0.1
 */

import Vue from 'vue';
import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
import SingleUpload from './components/Uploader/SingleUpload'
import MultipleUpload from './components/Uploader/MultipleUpload'
import lastlogin from './components/MainFrame/LastLogin'
import colorBorderChange from './components/ColorBorderChange.vue'
import ProductsMain from './components/Products/ProductsMain.vue'
import Edittexts from '../../../components/EditArticle/EditTexts'
import FlashMessage from "./components/FlashMessage";


// Make BootstrapVue available throughout your project
Vue.use(BootstrapVue);
// Optionally install the BootstrapVue icon components plugin
Vue.use(IconsPlugin);

let vm = new Vue({
  el: '#vueapp',
  components: { 
    SingleUpload,
    lastlogin,
    MultipleUpload,
    colorBorderChange,
    ProductsMain,
    Edittexts,
    FlashMessage,
  },
});   