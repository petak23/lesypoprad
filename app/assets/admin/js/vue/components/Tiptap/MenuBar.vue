<template>
  <div>
    <template v-for="(item, index) in items">
      <div 
        class="divider"
        v-if="item.type === 'divider'"
        :key="`divider${index}`" />
      <input
        v-else-if="item.type === 'color'"
        type="color"
        :key="index"
        @input="editor.chain().focus().setColor($event.target.value).run()"
        :value="editor.getAttributes('textStyle').color"
      >
      <button 
        v-else-if="item.type === 'link'"
        :key="index"
        @click="setLink"
        class="menu-item"
        :class="{ 'is-active': editor.isActive('link') }"
        title="Odkaz"
        >
        <i :class="'ri-link'"></i>
      </button>
      <menu-item 
        v-else 
        :key="index"
        v-bind="item" />
    </template>
  </div>
</template>

<script>
import 'remixicon/fonts/remixicon.css'
import MenuItem from './MenuItem.vue'

export default {
  components: {
    MenuItem,
  },

  props: {
    editor: {
      type: Object,
      required: true,
    },
  },

  data() {
    return {
      items: [
        {
          icon: 'bold',
          title: 'Tučné',
          action: () => this.editor.chain().focus().toggleBold().run(),
          isActive: () => this.editor.isActive('bold'),
        },
        {
          icon: 'italic',
          title: 'Kurzíva',
          action: () => this.editor.chain().focus().toggleItalic().run(),
          isActive: () => this.editor.isActive('italic'),
        },
        {
          icon: 'strikethrough',
          title: 'Preškrtnuté',
          action: () => this.editor.chain().focus().toggleStrike().run(),
          isActive: () => this.editor.isActive('strike'),
        },
        {
          type: 'color',
        },
        {
          type: 'divider',
        },
        {
          icon: 'h-2',
          title: 'Nadpis 2',
          action: () => this.editor.chain().focus().toggleHeading({ level: 2 }).run(),
          isActive: () => this.editor.isActive('heading', { level: 2 }),
        },
        {
          icon: 'h-3',
          title: 'Nadpis 3',
          action: () => this.editor.chain().focus().toggleHeading({ level: 3 }).run(),
          isActive: () => this.editor.isActive('heading', { level: 3 }),
        },
        {
          icon: 'h-4',
          title: 'Nadpis 4',
          action: () => this.editor.chain().focus().toggleHeading({ level: 4 }).run(),
          isActive: () => this.editor.isActive('heading', { level: 4 }),
        },
        /*{
          icon: 'paragraph',
          title: 'Odstavec',
          action: () => this.editor.chain().focus().setParagraph().run(),
          isActive: () => this.editor.isActive('paragraph'),
        },*/
        {
          icon: 'list-unordered',
          title: 'Nečíslovaný zoznam',
          action: () => this.editor.chain().focus().toggleBulletList().run(),
          isActive: () => this.editor.isActive('bulletList'),
        },
        {
          icon: 'list-ordered',
          title: 'Číslovaný zoznam',
          action: () => this.editor.chain().focus().toggleOrderedList().run(),
          isActive: () => this.editor.isActive('orderedList'),
        },
        {
          icon: 'code-view',
          title: 'Jednoriadkový kód',
          action: () => this.editor.chain().focus().toggleCode().run(),
          isActive: () => this.editor.isActive('code'),
        },
        {
          icon: 'code-box-line',
          title: 'Blok kódu',
          action: () => this.editor.chain().focus().toggleCodeBlock().run(),
          isActive: () => this.editor.isActive('codeBlock'),
        },
        {
          type: 'divider',
        },
        {
          icon: 'double-quotes-l',
          title: 'Citácia',
          action: () => this.editor.chain().focus().toggleBlockquote().run(),
          isActive: () => this.editor.isActive('blockquote'),
        },
        {
          icon: 'separator',
          title: 'Horizontálna čiara',
          action: () => this.editor.chain().focus().setHorizontalRule().run(),
        },
        {
          //icon: 'link',
          type: 'link',
          //title: 'Odkaz',
          //action: () => this.setLink,
          //isActive: () => this.editor.isActive('link'),
        },
        {
          type: 'divider',
        },
        {
          icon: 'text-wrap',
          title: 'Tvrdý zlom(nový riadok)',
          action: () => this.editor.chain().focus().setHardBreak().run(),
        },
        {
          icon: 'format-clear',
          title: 'Zmaž formátovanie',
          action: () => this.editor.chain()
            .focus()
            .clearNodes()
            .unsetAllMarks()
            .run(),
        },
        {
          type: 'divider',
        },
        {
          icon: 'arrow-go-back-line',
          title: 'Naspäť',
          action: () => this.editor.chain().focus().undo().run(),
        },
        {
          icon: 'arrow-go-forward-line',
          title: 'Dopredu',
          action: () => this.editor.chain().focus().redo().run(),
        },
      ],
    }
  },
  methods: {
    setLink() {
      
      const previousUrl = this.editor.getAttributes('link').href
      const url = window.prompt('URL', previousUrl)

      
      // cancelled
      if (url === null) {
        return
      }

      // empty
      if (url === '') {
        this.editor
          .chain()
          .focus()
          .extendMarkRange('link')
          .unsetLink()
          .run()

        return
      }
      // update link
      this.editor
        .chain()
        .focus()
        .extendMarkRange('link')
        .setLink({ href: url })
        .run()
    },
  },
}
</script>

<style lang="scss">
.divider {
  width: 2px;
  height: 1.25rem;
  background-color: rgba(#000, 0.1);
  margin-left: 0.5rem;
  margin-right: 0.75rem;
  display: inline-block;
}
</style>