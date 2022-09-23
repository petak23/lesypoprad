<script>
/**
 * Komponenta pre vypísanie footer-u gridu. Tj. paginátor a položiek na stránku
 * Posledna zmena 24.06.2022
 *
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.3
 * 
 * @doc see file Grid_readme.md
 */
import axios from "axios";

//for Tracy Debug Bar
axios.defaults.headers.common["X-Requested-With"] = "XMLHttpRequest";

export default {
  props: {
    basePath: {    // Základná cesta v adrese
      type: String,
      required: true,
    },
    baseApiPath: { // Základná časť cesty k API s lomítkom na začiatku a na konci
      type: String,
      required: true,
    },
    currentLang: { // Skratka aktuálneho jazyka
      type: String,
      default: 'sk',
    },
    id: {          // Id časti
      type: String,
      required: true,
    },
    items_count: { // Celkový počet položiek
      type: Number,
      required: true,
    },
  },
  data() {
    return {
      items_per_page: [
        { value: 10, text: "10"}, 
        { value: 20, text: "20"}, 
        { value: 50, text: "50"},
        { value: 0, text: "Všetky"},
      ],
      items_per_page_selected: 10,
      items_per_page_selected_old: 10,
      currentPage: 1,
      language_texts: {
        sk: {
          items: "Položiek: ",
          from: "od ",
          to: "do ",
          items_per_page: "Položiek na stránku:",
        }
      },
    }
  },
  methods: {
    // Zmení počet položiek na stránku
    changeItemsPerPage() {
      let odkaz = this.basePath + this.baseApiPath + "changeperpage"
      // Výpočet novej aktuálnej stránky
      let first_id = this.items_per_page_selected_old * (this.currentPage - 1)
      this.currentPage = (first_id > 0 && this.items_per_page_selected > 0) ? Math.ceil(first_id / this.items_per_page_selected) : 1
      let vm = this
      axios.post(odkaz, {
          'items_per_page': this.items_per_page_selected,
        })
        .then(function (response) {
          console.log(response.data)
          vm.$root.$emit('changed_items_per_page', 
                          { 
                            id: vm.id, 
                            items_per_page_selected: vm.items_per_page_selected,
                            currentPage: vm.currentPage
                          }
                        )
        })
        .catch(function (error) {
          console.log(odkaz)
          console.log(error)
        });
    },
    // Načíta aktuálny počet položiek na stránku
    loadItemsPerPage() {
      let odkaz = this.basePath + this.baseApiPath + "getperpage";
      axios
        .get(odkaz)
        .then((response) => {
          this.items_per_page_selected = response.data;
          this.$root.$emit('changed_items_per_page', 
                          { 
                            id: this.id, 
                            items_per_page_selected: this.items_per_page_selected,
                            currentPage: this.currentPage,
                          }
                        )
        })
        .catch((error) => {
          console.log(odkaz);
          console.log(error);
        });
    },
    trans(key) { // Preloží kľúč do aktuálneho jazyka
      // help: https://stackoverflow.com/questions/6921803/how-to-access-object-using-dynamic-key
      if (this.language_texts[this.currentLang].hasOwnProperty(key)) {
        return this.language_texts[this.currentLang][key]
      } else {
        return key
      }
    }
  },
  computed: {
    pages() { // Spočíta celkový počet stránok
      return Math.ceil(this.items_per_page_selected > 0 ? this.items_count / this.items_per_page_selected : 1)
    },
    count_from() { // Spočíta dolnú hranicu (od) zobrazených položiek pre časť: od - do. Vráti text v tvare:"od xxx".
      let n = (this.currentPage - 1) * this.items_per_page_selected + 1
      return this.trans('from') + n.toString()
    },
    count_to() { // Spočíta hornú hranicu (do) zobrazených položiek pre časť: od - do. Vráti text v tvare:"do xxx".
      let c = this.items_per_page_selected > 0 ? this.currentPage * this.items_per_page_selected : this.items_count
      return this.trans('to') + (c > this.items_count ? this.items_count.toString() : c.toString())
    }
  },
  watch: {
    currentPage: function (val) {
      this.$root.$emit('current_page', { 
                            id: this.id,
                            currentPage: this.currentPage
                          })
    },
  },
  created() {
    // Načíta aktuálny počet položiek na stránku
    this.loadItemsPerPage()
  },
  
}
</script>
<template> 
  <div class="d-flex justify-content-between">
    <div class="px-2">
      {{ trans('items') }}{{ items_count }} 
      <small v-if="items_count > 1">
        ({{ count_from }} {{ count_to }})
      </small>
    </div> 
    <b-pagination
      v-if="pages > 1"
      v-model="currentPage"
      :total-rows="items_count"
      :per-page="items_per_page_selected"
      size="sm"
      class="bg-secondary text-white my-0"
    >
    </b-pagination>
    <form class="px-2 form-inline" v-if="items_count > 10">
      <label class="my-0 mr-2" for="itemsPerPage">{{ trans('items_per_page') }}</label>
      <b-form-select 
        v-model="items_per_page_selected"
        :options="items_per_page"
        id="itemsPerPage"
        size="sm"
        @change="changeItemsPerPage">
      </b-form-select>
    </form>
  </div>
</template>

<style scoped>

</style>