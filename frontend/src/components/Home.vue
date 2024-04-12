<template>
  <div class="hello">
    <v-container>
      <v-row>
        <v-col>
          <div class="text-h1 text-center">Datos sismológicos de USGS</div>
        </v-col>
      </v-row>
      <v-row>
        <v-col>
          <v-card>
            <FeatureTable />
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import FeatureTable from "./FeatureTable.vue";

export default {
  name: "HelloWorld",
  components: {
    FeatureTable,
  },
  props: {
    msg: String,
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}

.text-h1 {
  color: white;
}
</style>
