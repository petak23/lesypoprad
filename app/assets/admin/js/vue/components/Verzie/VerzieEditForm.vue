<script>
/**
 * Komponenta pre formulár na zadanie/editáciu verzií.
 * Posledna zmena 26.09.2022
 *
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.0
 */
import trix from 'trix'

export default {
  components: {
    trix,
  },
  data() {
    return {
      text: "",
    }
  },
  mounted() {
    document.addEventListener('trix-change', () => {
        this.text = document.getElementById('x').value
    })
  },
}
</script>

<template>
  <form>
    <input id="x" :value="text" type="hidden" name="text">
    <trix-editor input="x"></trix-editor>
  </form>

</template>


<style lang="scss" scoped="">
@import '~trix/dist/trix.css';
</style>