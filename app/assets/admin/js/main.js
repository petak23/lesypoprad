import 'bootstrap/dist/js/bootstrap.bundle';

import naja from 'naja';
document.addEventListener('DOMContentLoaded', naja.initialize.bind(naja));

//import datagrid from 'ublaboo-datagrid/assets/datagrid.js';

import netteForms from 'nette-forms';
netteForms.initOnLoad(); 
window.Nette = netteForms;

//import 'ublaboo-datagrid/assets/datagrid-instant-url-refresh.js';
//import 'ublaboo-datagrid/assets/datagrid-spinners.js';

//import './pomocne_admin.js';
import '../css/main.scss';

import './vue/MainVue.js';