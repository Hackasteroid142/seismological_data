import axios from "axios";

const featureService = {
    getFeatures: async (page, itemsperpage, magType) => {
        try {
            let endpoint = "/features?per_page="+itemsperpage+"&page="+page;
            if (magType){
                endpoint = endpoint + "&magType=" + magType;
            }
            const instance = axios.create({ baseURL: "http://localhost:8080/"})
            const result = await instance.get(endpoint)
            return result.data;
        } catch (error) {
            throw new Error(error);
        }
    }
}

export default featureService;