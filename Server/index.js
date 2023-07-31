import express, {json} from "express";
import cors from "cors";
import dotenv from "dotenv";
import cookieParser from "cookie-parser";
import userReg from "./routes/user-register.js";
import { dirname,join } from "path";
import {fileURLToPath} from "url";

dotenv.config();

const __dirname = dirname(fileURLToPath(import.meta.url));

const app = express();
const PORT = process.env.PORT || 5000;
const corsOptions = {credentials: true, origin: process.env.URL || "http://localhost:5000"};

app.use(cors(corsOptions));
app.use(json());
app.use(cookieParser());

app.use(express.static(join(__dirname, "public")));
app.use("/registerSP", userReg);

app.listen(PORT, () => {
    console.log(`Server running on port: ${PORT}`)
});