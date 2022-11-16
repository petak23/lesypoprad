<template>
  <div class="editor" v-if="editor">
    <menu-bar class="editor__header" :editor="editor" />
    <editor-content :editor="editor" />
  </div>
</template>

<script>
import Highlight from '@tiptap/extension-highlight'
import StarterKit from '@tiptap/starter-kit'
import Link from '@tiptap/extension-link'
import { Color } from '@tiptap/extension-color'
import TextStyle from '@tiptap/extension-text-style'
import { Editor, EditorContent } from '@tiptap/vue-2'

import MenuBar from './MenuBar.vue'

export default {
  components: {
    EditorContent,
    MenuBar,
  },

  props: {
    value: {
      type: String,
      default: '<p>... tu niečo zapíšte ...</p>',
    },
  },

  data() {
    return {
      editor: null,
    }
  },

  watch: {
    value(value) {
      // HTML
      const isSame = this.editor.getHTML() === value

      // JSON
      // const isSame = JSON.stringify(this.editor.getJSON()) === JSON.stringify(value)

      if (isSame) {
        return
      }

      this.editor.commands.setContent(value, false)
    },
  },

  mounted() {
    this.editor = new Editor({
      content: this.value,
      extensions: [
        StarterKit, 
        Highlight,
        TextStyle,
        Color,
        Link.configure({
          //openOnClick: false,
          validate: href => /^https?:\/\//.test(href),
        }),
      ],
      onUpdate: () => {
        // HTML
        this.$root.$emit('tiptap_input', this.editor.getHTML())

        // JSON
        //this.$root.$emit('tiptap_input_json', this.editor.getJSON())
      },
    })
  },

  beforeDestroy() {
    this.editor.destroy()
  },
}
</script>

<style lang="scss">
/* Basic editor styles */
.ProseMirror {
  border: 1px solid #ccc;
  border-radius: .3em;
  min-height: 15rem;
  margin: 1em 0;

  > * + * {
    margin-top: 0.75em;
  }

  ul,
  ol {
    padding: 0 1rem;
  }

  h2,
  h3,
  h4,
  h5,
  h6 {
    line-height: 1.1;
  }

  a {
    color: #68CEF8;
  }

  code {
    font-size: 0.9rem;
    padding: 0.25em;
    border-radius: 0.25em;
    background-color: rgba(#616161, 0.1);
    color: #616161;
    box-decoration-break: clone;
  }

  pre {
    background: #575757;
    color: #FFF;
    font-family: 'JetBrainsMono', monospace;
    padding: 0.75rem 1rem;
    border-radius: 0.5rem;

    code {
      color: inherit;
      padding: 0;
      background: none;
      font-size: 0.8rem;
    }
  }

  img {
    max-width: 100%;
    height: auto;
  }

  blockquote {
    margin-left: 1rem;
    padding-left: 1rem;
    border-left: 2px solid rgba(#0D0D0D, 0.1);
  }

  hr {
    border: none;
    border-top: 2px solid rgba(#0D0D0D, 0.1);
    margin: 2rem 0;
  }
}
</style>