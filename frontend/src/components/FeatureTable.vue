<template>
  <v-data-table
    v-model:page="page"
    :headers="headers"
    :items="items"
    :items-per-page="itemsPerPage"
  >
    <template v-slot:top>
      <v-text-field
        :model-value="page"
        class="pa-2"
        label="Page"
        type="number"
        hide-details
        @update:model-value="updateFeaturesByPage($event)"
      ></v-text-field>

      <v-text-field
        :model-value="itemsPerPage"
        class="pa-2"
        label="Items per page"
        max="15"
        min="-1"
        type="number"
        hide-details
        @update:model-value="updateFeaturesByItemsPerPage($event)"
      ></v-text-field>

      <v-select
        v-model="selectedFilters"
        :items="filters"
        label="Mag Type"
        multiple
        persistent-hint
      ></v-select>
    </template>

    <template v-slot:[`item.actions`]="{ item }">
      <v-btn size="small" @click="deleteItem(item)"> Crear comentario </v-btn>
    </template>
  </v-data-table>
</template>

<script>
import featureService from "@/services/featureService.js";

export default {
  data() {
    return {
      page: 1,
      itemsPerPage: 20,
      headers: [
        {
          align: "center",
          title: "External ID",
          key: "attributes.external_id",
        },
        {
          align: "center",
          title: "Título",
          key: "attributes.title",
        },
        {
          align: "center",
          title: "Lugar",
          key: "attributes.place",
        },
        {
          align: "center",
          title: "Fecha",
          key: "attributes.time",
        },
        {
          align: "center",
          title: "Tsunami",
          key: "attributes.tsunami",
        },
        {
          align: "center",
          title: "Tipo Mag",
          key: "attributes.mag_type",
        },
        {
          align: "center",
          title: "Longitud",
          key: "attributes.coordinates.longitude",
        },
        {
          align: "center",
          title: "Latitud",
          key: "attributes.coordinates.latitude",
        },
        {
          align: "center",
          title: "Magnitud",
          key: "attributes.magnitude",
        },
        {
          align: "center",
          title: "URL",
          key: "links.external_url",
        },
        {
          align: "center",
          title: "Acción",
          key: "actions",
          sortable: false,
        },
      ],
      filters: ["md", "ml", "ms", "mw", "me", "mi", "mb", "mlg"],
      selectedFilters: [],
      items: [],
    };
  },

  async created() {
    let result = await featureService.getFeatures(this.page, this.itemsPerPage);
    this.items = result.data;
  },

  watch: {
    selectedFilters(newValue, oldValue) {
      console.log(oldValue)
      this.updateFeaturesByMagType(newValue);
    }
  },

  methods: {
    deleteItem(item) {
      console.log(item);
    },
    async updateFeaturesByItemsPerPage(itemsPerPage) {
      console.log(itemsPerPage);
      if (itemsPerPage) {
        this.itemsPerPage = parseInt(itemsPerPage, 10);
        let result = await featureService.getFeatures(
          this.page,
          this.itemsPerPage
        );
        this.items = result.data;
      }
    },
    async updateFeaturesByPage(page) {
      console.log(page);
      if (page) {
        this.page = parseInt(page, 10);
        let result = await featureService.getFeatures(
          this.page,
          this.itemsPerPage
        );
        this.items = result.data;
      }
    },

    async updateFeaturesByMagType(magType) {
      console.log(magType);
      if(magType){
        const magTypeString = magType.toString();
        let result = await featureService.getFeatures(
          this.page,
          this.itemsPerPage,
          magTypeString
        );
        this.items = result.data;
      }
    },
  },
};
</script>
