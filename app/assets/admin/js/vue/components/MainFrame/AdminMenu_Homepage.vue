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

import adminmenu_card from './AdminMenu_Card.vue';
import lastlogin from './LastLogin.vue'

export default {
  vuetify,
  components: {
    adminmenu_card,
    lastlogin,
  },
  props: {
    basepath: {
      type: String,
      required: true
    },
    dir_to_icons: {
      type: String,
      required: true
    },
    admin_menu_active: { //Aktuálna aktívna polozka
      type: String,
      default: 0,
    },
    user: {
      type: String,
      required: true
    },
  },
  data() {
    return {};
  },
  computed: {},
  watch: {},
  methods: {},
  mounted() {},
}
</script>

<template>
  <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-xl-4">
    <template v-for="am in $store.state.admin_menu" >
      <div class="col mb-4" v-if="am.id > 1" :key="am.id">
        <adminmenu_card
          v-if="am.id > 1"
          :name = "am.name"
          :link = "am.link"
          :img_src = "basepath + '/' + dir_to_icons + am.avatar"
        >
        </adminmenu_card>
      </div>
    </template>
    <div class="col mb-4">
      <lastlogin
        :basepath="basepath"
        :user="user"
      >
      </lastlogin>
    </div>
  </div>
</template>

<style lang="scss" scoped>

</style>