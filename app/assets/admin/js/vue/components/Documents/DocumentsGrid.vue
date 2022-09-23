<script>
/**
 * Komponenta pre vypísanie a spracovanie príloh.
 * Posledna zmena 24.06.2022
 *
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.5
 */

import axios from "axios";
import textCell from '../Grid/TextCell.vue'
import selectCell from '../Grid/SelectCell.vue'

//for Tracy Debug Bar
axios.defaults.headers.common["X-Requested-With"] = "XMLHttpRequest";

export default {
  components: {
    textCell,
    selectCell,
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
    editEnabled: {
      type: Boolean,
      default: false,
    },
    itemsPerPageSelected: {
      type: Number,
      default: 10,
    },
    currentPage: {
      type: Number,
      default: 1,
    },
    id: {
      type: String,
      required: true,
    },
  },
  data() {
    return {
      fields: [
          {
            key: 'selected',
            label: 'Označ',
            thStyle: 'width: 2.1rem; padding-left: .5rem'
          },
          {
            key: 'thumb_file',
            label: 'Obrázok',
            thStyle: 'width: 15rem;'
          },
          {
            key: 'znacka',
            label: 'Značka',
          },
          {
            key: 'name',
            label: 'Názov',
            tdClass: "position-relative"
          },
          {
            key: 'description',
            label: 'Popis',
            tdClass: "position-relative"
          },
          {
            key: 'type',
            label: 'Typ',
            tdClass: "position-relative"
          },
          {
            key: 'action',
            label: 'Akcie',
          },
        ],
      items: [],
      id_p: 1,
      loading: 0,     // Načítanie údajov 0 - nič, 1 - načítavanie, 2 - chyba načítania
      error_msg: '',  // Chybová hláška
      type: [
        {value: 1, text: "Iné"}, 
        {value: 2, text: "Obrázok"},
        {value: 3, text: "Video"},
        {value: 4, text: "Audio"}
      ],
      selected: [],
    };
  },
  methods: {
    deleteDocument(id) {
      if (window.confirm('Naozaj chceš vymazať?')) {
        let odkaz = this.basePath + this.baseApiPath + "delete/" + id;
        axios
          .get(odkaz)
          .then((response) => {
            if (response.data.data == "OK") {
              this.items = this.items.filter((item) => item.id !== id);
              this.$root.$emit('flash_message', [{'message':'Položka bola úspešne vymazaná.', 
                                                  'type':'success',
                                                  'heading': 'Podarilo sa...'
                                                  }])
              this.items_count()
            }
          })
          .catch((error) => {
            console.log(odkaz);
            console.log(error);
          });
      }
    },
    deleteMore() {
      if (window.confirm('Naozaj chceš vymazať?')) {
        let to_del = []
        let odkaz = this.basePath + this.baseApiPath + "deletemore";
        this.selected.forEach(function(item) {
          to_del.push(item.id)
        })
        let vm = this
        axios.post(odkaz, {
            /*'to_delete': */to_del,
          })
          .then(function (response) {
            console.log(response.data)
            vm.$root.$emit('flash_message', 
                             [{ 'message': 'Vymazanie prebehlo v poriadku', 
                                'type':'success',
                                'heading': 'Vymazané'
                                }])
            vm.selected.forEach(function(items) {
              vm.items = vm.items.filter((item) => item.id !== items.id)
            })
            vm.clearSelected()
            vm.items_count()
          })
          .catch(function (error) {
            console.log(odkaz)
            console.log(error)
            vm.$root.$emit('flash_message', 
                             [{ 'message': 'Pri vymazávaní došlo k chybe',
                                'type':'danger',
                                'heading': 'Chyba'
                                }])
          });
      }
    },
    openmodal(index) {
      this.id_p = index + (this.currentPage - 1) * this.items_per_page_selected;
      this.$bvModal.show("modal-multi-documents");
    },
    closeme: function () {
      this.$bvModal.hide("modal-multi-documents");
    },
    imgUrl() {
      return this.items[this.id_p] === undefined
        ? ""
        : this.basePath + "/" + this.items[this.id_p].main_file;
    },
    imgName() {
      return this.items[this.id_p] === undefined
        ? ""
        : this.items[this.id_p].name;
    },
    loadItems() { // Načítanie údajov priamo z DB
      this.loading = 1
      let odkaz =
        this.basePath + this.baseApiPath + "getitems/" + this.id_hlavne_menu;
      this.items = [];
      axios
        .get(odkaz)
        .then((response) => {
          this.items = Object.values(response.data);
          this.loading = 0
          this.items_count()
        })
        .catch((error) => {
          this.error_msg = 'Nepodarilo sa načítať údaje do tabuľky príloh. <br/>Možná príčina: ' + error
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
    items_count() { // Emituje celkový počet položiek
      this.$root.$emit('items_count', { id: this.id, length: this.items.length })
    },
    onRowSelected(items) {
      this.selected = items
      this.$root.$emit('items_selected', { id: this.id, length: this.selected.length })
    },
    selectAllRows() {
      this.$refs.documentsTable.selectAllRows()
      this.$root.$emit('items_selected', { id: this.id, length: this.selected.length })
    },
    clearSelected() {
      this.$refs.documentsTable.clearSelected()
      this.$root.$emit('items_selected', { id: this.id, length: this.selected.length })
    },
  },
  created() {
    // Načítanie údajov priamo z DB
    this.loadItems()
    
    this.$root.$on('documents_add', data => {
			this.items.push(...data)
      this.items_count()
		})

    this.$root.$on('documents_delete', this.deleteMore)
  },
};
</script>

<template>
  <div>
    <b-table
      id="my-documents"
      :items="items"
      :per-page="itemsPerPageSelected"
      :current-page="currentPage"
      :fields="fields"
      :bordered="true"
      :striped="true"
      :busy="loading > 0"
      small
      select-mode="multi"
      selectable
      @row-selected="onRowSelected"
      ref="documentsTable"
      sticky-header="30rem"
    >
      <template #head(selected)>
        <b-icon icon="square" @click="selectAllRows" v-if="selected.length < items.length"></b-icon>
        <b-icon icon="check2-square" @click="clearSelected" v-if="selected.length == items.length"></b-icon>
      </template>
      <template #cell(selected)="{ rowSelected }">
        <template v-if="rowSelected">
          <span aria-hidden="true"><b-icon icon="check2-square"></b-icon></span>
          <span class="sr-only">Selected</span>
        </template>
        <template v-else>
          <span aria-hidden="true"><b-icon icon="square"></b-icon></span>
          <span class="sr-only">Not selected</span>
        </template>
      </template>
      <template #cell(thumb_file)="data">
        <img
          :src="basePath + '/' + data.item.thumb_file"
          :alt="data.item.name"
          class="img-thumbnail"
          @click="openmodal(data.index)"
        />
      </template>
      <template #cell(znacka)="data">
        {{ data.item.znacka }}
      </template>
      <template #cell(name)="data">
        <text-cell
          :value="data.item.name"
          :apiLink="basePath + baseApiPath + 'update/'"
          colName="name"
          :id="data.item.id"
        ></text-cell>
      </template>
      <template #cell(description)="data">
        <text-cell
          :value="data.item.description"
          :apiLink="basePath + baseApiPath + 'update/'"
          colName="description"
          :id="data.item.id"
        ></text-cell>
      </template>
      <template #cell(type)="data">
        <select-cell
          :value="data.item.type"
          :apiLink="basePath + baseApiPath + 'update/'"
          colName="type"
          :id="data.item.id"
          :options="type"
        ></select-cell>
      </template>
      <template #cell(action)="data" v-if="editEnabled">
        <!--button type="button" class="btn btn-info btn-sm" title="Edit">
          <i class="fa-solid fa-pen"></i>
        </button-->
        <button
          type="button"
          class="btn btn-danger btn-sm"
          title="Zmaž"
          @click="deleteDocument(data.item.id)"
        >
          <i class="fa-solid fa-trash-can"></i>
        </button>
      </template>
    </b-table>

    <div class="alert alert-danger" v-if="loading == 2" v-html="error_msg"></div>
    <div class="d-flex align-items-center" v-if="loading == 1">
      <strong>Nahrávam...</strong>
      <div class="spinner-border ml-auto" role="status" aria-hidden="true"></div>
    </div>
    <b-modal
      id="modal-multi-document"
      centered
      size="xl"
      ok-only
      hide-header
      hide-footer
      dialog-class="document-dialog"
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
#modal-multi-document {
  .document-dialog {
    max-width: 95vw !important;
  }

  .modal-body {
    max-height: 80vh !important;
  }

  .modal-body img {
    max-width: 100%;
    max-height: 100%;
  }
}
table.b-table[aria-busy='true'] {
  opacity: 0.6;
}
table.b-table caption {
  padding-top: .25rem;
  padding-bottom: .25rem;
  background-color: #555;
  color: #fff;
}
.b-table-sticky-header {
  overflow: auto;
}
</style>
