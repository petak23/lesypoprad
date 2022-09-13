<script>
/**
 * Komponenta pre vypísanie a spracovanie produktov.
 * Posledna zmena 22.05.2022
 *
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.0
 */
import ProductsGrid from '../Products/ProductsGrid.vue'
import MultipleUpload from '../Uploader/MultipleUpload.vue'

export default {
  components: { 
    MultipleUpload,
    ProductsGrid,
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
    backLink: { // Link na presmerovanie po úspešnom nahratí
      type: String,
      required: true,
    },
    adminLinks: { // Oprávnenia pre administratívne úkony
      type: String,
      required: true,
    },
  },
  data() {
    return {
      admin_links: {},
    };
  },
  created() {
    this.admin_links = JSON.parse(this.adminLinks);
  },
  
}
</script>
<template>
  <div class="card card-info">
    <div class="card-header">
      <b-button v-if="admin_links.elink" v-b-modal.myModalAddMultiProductsUpload variant="primary">
        <i class="fas fa-copy"></i> Pridaj produkt(y)
      </b-button>
    </div>
    <div class="card-body">
      <products-grid
        :base-path="basePath"
        :id_hlavne_menu="id_hlavne_menu"
        :edit-enabled="admin_links.elink"
      />

      <multiple-upload 
        v-if="admin_links.elink"
        api-url="api/products" 
        :base-path="basePath"
        :back-link="backLink"
        :id_hlavne_menu="id_hlavne_menu"
        id-of-modal-uplad="myModalAddMultiProductsUpload"
        title="Pridanie viacerích produktov k položke"
        item-emit-name="products_add"
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
</style>