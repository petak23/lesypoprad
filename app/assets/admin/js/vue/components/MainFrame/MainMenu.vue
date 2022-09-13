<script>
/**
 * Komponenta pre základné rozloženie.
 * Posledna zmena 18.11.2021
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2021 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.2
 */

import vuetify from '@/admin/js/vue/plugins/vuetify'
import axios from 'axios'


//for Tracy Debug Bar
axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';

export default {
  vuetify,
  components: {},
  props: {
    basepath: {
      type: String,
      required: true
    },
    main_menu_active: { //Aktuálna aktívna polozka
      type: String,
      default: 0,
    },
  },
  data: () => ({
    odkaz: "",
    in_path: false,
  }),
  computed: {},
  mounted() {
    // Načítanie údajov priamo z DB
    this.odkaz = this.basepath + '/api/menu/getmenu'
    this.getMenu()
  },
  methods: {
    convert(itemsObject) {
      return Object.values(itemsObject).map(item => ({
        ...item,
        children: item.children ? this.convert(item.children) : undefined,
      }));
    },
    getpath(item) {
      var self = this
      item.map(function(i) {
        if (self.in_path == false) {
          if (i.id == self.main_menu_active) {
            self.$store.commit('SET_PUSH_MAIN_MENU_OPEN', i.id)
            self.in_path = true
          } else if (typeof i.children !== 'undefined' && i.children.length > 0) {
            self.getpath(i.children)
            if (self.in_path) {
              self.$store.commit('SET_PUSH_MAIN_MENU_OPEN', i.id)
            }
          }
        }
      })
    },
    getMenu() {
      axios.get(this.odkaz)
              .then(response => {
                this.$store.commit('SET_INIT_MAIN_MENU', this.convert(response.data))
                this.$store.commit('SET_INIT_MAIN_MENU_OPEN', [])
                this.getpath(this.$store.state.main_menu)
                this.in_path = false
                this.$store.commit('SET_REVERSE_MAIN_MENU_OPEN')
              })
              .catch((error) => {
                console.log(this.odkaz);
                console.log(error);
              });
    },
  },
}
</script>

<template>
  <div class="menu_new">
    <h6 class="mt-1 d-inline-block w-100">
      <small class="font-weight-bold text-muted">Hlavné menu</small>
    </h6>
    <v-treeview
      dense
      :items="$store.state.main_menu"
      activatable
      item-key="id"
      :active="[main_menu_active]"
      :open="$store.state.main_menu_open"
    >
      <template v-slot:label="{ item }">
        <a :href="item.link" :title="item.name">{{ item.name }}</a>
      </template>
    </v-treeview>
  </div>
</template>