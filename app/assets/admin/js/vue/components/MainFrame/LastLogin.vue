<script>
/**
 * Komponenta pre vypísanie posledných prihlásení.
 * Posledna zmena 06.04.2022
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.1
 */

import axios from 'axios'

//for Tracy Debug Bar
axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';

export default {
  components: {},
  props: {
    user: {
      type: String,
      required: true
    },
    basepath: {
      type: String,
      required: true
    },
    rows: {
      default: 25,
    }
  },
  data() {
    return {
      items: [],
      loading: false,
    };
  },
  computed: {
    useritems() {
      return JSON.parse(this.user)
    },
    count() {
      return Object.keys(this.items).length
    },
  },
  watch: {},
  methods: {
    activeClass(id) {
      return id == this.useritems.id ? 'selected' : 'not-selected'
    },
    rowsClass(i) {
      return (i % 2  == 0) ? "even" : "odd"
    },
    deletelogs() {
      this.loading = true
      this.odkaz = this.basepath + '/api/user/deletealllogin'
      axios.get(this.odkaz)
                .then(response => {
                  if (response.data.result == 0) {
                    this.items = []
                  }
                })
                .catch((error) => {
                  console.log(this.odkaz);
                  console.log(error);
                });
    },
  },
  mounted() {
    // Načítanie údajov priamo z DB
    this.odkaz = this.basepath + '/api/user/getlastlogin/' + this.rows
    this.items = []
    axios.get(this.odkaz)
              .then(response => {
                this.items = Object.values(response.data)
              })
              .catch((error) => {
                console.log(this.odkaz);
                console.log(error);
              });
  }}
</script>

<template>
  <div class="card border-info text-center last-login h-100">
    <div class="card-header">
      Posledných {{ rows }} prihlásení
      <button @click="deletelogs" :loading="loading" v-if="count" class="btn btn-sm btn-outline-danger">
        <i class="fas fa-trash-alt"></i>
      </button>
    </div>
    <div class="card-body">
      <table class="table table-sm table-striped" v-if="count">
        <tbody>
          <tr v-for="(item, index) in items" :key="index" :class="[ activeClass(item.id_user_main), rowsClass(index) ]">
            <td>{{ item.name }}</td>
            <td>{{ item.log_in_datetime }}</td>
          </tr>
        </tbody>
      </table>
      <h5 class="card-title" v-if="!count">Bez záznamu</h5>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  .last-login {
    max-height: 20rem;
    overflow: auto;

    td {
      font-size: 80% !important;
    }

    .selected td {
      font-weight: bold;
    }

    .odd {
      background-color: rgba(245, 222, 179, 0.35);
    }
    /*.list-item {
      overflow: auto;
      height: 100%;
    }*/
  }

  @media (min-width: 576px){ 
    .last-login {
      max-height: 20rem;
    }
  }
  @media (min-width: 768px){
    .last-login {
      max-height: 19rem;
    }
  }
  @media (min-width: 992px) {
    .last-login {
      max-height: 23rem;
    }
  }
  @media (min-width: 1200px) {
    .last-login {
      max-height: 22rem;
    }
  }
</style>