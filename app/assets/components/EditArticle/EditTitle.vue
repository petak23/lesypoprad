<script>
export default {
  props: {
    //articlename: String,
    article: Object,
    title: String,
    edit_enabled: String,
  },
  data() {
    return {
      show: true
    }
  },
  methods: {
    /*onSubmit(event) {
      event.preventDefault()
      alert(JSON.stringify(this.form))
    },
    onReset(event) {
      event.preventDefault()
      // Reset our form values
      this.form.email = ''
      this.form.name = ''
      this.form.food = null
      this.form.checked = []
      // Trick to reset/clear native browser form validation state
      this.show = false
      this.$nextTick(() => {
        this.show = true
      })
    }*/
  }
}
</script>

<template>
  <h1 class="title-article">
    {{ article.view_name }}
    <small v-if="article.h1part2 != null">
      {{ article.h1part2 }}
    </small>
    <div v-if="edit_enabled == '1'"
        class="btn-group btn-group-sm editable" 
        role="group" 
        aria-label="Button group with nested dropdown">
        <v-button class="btn btn-sm btn-outline-warning" 
                v-b-modal.modal-1
                :title="title">
          <i class="fas fa-pen"></i>
        </v-button>
    </div>

    <b-modal id="modal-1" centered 
      :title="title + ': ' + articlename" 
      header-bg-variant="dark"
      header-text-variant="light"
      body-bg-variant="dark"
      body-text-variant="light"
      footer-bg-variant="dark"
      footer-text-variant="light"  
    >
      <!--b-form @submit="onSubmit" @reset="onReset" v-if="show">
        <b-form-group
          id="input-group-1"
          label="Názov zobrazený v nadpise pre jazyk Slovenčina:"
          label-for="sk_view_name"
          description="We'll never share your email with anyone else."
        >
          <b-form-input
            id="sk_view_name"
            v-model="form.email"
            type="email"
            placeholder="Enter email"
            required
          ></b-form-input>
        </b-form-group>
      </b-form -->
    </b-modal>
  </h1>
</template>

<style>

</style>