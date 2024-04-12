<template>
  <div class="pa-4 text-center">
    <v-dialog v-model="dialog" max-width="600">
      <template v-slot:activator="{ props: activatorProps }">
        <v-btn
          class="text-none font-weight-regular"
          prepend-icon="mdi-pencil"
          text="Crear comentario"
          variant="tonal"
          v-bind="activatorProps"
        ></v-btn>
      </template>

      <v-card prepend-icon="mdi-pencil" title="Crea un comentario">
        <v-card-text>
          <v-row dense>
            <v-col cols="12">
              <v-form ref="form" v-model="isValid" class="pa-4 pt-6">
                <v-textarea
                  label="Escribe tu comentario aqui*"
                  v-model="comment"
                  :rules="[rules.required]"
                ></v-textarea>
              </v-form>
            </v-col>
          </v-row>
        </v-card-text>

        <v-divider></v-divider>

        <v-card-actions>
          <v-spacer></v-spacer>

          <v-btn text="Cancelar" variant="plain" @click="dialog = false"></v-btn>

          <v-btn
            color="primary"
            text="Guardar"
            variant="tonal"
            :disabled="!isValid"
            @click="createComment()"
          ></v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>
<script>
import featureService from "@/services/featureService";

export default {
  props: ["idItem"],
  data: () => ({
    dialog: false,
    comment: undefined,
    isValid: false,
    rules: {
        required: v => !!v || 'Este campo es obligatorio',
      },
  }),

  methods: {
    async createComment() {
      console.log(this.idItem, this.comment);
      if (this.comment) {
        await featureService.createComment(this.idItem, this.comment);
        this.dialog = false;
        this.comment = undefined;
      }
    },
  },
};
</script>
