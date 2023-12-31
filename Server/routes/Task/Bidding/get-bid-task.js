import exprees from 'express';
import pool from '../../../dbcon.js';
import { authTocken } from '../../../middleware/authentication.js';

const router = exprees.Router();

router.get('/', authTocken, async (req, res) => {
    try {
        const query1 = {
            text: 'SELECT category FROM public."ServiceProvider" where id=$1;',
            values : [req.user.user_id]
        }
        const taskCategories = await pool.query(query1);
        const categories = taskCategories.rows[0].category;
        let jobs = {};
        let cards = [];

        for (let i = 0; i < categories.length; i++) {
            categories[i] = categories[i].replace(' ', '');
            const queryText = 'SELECT * FROM public."'+ categories[i] +'" WHERE id NOT IN (SELECT "serviceId" FROM public."Bid" WHERE "serviceProviderId"='+ req.user.user_id +');'
            const query2 = {
                text: queryText
            }
            const task = await pool.query(query2);
            jobs[categories[i]] = task.rows;
        }
        console.log(jobs);

        if (categories.length === 0) {
            res.json(cards);
            return;
        }

        for (let i = 0; i < categories.length; i++) {
            for (let j = 0; j < jobs[categories[i]].length; j++) {

                const query3 = {
                    text: 'SELECT * FROM public."Service" WHERE id = $1 and status in (\'Pending\');',
                    values: [jobs[categories[i]][j]['id']]
                }
                const bidServices = await pool.query(query3);
                if(bidServices.rows.length === 0){
                    continue;
                }
                // console.log(bidServices.rows[0].customerid);

                const query5 = {
                    text: 'SELECT name,id FROM public."Customer" WHERE id= $1;',
                    values: [bidServices.rows[0].customerid]
                }
                const customerName = await pool.query(query5);

                let tasks;
                if(categories[i] === "HairDressing"){
                    const query4 = {
                        text: 'SELECT task FROM public."HairDressingTasks" WHERE id = $1;',
                        values: [jobs[categories[i]][j]['id']]
                    }
                    const temp = await pool.query(query4);
                    tasks = temp.rows;
                }
                else if(categories[i] === "HouseCleaning"){
                    const query4 = {
                        text: 'SELECT task FROM public."HouseCleaningTasks" WHERE id = $1;',
                        values: [jobs[categories[i]][j]['id']]
                    }
                    const temp = await pool.query(query4);
                    tasks = temp.rows;
                } 
                else if(categories[i] === "LawnMoving"){
                    const query4 = {
                        text: 'SELECT "areaInSquareMeter" FROM public."LawnMoving" WHERE id = $1;',
                        values: [jobs[categories[i]][j]['id']]
                    }
                    const temp = await pool.query(query4);
                    tasks = temp.rows;
                }

                cards.push({
                    category : categories[i],
                    serviceValue : bidServices.rows[0],
                    jobTasks : tasks,
                    customerName : customerName.rows[0].name,
                    customerId : customerName.rows[0].id
                });
            }
        }
        res.json(cards);
    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

export default router;