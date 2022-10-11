<script>
/**
 * Komponenta pre vypísanie a spracovanie faktúr.
 * Posledna zmena 05.10.2022
 *
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.0
 */
import FakturyGrid from '../Faktury/FakturyGrid.vue'
import MultipleUpload from '../Uploader/MultipleUpload.vue'
import GridFooter from "../Grid/GridFooter.vue";
import axios from "axios";

//for Tracy Debug Bar
axios.defaults.headers.common["X-Requested-With"] = "XMLHttpRequest";

export default {
  components: { 
    MultipleUpload,
    FakturyGrid,
    GridFooter,
  },
  props: {
    id_hlavne_menu: {
      type: String,
      required: true,
    },
    basePath: {
      type: String,
      required: true,
    },
    baseApiPath: {  // Základná časť cesty k API s lomítkom na začiatku a na konci
      type: String,
      required: true,
    },
    adminLinks: { // Oprávnenia pre administratívne úkony
      type: String,
      required: true,
    },
    currentLang: { // Skratka aktuálneho jazyka
      type: String,
      default: 'sk',
    },
    zmluvy: {
      type: String,
      required: true,
    },
    id: {
      type: String,
      default: 'documents',
    }
  },
  data() {
    return {
      admin_links: {},
      items_selected: 0, // Počet označených položiek
      items_count: 0,    // Celkový počet položiek
      items_per_page_selected: 10,  // Počet položiek na stránku
      currentPage: 1,    // Aktuálne zobrazená stránka
      language_texts: {  // Texty pre jazykové mutácie
        sk: {
          add_items: "Pridaj faktúru(y)",
          add_more_items: "Pridanie viacerích faktúr k položke",
        },
      },
    };
  },
  methods: {
    deleteItems() {
      this.$root.$emit('faktury_delete')
    },
    trans(key) {  // Preklad textov
      // help: https://stackoverflow.com/questions/6921803/how-to-access-object-using-dynamic-key
      if (this.language_texts[this.currentLang].hasOwnProperty(key)) {
        return this.language_texts[this.currentLang][key]
      } else {
        return key
      }
    }
  },
  created() {
    this.admin_links = JSON.parse(this.adminLinks);
    
    // Reaguje na zmenu počtu označených položiek 
    this.$root.$on('items_selected', data => {
      if (data.id == this.id) { // Len ak je to určené pre mňa...
			  this.items_selected = data.length
      }
		})

    // Reaguje na zmenu počtu položiek
    this.$root.$on('items_count', data => {
      if (data.id == this.id) { // Len ak je to určené pre mňa...
        //console.log(data, this.id)
			  this.items_count = data.length
      }
		})

    // Reaguje na zmenu počtu položiek na stránku v gride
    this.$root.$on('changed_items_per_page', data => { 
      if (data.id == this.id) { // Len ak je to určené pre mňa...
        this.items_per_page_selected = data.items_per_page_selected
        this.currentPage = data.currentPage
      }
    })

    // Reaguje na zmenu aktuálnej stránky
    this.$root.$on('current_page', data => { 
      if (data.id == this.id) { // Len ak je to určené pre mňa...
        this.currentPage = data.currentPage
      }
    })

  },
  
}
</script>
<template>
  <div class="card card-info">
    <div class="card-header">
      <b-button 
        v-if="admin_links.elink" 
        v-b-modal.myModalAddMultiFakturyUpload variant="primary"
        size="sm"
      >
        <i class="fas fa-copy"></i> {{ trans('add_items') }}
      </b-button>
      <b-button class="ml-2" 
        variant="danger" 
        v-if="items_selected > 0"
        size="sm"
        @click="deleteItems"
      >
        <i class="fa-solid fa-trash-can"></i>
      </b-button>
    </div>
    <div class="card-body">
      <faktury-grid
        :base-path="basePath"
        :base-api-path="baseApiPath"
        :id_hlavne_menu="id_hlavne_menu"
        :edit-enabled="admin_links.elink"
        :del-enabled="admin_links.dlink"
        :items-per-page-selected = "items_per_page_selected"
        :id="id"
        :current-page="currentPage"
        :zmluvy="zmluvy"
      />

      <multiple-upload 
        v-if="admin_links.elink"
        :base-path="basePath"
        :base-api-path="baseApiPath"
        :id_hlavne_menu="id_hlavne_menu"
        id-of-modal-uplad="myModalAddMultiFakturyUpload"
        title="trans('add_more_items')"
        :item-emit-name="id + '_add'"
      />
    </div>
    <div class="card-footer">
      <grid-footer
        :base-path="basePath"
        :base-api-path="baseApiPath"
        :id="id"
        :items_count="items_count"
      />
    </div>
  </div>
</template>

<style scoped>
.card-body {
  padding-top: 0;
  padding-left: 0;
  padding-right: 0; 
}
.card-header {
  padding-top: .25rem;
  padding-bottom: .25rem;
}
</style>