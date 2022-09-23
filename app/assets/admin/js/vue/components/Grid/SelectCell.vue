<script>
/**
 * Komponenta pre vypísanie selectového políčka gridu.
 * Posledna zmena 14.06.2022
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
      //type: String,
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
    options: {
      type: Array,
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
      this.editing = true
      // https://forum.vuejs.org/t/setting-focus-to-textarea-not-working/17891/5
      this.$nextTick(() => {
        this.$refs.select_box.focus()
      })
    }
  },
  watch: { 
    value: function() {
      this.my_value = this.value  
    }
  },
  computed: {
    selected_val: function () {
      let out = ''
      this.options.forEach(item => {
        if (item.value == this.my_value) out = item.text
      })
      return out
    }
  },
  created: function () {
    this.my_value = this.value
  },
}
</script>

<template>
  <div 
    class="select-col"
    @click="edit"
  >
    <div v-if="!editing">{{ selected_val }}</div>
    <b-form-select 
      v-model="my_value"
      :options="options"
      :id="'select'+colName"
      size="sm"
      @change="updateItem"
      v-if="editing"
      ref="select_box"
    >
    </b-form-select>
  </div>
</template>


<style>
.select-col{
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  /*border: 2px solid red;*/
}
</style>