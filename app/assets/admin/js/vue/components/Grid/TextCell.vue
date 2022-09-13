<script>
/**
 * Komponenta pre vypísanie textového políčka gridu.
 * Posledna zmena 29.05.2022
 *
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.0
 */

import axios from "axios";

//for Tracy Debug Bar
axios.defaults.headers.common["X-Requested-With"] = "XMLHttpRequest";

export default {
  props: {
    value: {
      type: String,
      default: '',
      //required: true,
    },
    apiLink: {
      type: String,
      required: true,
    },
    colName: {
      type: String,
      required: true,
    },
    id: {
      type: Number,
      required: true,
    }
  },
  data() {
    return {
      my_value: '',
      editing: false,
      edit_name: '',
    };
  },
  methods: {
    updateItem() {
      this.editing = false
      let odkaz = this.apiLink + this.id
      let vm = this
      axios.post(odkaz, {
          [this.colName]: this.my_value,
        })
        .then(function (response) {
          //vm.preview = response.data
          //console.log(response.data)
          vm.$root.$emit('flash_message', 
                           [{ 'message': 'Uloženie v poriadku', 
                              'type':'success',
                              'heading': 'Uložené'
                              }])
        })
        .catch(function (error) {
          console.log(odkaz)
          console.log(error)
          vm.$root.$emit('flash_message', 
                           [{ 'message': 'Pri uklasaní došlo k chybe',
                              'type':'danger',
                              'heading': 'Chyba'
                              }])
        });      
      
    },
    edit() {
      this.editing = true
    }
  },
  created: function () {
    this.my_value = this.value
  },
}
</script>

<template>
  <td 
    class="text-col"
    @click="edit"
  >
    <div v-if="!editing">{{ my_value }}</div>
    <textarea 
      v-model="my_value"
      v-if="editing"
      @blur="updateItem">
    </textarea>
  </td>
</template>


<style>

</style>