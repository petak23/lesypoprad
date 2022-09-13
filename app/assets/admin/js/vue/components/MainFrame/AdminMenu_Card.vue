<script>
/**
 * Komponenta pre administračné menu na admin:homepage:default
 * 
 * Posledna zmena 01.12.2021
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2021 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.0
 */

import vuetify from '@/admin/js/vue/plugins/vuetify'


export default {
  vuetify,
  props: {
    name: {
      type: String,
      required: true
    },
    link: {
      type: String,
      required: true
    },
    img_src: {
      type: String,
      required: true
    },
  },
  components: {

  },

}
</script>

<template>
  <v-card
    class="mx-auto" 
  >
    <a :href="link" :title="name">
      <v-img
        :src="img_src"
      ></v-img>
    </a>  

    <v-card-actions>
      <v-btn
        color="blue lighten-1"
        text
        :href="link"
      >
        {{ name }}
      </v-btn>
    </v-card-actions>

  </v-card>
</template>

<style>

</style>