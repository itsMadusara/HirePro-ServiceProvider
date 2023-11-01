import exprees from 'express';
import pool from '../../dbcon.js';
import { authTocken } from '../../middleware/authentication.js';

const router = exprees.Router();

router.get('/', authTocken, async (req, res) => {
    try {
        const query1 = {
            text: `SELECT "Payment"."amount", "Payment"."status", "Payment"."serviceid", "Payment"."timestamp", "Bid"."serviceProviderId", "Bid"."accept_customerid", "Customer"."name"
            FROM public."Payment" 
            INNER JOIN public."Bid" ON "Payment"."serviceid" = "Bid"."serviceId" 
			INNER JOIN public."Customer" ON "Bid"."accept_customerid" = "Customer"."id"
            WHERE "Bid"."accept_timestamp" IS NOT NULL AND "Bid"."serviceProviderId" = $1;`,
            values: [req.user.user_id]
        };
        const transactionDetails = await pool.query(query1);
        console.log(transactionDetails.rows);

        // const query2 = {
        //     text: `SELECT "Payment"."amount", "Payment"."status", "Payment"."serviceid", "Payment"."timestamp", "Bid"."serviceProviderId", "Bid"."accept_customerid"
        //     FROM public."Payment" 
        //     INNER JOIN public."Bid" ON "Payment"."serviceid" = "Bid"."serviceId" 
        //     WHERE "Bid"."accept_timestamp" IS NOT NULL AND "Bid"."serviceProviderId" = $1;`,
        //     values: [req.user.user_id]
        // };
        // const totalAmount = await pool.query(query2);
        // console.log(totalAmount.rows);

        const query3 = {
            text: `SELECT SUM("Payment"."amount") AS "TotalServiceAmount"
            FROM public."Payment" 
            INNER JOIN public."Bid" ON "Payment"."serviceid" = "Bid"."serviceId" 
            WHERE "Bid"."accept_timestamp" IS NOT NULL AND "Bid"."serviceProviderId" = $1 AND "Payment"."status" = 'tip';`,
            values: [req.user.user_id]
        };
        const totalServiceAmount = await pool.query(query3);
        console.log(totalServiceAmount.rows);

        const query4 = {
            text: `SELECT SUM("Payment"."amount") AS "TotalTipAmount"
            FROM public."Payment" 
            INNER JOIN public."Bid" ON "Payment"."serviceid" = "Bid"."serviceId" 
            WHERE "Bid"."accept_timestamp" IS NOT NULL AND "Bid"."serviceProviderId" = $1 AND "Payment"."status" = 'service';`,
            values: [req.user.user_id]
        };
        const totalTipAmount = await pool.query(query4);
        console.log(totalTipAmount.rows);
        

        // res.json(isAccountDetailsAdded.rows[0])

    } catch (error) {
        res.status(500).json({error: error.message});
    }
});


export default router;