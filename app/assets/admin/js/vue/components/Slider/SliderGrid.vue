<script>
/**
 * Komponenta pre vypísanie a spracovanie obrázkov slider-a.
 * Posledna zmena 07.06.2022
 *
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.1
 */

import axios from "axios";
import textCell from '../Grid/TextCell.vue'

//for Tracy Debug Bar
axios.defaults.headers.common["X-Requested-With"] = "XMLHttpRequest";

export default {
  components: {
    textCell,
  },
  props: {
    basePath: {
      type: String,
      required: true,
    },
    sliderDir: {
      type: String,
      required: true,
    },
  },
  data() {
    return {
      items: [],
      id_p: 1,
      loading: 0,     // Načítanie údajov 0 - nič, 1 - načítavanie, 2 - chyba načítania
      error_msg: '',  // Chybová hláška
    };
  },
  methods: {
    deleteSlider(id) {
      if (window.confirm('Naozaj chceš vymazať obrázok123 slider-a?')) {
        let odkaz = this.basePath + "/api/slider/delete/" + id;
        axios
          .get(odkaz)
          .then((response) => {
            if (response.data.data == "OK") {
              this.items = this.items.filter((item) => item.id !== id);
              this.$root.$emit('flash_message', [{'message':'Položka bola úspešne vymazaná.', 
                                                  'type':'success',
                                                  'heading': 'Podarilo sa...'
                                                  }])
            }
          })
          .catch((error) => {
            console.log(odkaz);
            console.log(error);
          });
      }
    },
    openmodal(index) {
      this.id_p = index;
      this.$bvModal.show("modal-slider");
    },
    closeme: function () {
      this.$bvModal.hide("modal-slider");
    },
    imgUrl() {
      return this.items[this.id_p] === undefined
        ? ""
        : this.basePath + "/" + this.items[this.id_p].main_file; //????
    },
    imgName() {
      return this.items[this.id_p] === undefined
        ? ""
        : this.items[this.id_p].name;
    },
    loadItems() { // Načítanie údajov priamo z DB
      this.loading = 1
      let odkaz =
        this.basePath + "/api/slider/getall";
      this.items = [];
      axios
        .get(odkaz)
        .then((response) => {
          this.items = Object.values(response.data);
          this.loading = 0
        })
        .catch((error) => {
          this.error_msg = 'Nepodarilo sa načítať údaje do tabuľky slideru. <br/>Možná príčina: ' + error
          this.loading = 2
          this.$root.$emit('flash_message', 
                           [{ 'message': this.error_msg, 
                              'type':'danger',
                              'heading': 'Chyba'
                              }])
          
          console.log(odkaz);
          console.log(error);
        });
    },
     moveArticle: function(ai) {
      let from = ai.from.index
      let to = ai.to.index
      let odkaz = this.basePath + '/api/slider/saveorder/'
      let out = []
      for (let i = 0; i < this.items.length; i++) {
        out.push(this.items[i].id)
      }
      // https://www.codegrepper.com/code-examples/javascript/change+index+order+in+array+javascript
      let element = out[from];
      out.splice(from, 1);
      out.splice(to, 0, element);
      let vm = this
      axios.post(odkaz, {
          items: out,
        })
        .then(function (response) {
          if (response.data.result == 'OK') {
            console.log("OK")
            vm.$root.$emit('flash_message', 
                           [{ 'message': 'Poradie bolo zmenené!', 
                              'type':'success',
                              'heading': 'OK'
                              }])
          }
        })
        .catch(function (error) {
          console.log(odkaz);
          console.log(error);
        });
    },
  },
  created() {
    // Načítanie údajov priamo z DB
    this.loadItems()
    this.$root.$on('slider_add', data => {
			this.items.push(...data)
		})
  },
};
</script>

<template>
  <div>
    <table class="table table-bordered table-striped" v-if="loading == 0">
      <caption class="bg-secondary text-white py-1">
        <div class="d-flex justify-content-between">
          <div class="px-2">Počet obrázkov: {{ items.length }}</div>
        </div>
      </caption>
      <thead class="thead-dark">
        <tr>
          <th style="width: 15rem">Obrázok</th>
          <th>Súbor</th>
          <th>Nadpis</th>
          <th>Zobrazenie</th>
          <th class="action-col">Akcie</th>
        </tr>
      </thead>
      <dnd-zone
        :transition-duration="0.3"
        handle-class="move-item"
        v-on:move="moveArticle"
      >
        <dnd-container
          :dnd-model="items"
          dnd-id="slider-grid"
          dense
          tag="tbody"
          :vertical-search="true"
        >
          <dnd-item
            v-for="(item, index) in items" 
            :key="item.id"
            :dnd-id="item.id"
            :dnd-model="item"
          >
            <tr>
              <td class="text-center align-middle">
                <img
                  :src="basePath + '/' + sliderDir + item.subor"
                  :alt="item.subor"
                  class="img-thumbnail"
                  @click="openmodal(index)"
                />
              </td>
              <td class="text-right align-middle"><small>{{ item.subor }}</small></td>
              <!--td>{{ item.nadpis !== null ? item.nadpis : 'Bez nadpisu' }}</td-->
              <text-cell
                :value="item.nadpis"
                :apiLink="basePath + '/api/slider/update/'"
                colName="nadpis"
                :id="item.id"
              ></text-cell>
              <td>{{ item.zobrazenie !== null ? item.zobrazenie : 'Vždy okrem...' }}</td>
              <td class="align-middle">
                <button class="btn btn-sm btn-secondary move-item">
                  <i class="fas fa-arrows-alt-v"></i>
                </button>
                <a :href="basePath + '/administration/slider/edit?id=' + item.id" 
                  title="Edituj slider" class="btn btn-sm btn-default btn-secondary">
                  <span class="fa fa-pencil-alt"></span>
                </a>
                <button
                  type="button"
                  class="btn btn-danger btn-sm"
                  title="Zmaž"
                  @click="deleteSlider(item.id)"
                >
                  <i class="fa-solid fa-trash-can"></i>
                </button>
              </td>
            </tr>
          </dnd-item>
        </dnd-container>
      </dnd-zone>
    </table>

    <div class="alert alert-danger" v-if="loading == 2" v-html="error_msg"></div>
    <div class="d-flex align-items-center" v-if="loading == 1">
      <strong>Nahrávam...</strong>
      <div class="spinner-border ml-auto" role="status" aria-hidden="true"></div>
    </div>
    <b-modal
      id="modal-slider"
      centered
      size="xl"
      ok-only
      hide-header
      hide-footer
      dialog-class="slider-dialog"
    >
      <img :src="imgUrl()" :alt="imgName()" @click="closeme" />
    </b-modal>
  </div>
</template>

<style lang="scss" scoped>
.action-col {
  min-width: 40px;
}
button {
  margin-left: 0.1em;
}
#modal-slider {
  .slider-dialog {
    max-width: 95vw !important;
  }

  .modal-body img {
    max-width: 100%;
  }
}
</style>
