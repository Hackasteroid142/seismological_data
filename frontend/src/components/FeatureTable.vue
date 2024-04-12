<template>
  <v-data-table
    v-model:page="page"
    :headers="headers"
    :items="items"
    :items-per-page="itemsPerPage"
  >
  <template v-slot:[`item.actions`]="{ item }">
      <v-btn
        size="small"
        @click="deleteItem(item)"
      >
        Crear comentario
      </v-btn>
    </template>
    <template v-slot:bottom>
      <div class="text-center pt-2">
        <v-pagination v-model="page" :length="pageCount"></v-pagination>
      </div>
    </template>
  </v-data-table>
</template>

<script>
import featureService from "@/services/featureService.js";

export default {
  data() {
    return {
      page: 1,
      itemsPerPage: 5,
      headers: [
        {
          align: 'center',
          title: "External ID",
          key: "attributes.external_id",
        },
        {
          align: 'center',
          title: "Título",
          key: "attributes.title",
        },
        {
          align: 'center',
          title: "Lugar",
          key: "attributes.place",
        },
        {
          align: 'center',
          title: "Fecha",
          key: "attributes.time",
        },
        {
          align: 'center',
          title: "Tsunami",
          key: "attributes.tsunami",
        },
        {
          align: 'center',
          title: "Tipo Mag",
          key: "attributes.mag_type",
        },
        {
          align: 'center',
          title: "Longitud",
          key: "attributes.coordinates.longitude",
        },
        {
          align: 'center',
          title: "Latitud",
          key: "attributes.coordinates.latitude",
        },
        {
          align: 'center',
          title: "Magnitud",
          key: "attributes.magnitude",
        },
        {
          align: 'center',
          title: "URL",
          key: "links.external_url",
        },
        {
          align: 'center',
          title: "Acción",
          key: "actions",
          sortable: false,
        },
      ],
      items: [],
    };
  },

  async created() {
    let result = await featureService.getFeatures();
    this.items = result.data;
  },

  computed: {
    pageCount() {
      return Math.ceil(this.items.length / this.itemsPerPage);
    },
  },

  methods: {
    deleteItem (item) {
      console.log(item)
    }
  }
};
</script>
