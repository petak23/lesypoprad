<script>
/**
 * Komponenta pre administračné menu.
 * Posledna zmena 26.11.2021
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2021 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.2
 */


//import vuetify from '@/admin/js/vue/plugins/vuetify'
import axios from 'axios'

//for Tracy Debug Bar
axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';

export default {
  //vuetify,
  components: {},
  props: {
    basepath: {
      type: String,
      required: true
    },
    admin_menu_active: { //Aktuálna aktívna polozka
      default: 0,
    },
  },
  data() {
    return {
      odkaz: "",
    };
  },
  computed: {},
  watch: {},
  methods: {
    convert(itemsObject) {
      return Object.values(itemsObject).map(item => ({
        ...item,
        children: item.children ? this.convert(item.children) : undefined,
      }));
    }
  },
  mounted() {
    // Načítanie údajov priamo z DB
    this.odkaz = this.basepath + '/api/menu/getadminmenu'
    axios.get(this.odkaz)
              .then(response => {
                //this.items = Object.values(response.data)
                this.$store.commit('SET_INIT_ADMIN_MENU', this.convert(response.data))
              })
              .catch((error) => {
                console.log(this.odkaz)
                console.log(error)
              })
  }
}
</script>

<template>
  <div class="admin-menu">
    <h6 class="mt-1 d-inline-block w-100">
      <small class="font-weight-bold text-muted">Admin menu</small>
    </h6>
    <ul>
      <li v-for="item in $store.state.admin_menu" :key="item.id" >
        <a :href="item.link" :title="item.name"
          v-bind:class="[admin_menu_active == item.id ? 'selected' : '']">
          {{ item.name }}
        </a>
      </li>
    </ul>
  </div>
</template>

<style lang="scss" scoped>
  .admin-menu {
    border-top: 1px solid #bbb;

    ul {
      list-style-type: none;
      margin-left: 0;
      padding-left: 0;

      li {
        display: inline-block;
        width: 100%;

        a {
          color: #b50000;
          padding-left: .5rem;
          float:left;

          small {
            margin-left: .2em;
          }
        }
        a.selected {
          color: #201d1d;
          background-color: rgba(0, 190, 240, .4);
          font-style: italic;
          width: 100%;  
        }
      }
    }
  }
  .admin-menu:nth-child(2) {
    padding-top: 1ex;
  }
</style>