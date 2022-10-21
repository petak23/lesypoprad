<script>
/**
 * Komponenta pre formulár na zadanie/editáciu verzií.
 * Posledna zmena 21.10.2022
 *
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.2
 */
import Tiptap from "../Tiptap/tiptap-editor.vue";
import axios from 'axios'

//for Tracy Debug Bar
axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';

export default {
  components: {
    Tiptap,
  },
  props: {
    id: {
      type: String,
      required: true
    },
    basePath: {
      type: String,
      required: true
    },
  },
  data() {
    return {
      form: {
        id: 0,
        id_user_main: 0,
        number: "",
        text:"",
        modified: ""
      },
      editor: null,
    }
  },
  beforeDestroy() {
    this.editor.destroy()
  },
  methods: {
    onSubmit(event) {
      event.preventDefault()

    },
    onReset(event) {
      event.preventDefault()
      this.form.id = 0
      this.form.id_user_main = 0
      this.form.number = ""
      this.form.text = ""
      this.form.modified = ""
    },
  },
  mounted() {
    // Načítanie údajov priamo z DB
    let odkaz = this.basePath + '/api/verzie/getversion/' + this.id
    axios.get(odkaz)
          .then(response => {
            console.log(response.data)
            //this.dataSet(this.data_origin)
            this.form.id = response.data.id
            this.form.id_user_main = response.data.id_user_main
            this.form.number = response.data.cislo
            this.form.text = response.data.text
            this.form.modified = response.data.modified
          })
          .catch((error) => {
            console.log(odkaz);
            console.log(error);
          });
  }
}
</script>

<template>
  <b-form @submit="onSubmit" @reset="onReset">
    <b-form-group
      id="input-number-gr"
      label="Číslo verzie:"
      label-for="input-number"
    >
      <b-form-input
        id="input-number"
        size="sm"
        v-model="form.number"
        type="text"
        required
        autofocus
        >
      </b-form-input>
    </b-form-group>
    <b-form-group
      id="input-text-gr"
      label="Popis verzie:"
      label-for="input-text"
    >
      <tiptap 
        :value="form.text"/>
    </b-form-group>
    <input type="hidden" :value="form.id">
    <b-button type="submit" variant="success">Ulož</b-button>
    <b-button type="reset" variant="secondary">Cancel</b-button>
  </b-form>

</template>
