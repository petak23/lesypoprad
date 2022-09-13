<template>
  <div class="single-upload">
    <b-form-group
      label="Typ prílohy:"
      v-slot="{ ariaDescribedby }"
    >
      <b-form-radio-group
        id="btn-type"
        v-model="selected"
        :options="options"
        :aria-describedby="ariaDescribedby"
        button-variant="outline-primary"
        name="file-type"
        buttons
      ></b-form-radio-group>
    </b-form-group>
    <div class="d-flex justify-content-around">
      <div class="upload-container d-flex justify-content-center align-items-center">
        <input
          :id="id"
          type="file"
          ref="imageUploader"
          class="input-uploader"
          @change="imageInserted"
        />
        <div class="uploader-icon"><i class="fa-solid fa-upload fa-2x"></i></div>
      </div>
      <div class="flex-grow-1 d-flex flex-column px-3 justify-content-around">
        <bProgress v-if="isUploading" :value="value" :max="max" show-progress animated />
        <bImg
          v-if="uploadedImage"
          class="mt-1"
          height="80px"
          width="80px"
          :src="basePath + uploadedImage"
          thumbnail
          fluid
          alt="Responsive image"
        />
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
export default {
  props: {
    apiUrl: {
      type: String,
      required: true,
    },
    basePath: {
      type: String,
      required: true,
    },
    id: {
      type: String,
      required: true,
    },
    id_hlavne_menu: {
      type: String,
      required: true,
    },
    backLink: String,
  },
  data: () => ({
    value: 0,
    max: 100,
    file: null,
    isUploading: false,
    uploadedImage: null,
    selected: '1',
    options: [
      { text: 'Iné', value: '1' },
      { text: 'Obrázok', value: '2' },
      { text: 'Video', value: '3'},
      { text: 'Audio', value: '4' }
    ]
  }),
  methods: {
    imageInserted() {
      this.file = this.$refs.imageUploader.files[0];
      this.uploadImageMethod();
      this.$refs.imageUploader.value = null;
    },
    async uploadImageMethod() {
      let formData = new FormData();
      formData.append("priloha", this.file);
      formData.append("type", this.selected);
      //for(var pair of formData.entries()) {
      //  console.log(pair[0], pair[1]);
      //}
      this.isUploading = true;
      let odkaz = this.basePath + "/" + this.apiUrl + "/" + this.id_hlavne_menu
      let _this = this
      await axios.post(odkaz, formData, {
        headers: {
          "Content-Type": "multipart/form-data",
        },
        onUploadProgress: ({ total, loaded }) => {
          this.value = (loaded / total).toFixed(2) * 100;
        },
      })
      .then(response => {
        // https://stackoverflow.com/questions/35664550/vue-js-redirection-to-another-page
        window.location.href = _this.backLink;
        //console.log(response.data.data)
        /*_this.uploadedImage = response.data.data.main_file
        _this.file = null;
        _this.isUploading = false;*/
      })
    },
  },
  /*mounted () {
    const url = "" //window.location.origin;
    API.defaults.baseURL = url + this.path
  },*/
};
</script>

<style lang="scss" scoped>
.single-upload {
  .upload-container {
    height: 100px !important;
    width: 100px !important;
    border: 2px dashed #ccc;
    border-radius: 5px !important;
  }
  .upload-container:hover {
      background-color: rgb(175, 245, 169) !important;
  }

  .input-uploader {
    opacity: 0;
    position: absolute;
    width: 100px !important;
    height: 100px !important;
  }

  .uploader-icon {
    width: 35px !important;
    height: 35px !important;
    color: #28a745;
  }
}
</style>