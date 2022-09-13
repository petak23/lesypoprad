<script>
/** 
 * Component Fotocollage
 * Posledná zmena(last change): 04.04.2022
 *
 * @author Ing. Peter VOJTECH ml <petak23@gmail.com>
 * @copyright Copyright (c) 2021 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link http://petak23.echo-msz.eu
 * @version 1.0.3
 * 
 */
import axios from 'axios'
import _ from 'lodash'
import Verte from 'verte'

//for Tracy Debug Bar
axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';

export default {
  components: { Verte },
  props: {
    id_hlavne_menu: String,
    basePath: String,
    link: String,
    articleText: String,
  },
  data() {
    return {
      textin: '',
      preview: '',
      show: true,
      color: '',
    }
  },
  methods: {
    onSubmit(event) {
      event.preventDefault()
      let odkaz = this.basePath + 'api/menu/texylasave/' + this.id_hlavne_menu
      let vm = this
      axios.post(odkaz, {
          texy: this.textin,
        })
        .then(function (response) {
          //vm.preview = response.data
          //console.log(response.data)
          // https://stackoverflow.com/questions/35664550/vue-js-redirection-to-another-page
          window.location.href = vm.link;
        })
        .catch(function (error) {
          console.log(odkaz)
          console.log(error)
        });      
    },
    onCancel(event) {
      event.preventDefault()
      window.location.href = this.link;
    },
    insertB() {
      this.insertSomething("**","**")
    },
    insertI() {
      this.insertSomething("//","//")
    },
    insertH(id=3) {
      let h = {
        3: "***********",
        4: "===========",
        5: "-----------"
      }
      id = (id > 5 || id < 3) ? 3 : id
      this.insertSomething("", "\n" + h[id] + "\n")
    },
    align(id=1) {
      let a = {
        1: ".<",
        2: ".<>",
        3: ".>",
        4: ".=",
      }
      id = (id > 4 || id < 1) ? 1 : id
      this.insertSomething(a[id] + "\n")
    },
    insertHr() {
      this.insertSomething("\n------------\n")
    },
    insertListUl() {
      this.insertSomething("- \n- \n- \n")
    },
    insertListOl() {
      this.insertSomething("1) \n2) \n3) \n")
    },
    insertLink() {
      this.insertSomething('"', '":[http://www.odkaz.sk]')
    },
    insertColor() {
      //...
    },
    insertSomething(valueBefore, valueAfter = null) {
        let textArea = document.getElementsByName('texyla')[0];
        let startPos = textArea.selectionStart,
            // get cursor's position:
            endPos = valueAfter !== null ? textArea.selectionEnd : startPos,
            cursorPos = startPos, 
            tmpStr = textArea.value;
        if (valueBefore === null) {
            return;
        }

        // insert:
        let tst = tmpStr.substring(0, startPos) + valueBefore
        if (valueAfter !== null) {
          if (startPos < endPos) {
            tst += tmpStr.substring(startPos, endPos)
          }
          tst += valueAfter
        }
        tst += tmpStr.substring(endPos, tmpStr.length)
        this.textin = tst

        // move cursor:
        setTimeout(() => {
            cursorPos += valueBefore.length;
            textArea.selectionStart = textArea.selectionEnd = cursorPos;
        }, 10);
    },
    getPreview: function () {
      let odkaz = this.basePath + 'api/texyla/preview'
      //this.preview = "Vytváram náhľad..."
      let vm = this
      axios.post(odkaz, {
          texy: this.textin,
        })
        .then(function (response) {
          vm.preview = response.data
        })
        .catch(function (error) {
          console.log(odkaz)
          console.log(error)
        });
    }
  },
  watch: {
    textin: function (newTextin, oldTextin) {
      this.debouncedGetPreview()
    },
  },
  created: function () {
    this.textin = this.articleText
    // https://v2.vuejs.org/v2/guide/computed.html?redirect=true#Watchers
    this.debouncedGetPreview = _.debounce(this.getPreview, 1000)
  },
}
</script>

<template>
  <div>
    <b-form @submit="onSubmit" @reset="onCancel" v-if="show">
        <b-button-toolbar key-nav aria-label="Application toolbar">
          <b-button-group size="sm" class="mx-1">
            <b-button variant="outline-info" @click="insertB" title="Bold">
              <i class="fa-solid fa-bold"></i>
            </b-button>
            <b-button variant="outline-info" @click="insertI" title="Italic">
              <i class="fa-solid fa-italic"></i>
            </b-button>
          </b-button-group>
          <b-button-group size="sm" class="mx-1">
            <b-button variant="outline-info" @click="insertH(3)" title="Nadpis H3">
              <i class="fa-solid fa-h"></i>3
            </b-button>
            <b-button variant="outline-info" @click="insertH(4)" title="Nadpis H4">
              <i class="fa-solid fa-h"></i>4
            </b-button>
            <b-button variant="outline-info" @click="insertH(5)" title="Nadpis H5">
              <i class="fa-solid fa-h"></i>5
            </b-button>
          </b-button-group>
          <b-button-group size="sm" class="mx-1">
            <b-button variant="outline-info" @click="insertHr" title="Horizontálna čiara">
              <i class="fa-solid fa-ruler-horizontal"></i>
            </b-button>
            <b-button variant="outline-info" @click="insertListUl" title="Nečíslovaný zoznam">
              <i class="fa-solid fa-list-ul"></i>
            </b-button>
            <b-button variant="outline-info" @click="insertListOl" title="Číslovaný zoznam">
              <i class="fa-solid fa-list-ol"></i>
            </b-button>
            <b-button variant="outline-info" @click="insertLink" title="Odkaz">
              <i class="fa-solid fa-link"></i>
            </b-button>
          </b-button-group>
          <b-button-group size="sm" class="mx-1">
            <b-dropdown class="mx-1" right variant="outline-info">
              <template #button-content>
                <i class="fa-solid fa-align-left"></i>
              </template>
              <b-dropdown-item>
                <b-button variant="link" @click="align(1)" title="Zarovnaj vľavo">
                  <i class="fa-solid fa-align-left"></i> Zarovnaj vľavo
                </b-button></b-dropdown-item>
              <b-dropdown-item>
                <b-button variant="link" @click="align(2)" title="Zarovnaj na stred">
                  <i class="fa-solid fa-align-center"></i> Zarovnaj na stred
                </b-button>
              </b-dropdown-item>
              <b-dropdown-item>
                <b-button variant="link" @click="align(3)" title="Zarovnaj vpravo">
                  <i class="fa-solid fa-align-right"></i> Zarovnaj vpravo
                </b-button>
              </b-dropdown-item>
              <b-dropdown-item>
                <b-button variant="link" @click="align(4)" title="Zarovnaj do bloku">
                  <i class="fa-solid fa-align-justify"></i> Zarovnaj do bloku
                </b-button>
              </b-dropdown-item>
            </b-dropdown>
            
          </b-button-group>
          <b-button-group size="sm" class="mx-1">
            <b-button variant="outline-info" @click="insertColor" title="Vlož farbu">
              
              <!--verte v-model="color" model="hex">
                <i class="fa-solid fa-palette"></i>
              </verte -->

            </b-button>
          </b-button-group>
        </b-button-toolbar>
      
        <b-form-textarea
          id="text"
          v-model="textin"
          placeholder="Zadajte text..."
          rows="6"
          max-rows="6"
          description="Pre formátovanie využite syntax texy."
          name="texyla"
        ></b-form-textarea>

      <b-button type="submit" variant="primary">Ulož</b-button>
      <b-button type="reset" variant="secondary">Cancel</b-button>
    </b-form>
    <div class="mt-2 text-white">Náhľad<small>(aktualizuje sa cca. 1x za sekundu)</small>:</div>
    <div class="text-left" v-html="preview"></div>
    <!-- b-card class="text-dark text-left" v-html="preview"></b-card -->
  </div>
</template>