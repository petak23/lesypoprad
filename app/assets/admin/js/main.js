import 'bootstrap/dist/js/bootstrap.bundle';

import naja from 'naja';
document.addEventListener('DOMContentLoaded', naja.initialize.bind(naja));


import netteForms from 'nette-forms';
netteForms.initOnLoad(); 
window.Nette = netteForms;

//import './pomocne_admin.js';
import '../css/main.scss';

import './vue/MainVue.js';

//import Trix from "trix"
//Trix.config.blockAttributes.heading1.tagName = "h3"
//Trix.start()