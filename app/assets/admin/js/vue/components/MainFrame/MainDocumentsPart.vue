<script>
/**
 * Komponenta pre vypísanie kariet dokumentov a produktov
 * Posledna zmena 23.09.2022
 *
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.2-poff (product off)
 */

import DocumentsMain from "../Documents/DocumentsMain.vue";
//import ProductsMain from "../Products/ProductsMain.vue";

export default {
  components: {
    DocumentsMain,
    //ProductsMain,
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
    adminLinks: {
      type: String,
      required: true,
    },
    activeTab: {
      type: String,
      default: "prilohy-tab",
    },
  },
  data() {
    return {
      documents_count: 0,
      //products_count: 0,
    };
  },
  created() {
    this.$root.$on("items_count", (data) => {
      /*if (data.id == "products") { // Len ak je to určené pre mňa...
			  this.products_count = data.length
      }*/
      if (data.id == "documents") {
        // Len ak je to určené pre mňa...
        this.documents_count = data.length;
      }
    });
  },
};
</script>

<template>
  <b-tabs content-class="mt-3">
    <b-tab :active="activeTab == 'prilohy-tab'">
      <template #title>
        Prílohy<span v-if="documents_count > 0"> ({{ documents_count }})</span>
      </template>
      <documents-main
        :base-path="basePath"
        base-api-path="/api/documents/"
        :id_hlavne_menu="id_hlavne_menu"
        :admin-links="adminLinks"
      />
    </b-tab>
    <!--b-tab
      :active="activeTab == 'products-tab'">
      <template #title>
        Produkty<span v-if="products_count > 0"> ({{ products_count }})</span>
      </template>
      <products-main 
        :base-path="basePath"
        base-api-path="/api/products/"
        :id_hlavne_menu="id_hlavne_menu"
        :admin-links="adminLinks"
      />
    </b-tab -->
  </b-tabs>
</template>

<style></style>