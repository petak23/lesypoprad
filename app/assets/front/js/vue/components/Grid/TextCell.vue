<script>
/**
 * Komponenta pre vypísanie textového políčka gridu.
 * Posledna zmena 09.06.2022
 *
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.3
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
    },
    editEnabled: { // Povolenie editácie políčka
      type: Boolean,
      default: false,
    },
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
          vm.my_value
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
      if (this.editEnabled) {
        this.editing = true
        // https://forum.vuejs.org/t/setting-focus-to-textarea-not-working/17891/5
        this.$nextTick(() => {
          this.$refs.text_area.focus()
        })
      }
    }
  },
  watch: { 
    value: function() {
      this.my_value = this.value  
    }
  },
  created: function () {
    this.my_value = this.value
  },
}
</script>

<template>
  <div 
    v-bind:class="{ 'text-col': editEnabled}"
    @click="edit"
  >
    <textarea 
      ref="text_area"
      v-model="my_value"
      v-if="editEnabled && editing"
      @blur="updateItem">
    </textarea>
    <div v-else>{{ my_value }}</div>
  </div>
</template>


<style>
.text-col{
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  /*border: 2px solid red;*/
}
textarea {
  max-width: 100%;
  height: 100%;
}
</style>