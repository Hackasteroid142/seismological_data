import axios from "axios";

const featureService = {
    getFeatures: async () => {
        try {
            const instance = axios.create({ baseURL: "http://localhost:8080/"})
            const result = await instance.get("/features?per_page=10&page=1")
            return result.data;
        } catch (error) {
            throw new Error(error);
        }
    }
}

export default featureService;