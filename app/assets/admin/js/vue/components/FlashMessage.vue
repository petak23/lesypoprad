<script>
/**
 * Komponenta pre vypísanie flash správ.
 * Posledna zmena 19.05.2022
 *
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.1
 */
export default {
  props: [
    'text',
    'flashMessages'
  ],

	data() {
		return {
			visible: false,
			message: '',
      mess: [],
		}
	},

	created() {
		if (this.text) {
			this.message = this.text
			this.show()
		}
    if (this.flashMessages.length > 3) {
      this.mess = JSON.parse(this.flashMessages)
      this.show()
    }

		this.$root.$on('flash', message => {
			this.message = message
			this.show()
		})
		this.$root.$on('flash_message', message => {
			this.mess = message
			this.show()
		})
	},

	methods: {
		show() {
			this.visible = true
			setTimeout(() => this.hide(), 3000)
		},
		hide() {
			this.visible = false
		}
	}
}
</script>

<template>
  <transition name="fade" v-if="visible">
    <div class="alert alert-dismissible fade show" 
					v-for="(m, index) in mess" :key="index"	
					:class="'alert-'+m.type"
					>
			<h4 class="alert-heading" v-if="m.heading">{{ m.heading }}</h4>

			<span v-html="m.message"></span>

      <button type="button" class="close" @click="hide">
        <span>&times;</span>
      </button>
    </div>
  </transition>
</template>

<style lang="scss" scoped>
.alert {
  font-size: 0.9rem;
	position: fixed;
	right: 2em;
	bottom: 2em;
  max-width: 50vw;
  z-index: 2000;
	border-width: .25rem;
}
.alert-heading {
	font-weight: bold;
	border-bottom: 1px solid #999;
}
.fade-enter-active,
.fade-leave-active {
	transition: opacity 0.5s;
}
.fade-enter,
.fade-leave-to {
	opacity: 0;
}
</style>