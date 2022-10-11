<script>
/**
 * Komponenta pre formulár na zadanie/editáciu verzií.
 * Posledna zmena 29.09.2022
 *
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.1
 */
import Tiptap from "../Tiptap/tiptap-editor.vue";

export default {
  components: {
    Tiptap,
  },
  props: {
    id: {
      type: String,
      required: true
    },
    value: {
      type: String,
      default: '',
    },
  },
  data() {
    return {
      text: "",
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
