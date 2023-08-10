import express, {json} from "express";
import cors from "cors";
import dotenv from "dotenv";
import cookieParser from "cookie-parser";
import { dirname,join } from "path";
import {fileURLToPath} from "url";

import userReg from "./routes/authentication/user-register.js";
import userLogin from "./routes/authentication/user-login.js";
import userLogout from "./routes/authentication/user-logout.js";

import getUserTest from "./routes/profileManagement/get-user-test.js";
import getUser from "./routes/profileManagement/view-profile.js";
import editUser from "./routes/profileManagement/edit-profile.js";

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
app.use("/loginSP", userLogin);
app.use("/logoutSP", userLogout);

app.use("/testGet", getUserTest);
app.use("/getUser", getUser);
app.use("/editUser", editUser);

app.listen(PORT, () => {
    console.log(`Server running on port: ${PORT}`);
});