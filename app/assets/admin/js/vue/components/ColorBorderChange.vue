<script>
/**
 * Komponenta pre zmenu okrajového rámčeka príloh.
 * Posledna zmena 22.04.2022
 * 
 * @author     Ing. Peter VOJTECH ml. <petak23@gmail.com>
 * @copyright  Copyright (c) 2012 - 2022 Ing. Peter VOJTECH ml.
 * @license
 * @link       http://petak23.echo-msz.eu
 * @version    1.0.0
 */
import axios from 'axios'

//for Tracy Debug Bar
axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';

export default {
  props: {
    basePath: {
      type: String,
      required: true
    },
    editButtonView: {
      type: String,
      default: '0'
    },
    idHlavneMenu: {
      type: String,
      required: true
    }
  },
  data: () => ({
    border_a_c: '#ff0000',
    border_a_w: '1',
    border_b_c: '#00ff00',
    border_b_w: '1',
    border_c_c: '#0000ff',
    border_c_w: '1',
    data_origin: {},
  }),
  computed: {
    border_a_l() {
      return {
        border: this.border_a_w+"px solid "+this.border_a_c,
      }
    },
    border_b_l() {
      return {
        border: this.border_b_w+"px solid "+this.border_b_c,
      }
    },
    border_c_l() {
      return {
        border: this.border_c_w+"px solid "+this.border_c_c,
      }
    },
  },
  methods: {
    async save() {
      //console.log(this.border_a_l)
      this.$bvModal.hide('modalBorderChange')
      let odkaz = this.basePath + '/api/menu/saveborder/' + this.idHlavneMenu
      let vm = this
      axios.post(odkaz, {
          borders: {
            border_a: this.border_a_c + "|" + this.border_a_w,
            border_b: this.border_b_c + "|" + this.border_b_w,
            border_c: this.border_c_c + "|" + this.border_c_w,
          },
        })
        .then(response => {
          this.data_origin = response.data.result
          this.dataSet(this.data_origin)
        })
        .catch(function (error) {
          console.log(odkaz)
          console.log(error)
        });      
    },
    cancel() {
      this.dataSet(this.data_origin)
      this.$bvModal.hide('modalBorderChange')
    },
    dataSet(data) {
      //console.log(data)
      this.border_a_c = data.border_a != null ? data.border_a.split('|')[0] : '#cc0000'
      this.border_a_w = data.border_a != null ? data.border_a.split('|')[1] : '1'
      this.border_b_c = data.border_a != null ? data.border_b.split('|')[0] : '#00cc00'
      this.border_b_w = data.border_a != null ? data.border_b.split('|')[1] : '1'
      this.border_c_c = data.border_a != null ? data.border_c.split('|')[0] : '#0000cc'
      this.border_c_w = data.border_a != null ? data.border_c.split('|')[1] : '1'
    }
  },
  mounted() {
    // Načítanie údajov priamo z DB
    let odkaz = this.basePath + '/api/menu/getonehlavnemenuarticle/' + this.idHlavneMenu
    axios.get(odkaz)
          .then(response => {
            //console.log(response.data)
            this.data_origin = response.data
            this.dataSet(this.data_origin)
          })
          .catch((error) => {
            console.log(odkaz);
            console.log(error);
          });
  }
}
</script>

<template>
  <div  class="btn-group btn-group-sm"
        role="group" aria-label="okraje-link" 
        n:if="$clanok->hlavne_menu->id_hlavne_menu_template == 2">
    
  
    <b-button v-b-modal.modalBorderChange
              variant="outline-info"
              v-if="editButtonView == '1'"
              >
      <i class="fas fa-pencil-alt"></i> Nastav okrajový rámček
    </b-button>
    <b-modal 
      id="modalBorderChange"
      title="Zmena okrajového rámčeka"
      ok-title="Ulož"
      centered
      @ok="save"
      @cancel="cancel"
    >
      <div class="row"><!-- modal form begin -->
        <div class="col-6">    
          <label n:name=border_a_width>Okraj A:</label>&nbsp;
          <input  type="number" 
                  id="border_a_width" 
                  name="border_a_width" 
                  size=2 min=0 max=99 
                  class="input_number"
                  v-model="border_a_w"> px
          <input  type="color" 
                  id="favcolor" 
                  name="favcolor" 
                  v-model="border_a_c">
          <br />
          <label n:name=border_a_width>Okraj B:</label>&nbsp;
          <input  type="number" 
                  id="border_b_width" 
                  name="border_b_width" 
                  size=2 min=0 max=99 
                  class="input_number"
                  v-model="border_b_w"> px
          <input  type="color" 
                  id="favcolor" 
                  name="favcolor" 
                  v-model="border_b_c">
          <br />
          <label n:name=border_a_width>Okraj C:</label>&nbsp;
          <input  type="number" 
                  id="border_c_width" 
                  name="border_c_width" 
                  size=2 min=0 max=99 
                  class="input_number"
                  v-model="border_c_w"> px
          <input  type="color" 
                  id="favcolor" 
                  name="favcolor" 
                  v-model="border_c_c">
        </div>    
        

        <div class="col-6 pv-okraj-nahlad">
          <div class="okraj-nahlad-tmavy">
            <div class="border_x2 okraj-c" v-bind:style="border_c_l">
              <div class="border_x2 okraj-b" v-bind:style="border_b_l">
                <img :src="basePath + '/images/okraj_temp.png'" alt="okraj" class="border_x2 okraj-a" v-bind:style="border_a_l">
              </div>
            </div>
          </div>
          <div class="okraj-nahlad-svetly">
            <div class="border_x2 okraj-c" v-bind:style="border_c_l">
              <div class="border_x2 okraj-b" v-bind:style="border_b_l">
                <img :src="basePath + '/images/okraj_temp.png'" alt="okraj" class="border_x2 okraj-a" v-bind:style="border_a_l">
              </div>
            </div>
          </div>
        </div>

      </div><!-- modal form end -->  
    </b-modal>
  </div>

</template>

<style lang="scss" scoped>
.border_x2 {
  display: inline-block;
}
.okraj-nahlad-tmavy {
  background-color: black;
  padding: 1rem;
  border: 1px solid #999;
}
.okraj-nahlad-svetly {
  background-color: white;
  padding: 1rem;
  border: 1px solid #999;
}
.input_number {
  width: 5rem;
}
</style>