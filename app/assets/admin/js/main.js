import 'bootstrap/dist/js/bootstrap.bundle';

import naja from 'naja';
document.addEventListener('DOMContentLoaded', naja.initialize.bind(naja));


import netteForms from 'nette-forms';
netteForms.initOnLoad(); 
window.Nette = netteForms;

//import './pomocne_admin.js';
import '../css/main.scss';

import './vue/MainVue.js';