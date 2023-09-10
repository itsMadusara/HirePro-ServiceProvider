import express, {json} from "express";
import cors from "cors";
import dotenv from "dotenv";
import cookieParser from "cookie-parser";
import { dirname,join } from "path";
import {fileURLToPath} from "url";

import getRefreshToken from "./routes/authentication/authentication-refrsh.js";
import userReg from "./routes/authentication/user-register.js";
import userLogin from "./routes/authentication/user-login.js";
import userLogout from "./routes/authentication/user-logout.js";

import getUserTest from "./routes/profileManagement/get-user-test.js";
import getUser from "./routes/profileManagement/view-profile.js";
import editUser from "./routes/profileManagement/edit-profile.js";
import addCategory from "./routes/profileManagement/add-category.js";
import changePassword from "./routes/profileManagement/change-password.js";

import getBidTasks from "./routes/Task/Bidding/get-bid-task.js";
import bidTask from "./routes/Task/Bidding/bid-on-task.js";
import getContact from "./routes/Task/Bidding/get-phone-number.js";

import getOngoingTasks from "./routes/Task/ongoing/get-tasks-ongoing.js";
import setStarted from "./routes/Task/ongoing/start.js";
import setArrived from "./routes/Task/ongoing/arrived.js";
import setCompleted from "./routes/Task/ongoing/completed.js";

import { get } from "http";

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
app.use("/refreshToken", getRefreshToken);

app.use("/testGet", getUserTest);
app.use("/getUser", getUser);
app.use("/editUser", editUser);
app.use("/addCategory", addCategory);
app.use("/changePassword", changePassword);

app.use("/getBiddingTasks", getBidTasks);
app.use("/bidTask", bidTask);
// app.use("/getContact", getContact);

app.use("/getOngoingtasks", getOngoingTasks);
app.use("/setStarted", setStarted);
app.use("/setArrived", setArrived);
app.use("/setCompleted", setCompleted);

app.listen(PORT, () => {
    console.log(`Server running on port: ${PORT}`);
});