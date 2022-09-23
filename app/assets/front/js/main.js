import 'bootstrap/dist/js/bootstrap.bundle';
import naja from 'naja';
import netteForms from 'nette-forms';

window.Nette = netteForms;

/* Inicializácia pre ajax knižicu NAJA */
document.addEventListener('DOMContentLoaded', naja.initialize.bind(naja));
netteForms.initOnLoad();  

//import './js-image-slider.js';
//import '../../../vendor/ublaboo/datagrid/assets/datagrid.js';
//import './pomocne_front.js';

import '../css/main.scss';

//import './vue/MainVue.js';

import './jquery-1.12.4.js';
import './jquery-ui-1.12.1.min.js';
import './jquery.ui.datepicker-sk.js';
import trix from 'trix';
//import './datagrid.js';
//import './js-image-slider.js';
import './dropmenuJQ.js';
import './pomocne_front.js';