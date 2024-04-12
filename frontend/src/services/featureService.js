import axios from "axios";

const featureService = {

    /**
     *  Obtiene features según los filtros aplicados
     * 
     *  @param { number } page Número de página que se desea ver
     *  @param { number } itemsperpage Cantidad de elementos por página
     *  @param { string } magType Filtro por magType
     *  @return { object } Features con los filtros aplicados
     */  
    getFeatures: async (page, itemsperpage, magType) => {
    try {
      let endpoint = "/features?per_page=" + itemsperpage + "&page=" + page;
      if (magType) {
        endpoint = endpoint + "&magType=" + magType;
      }
      const instance = axios.create({ baseURL: "http://localhost:8080/" });
      const result = await instance.get(endpoint);
      return result.data;
    } catch (error) {
      throw new Error(error);
    }
  },

  /**
   * Crea un comentario asociado a un feature
   * 
   * @param { number } id Identificador de feature
   * @param { string } comment Texto de comentario
   * 
   * @returns { object } Respuesta de consulta
   */
  createComment: async (id, comment) => {
    try {
      const body = {
        body: comment,
      };
      const instance = axios.create({ baseURL: "http://localhost:8080/" });
      const result = await instance.post("/features/" + id + "/comment", body);
      return result.data;
    } catch (error) {
      throw new Error(error);
    }
  },
};

export default featureService;
