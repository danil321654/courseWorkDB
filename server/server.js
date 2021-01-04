if (process.env.NODE_ENV !== "production") {
  require("dotenv").config();
}

const {encrypt, decrypt} = require("./crypto");

const express = require("express");
const app = express();
const bcrypt = require("bcrypt");
const passport = require("passport");
const flash = require("express-flash");
const session = require("express-session");
const methodOverride = require("method-override");
const {Pool} = require("pg");
const pool = new Pool({
  user: "admin",
  host: "localhost",
  database: "pharmacy_shop", //database_name
  password: "admin",
  port: 5432
});

const poolClient = new Pool({
  user: "client",
  host: "localhost",
  database: "pharmacy_shop", //database_name
  password: "client",
  port: 5432
});

const poolManager = new Pool({
  user: "manager",
  host: "localhost",
  database: "pharmacy_shop", //database_name
  password: "manager",
  port: 5432
});
const child_process = require("child_process");
const credentials = {
  host: "localhost",
  user: "postgres",
  pass: "postgres",
  port: 5432,
  db_name: "pharmacy_shop"
};

const dump_command = `pg_dump postgresql://${credentials.user}:${
  credentials.pass
}@${credentials.host}:${credentials.port}/${credentials.db_name} > dump_${
  credentials.db_name
}.sql`;

const restore_command = `psql -U postgres pharmacy_shop < dump_pharmacy_shop.sql`;
/*
 */
const bodyParser = require("body-parser");

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));

const initializePassport = require("./passport-config");
initializePassport(
  passport,
  async email => {
    try {
      const admin = await pool.connect();
      const contactsTable = await admin.query(
        `SELECT * FROM "Client" where email = '${encrypt(email).content}'`
      );
      let user = {};
      if (contactsTable.rows[0])
        user = {...contactsTable.rows[0], role: "CLIENT"};
      else return null;

      const managersTable = await admin.query(
        `SELECT * FROM "Manager" where client_id = '${user.id}'`
      );
      if (managersTable.rows[0])
        user = {...user, role: "MANAGER", manager_id: managersTable.rows[0].id};

      const stockmansTable = await admin.query(
        `SELECT * FROM "Stockman" where client_id = '${user.id}'`
      );

      if (stockmansTable.rows[0])
        user = {
          ...user,
          role: "STOCKMAN",
          delivery_pharmacy_id: stockmansTable.rows[0].delivery_pharmacy_id,
          stockman_id: stockmansTable.rows[0].id
        };

      const adminsTable = await admin.query(
        `SELECT * FROM "Admin" where client_id = '${user.id}'`
      );

      if (adminsTable.rows[0])
        user = {
          ...user,
          role: "ADMIN"
        };
      admin.release();
      return user;
    } catch (err) {
      console.log(err);
      return null;
    }
  },
  async id => {
    try {
      const admin = await pool.connect();
      const contactsTable = await admin.query(
        `SELECT * FROM "Client" where id = '${id}'`
      );
      let user = {};
      if (contactsTable.rows[0])
        user = {...contactsTable.rows[0], role: "CLIENT"};
      else return null;

      const managersTable = await admin.query(
        `SELECT * FROM "Manager" where client_id = '${user.id}'`
      );
      if (managersTable.rows[0]) user = {...user, role: "MANAGER"};

      const stockmansTable = await admin.query(
        `SELECT * FROM "Stockman" where client_id = '${user.id}'`
      );

      if (stockmansTable.rows[0])
        user = {
          ...user,
          role: "STOCKMAN",
          delivery_pharmacy_id: stockmansTable.rows[0].delivery_pharmacy_id
        };

      const adminsTable = await admin.query(
        `SELECT * FROM "Admin" where client_id = '${user.id}'`
      );

      if (adminsTable.rows[0])
        user = {
          ...user,
          role: "ADMIN"
        };
      admin.release();
      return user;
    } catch (err) {
      console.log(err);
      return null;
    }
  }
);

//app.set("view-engine", "ejs");
app.use(express.urlencoded({extended: false}));
app.use(flash());
app.use(
  session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: false
  })
);
app.use(passport.initialize());
app.use(passport.session());
app.use(methodOverride("_method"));

//TODO: hook up react part; currently only express and postgress are connected && add set up notes to MD

/* =============================================  Pool  =================================================
================================================================================================================= */
// pool manages postgreSQL clients;

app.get("/home", checkAuthenticated, async (req, res) => {
  //res.send("need to login");
  try {
    const client = await poolClient.connect();
    const drugs = await client.query('SELECT * FROM "Drug"');
    const pictures = await client.query('SELECT * FROM "Picture"');
    const manufacturers = await client.query('SELECT * FROM "Manufacturer"');
    client.release();
    const user = await req.user;
    //  res.render("index.ejs", {name: user.login, items: Array.from(drugs.rows) });
    res.send({
      items: drugs.rows,
      pictures: pictures.rows,
      manufacturers: manufacturers.rows
    });
  } catch (err) {
    console.log(err);
    res.status(500).send(err);
  }
});

app.get("/login", checkNotAuthenticated);

app.get("/", checkNotAuthenticated, (req, res) => {
  res.status(200).send("logged");
  //res.render("login.ejs");
});

app.get("/categories", checkAuthenticated, async (req, res) => {
  try {
    const client = await poolClient.connect();
    const categories = await client.query('SELECT * FROM "Category"');
    client.release();
    //  res.render("index.ejs", {name: user.login, items: Array.from(drugs.rows) });
    res.send(categories.rows);
  } catch (err) {
    res.status(200).send(err);
  }
});

app.get("/manufacturers", checkAuthenticated, async (req, res) => {
  try {
    const client = await poolClient.connect();
    const manufacturers = await client.query('SELECT * FROM "Manufacturer"');
    client.release();
    //  res.render("index.ejs", {name: user.login, items: Array.from(drugs.rows) });
    res.send(manufacturers.rows);
  } catch (err) {
    res.status(200).send(err);
  }
});

app.get("/adminInfo", checkAuthenticated, async (req, res) => {
  //res.send("need to login");
  try {
    const admin = await pool.connect();
    const contactsTable = await admin.query(`SELECT * FROM "Client"`);
    const managersTable = await admin.query(`SELECT * FROM "Manager"`);
    const stockmansTable = await admin.query(`SELECT * FROM "Stockman"`);
    const adminsTable = await admin.query(`SELECT * FROM "Admin"`);
    const journalTable = await admin.query(`SELECT * FROM "journal"`);
    let journalRow;
    const journal = await Promise.all(
      journalTable.rows.map(async journalEntry => {
        journalRow = await admin.query(
          `SELECT * FROM "${journalEntry.table_name}" where id=${journalEntry.query_id}`
        );
        return {
          ...journalRow.rows[0],
          id: journalEntry.id,
          table_name: journalEntry.table_name
        };
      })
    );
    admin.release();
    res.send({
      clients: contactsTable.rows.map(client => {
        return {
          ...client,
          surname: decrypt(client.surname.toString()),
          name: decrypt(client.name.toString()),
          patronymic: decrypt(client.patronymic.toString()),
          login: decrypt(client.login.toString()),
          email: decrypt(client.email.toString()),
          phone: decrypt(client.phone.toString())
        };
      }),
      managers: managersTable.rows,
      stockmans: stockmansTable.rows,
      admins: adminsTable.rows,
      transactions: journal
    });
  } catch (err) {
    console.log(err);
    res.status(500).send(err);
  }
});

app.get("/managerOrders", checkAuthenticated, async (req, res) => {
  //res.send("need to login");
  try {
    const admin = await pool.connect();
    const user = await req.user;
    const orders = await admin.query(
      `SELECT * FROM "Order" where status='new order'`
    );

    const normalizedOrders = await Promise.all(
      orders.rows.map(async order => {
        const partOrders = await admin.query(
          `SELECT * FROM "Order_Drug" where order_id=${order.id}`
        );
        const deliveryPharmacy = await admin.query(
          `SELECT * FROM "Delivery_pharmacy" where id=${order.delivery_pharmacy_id}`
        );
        const client = await admin.query(
          `SELECT * FROM "Client" where id=${order.client_id}`
        );
        const partOrdersNormalized = {
          ...order,
          client: {
            ...client.rows[0],
            surname: decrypt(client.rows[0].surname.toString()),
            name: decrypt(client.rows[0].name.toString()),
            patronymic: decrypt(client.rows[0].patronymic.toString()),
            login: decrypt(client.rows[0].login.toString()),
            email: decrypt(client.rows[0].email.toString()),
            phone: decrypt(client.rows[0].phone.toString())
          },
          delivery_pharmacy: deliveryPharmacy.rows[0],
          items: await Promise.all(
            partOrders.rows.map(async partOrder => {
              const drug = await admin.query(
                `SELECT * FROM "Drug" where id=${partOrder.drug_id}`
              );
              return {...partOrder, ...drug.rows[0]};
            })
          )
        };
        return partOrdersNormalized;
      })
    );
    const clients = await admin.query(`SELECT * FROM "Client"`);
    admin.release();
    //  res.render("index.ejs", {name: user.login, items: Array.from(drugs.rows) });
    res.status(200).send(normalizedOrders);
  } catch (err) {
    console.log(err);
    res.status(500).send(err);
  }
});

app.get("/stockmanOrders", checkAuthenticated, async (req, res) => {
  //res.send("need to login");
  try {
    const admin = await pool.connect();
    const user = await req.user;
    console.log(
      `SELECT * FROM "Order" where status='approved' and delivery_pharmacy_id=${req.user.delivery_pharmacy_id}`
    );
    const orders = await admin.query(
      `SELECT * FROM "Order" where status='approved' or status = 'in delivery point' and delivery_pharmacy_id=${user.delivery_pharmacy_id}`
    );

    const normalizedOrders = await Promise.all(
      orders.rows.map(async order => {
        const partOrders = await admin.query(
          `SELECT * FROM "Order_Drug" where order_id=${order.id}`
        );
        const deliveryPharmacy = await admin.query(
          `SELECT * FROM "Delivery_pharmacy" where id=${order.delivery_pharmacy_id}`
        );
        const client = await admin.query(
          `SELECT * FROM "Client" where id=${order.client_id}`
        );
        const partOrdersNormalized = {
          ...order,
          client: {
            ...client.rows[0],
            surname: decrypt(client.rows[0].surname.toString()),
            name: decrypt(client.rows[0].name.toString()),
            patronymic: decrypt(client.rows[0].patronymic.toString()),
            login: decrypt(client.rows[0].login.toString()),
            email: decrypt(client.rows[0].email.toString()),
            phone: decrypt(client.rows[0].phone.toString())
          },
          delivery_pharmacy: deliveryPharmacy.rows[0],
          items: await Promise.all(
            partOrders.rows.map(async partOrder => {
              const drug = await admin.query(
                `SELECT * FROM "Drug" where id=${partOrder.drug_id}`
              );
              return {...partOrder, ...drug.rows[0]};
            })
          )
        };
        return partOrdersNormalized;
      })
    );
    const clients = await admin.query(`SELECT * FROM "Client"`);

    admin.release();
    //  res.render("index.ejs", {name: user.login, items: Array.from(drugs.rows) });
    res.status(200).send(normalizedOrders);
  } catch (err) {
    console.log(err);
    res.status(500).send(err);
  }
});

app.get("/orders", checkAuthenticated, async (req, res) => {
  //res.send("need to login");
  try {
    const client = await poolClient.connect();
    const user = await req.user;
    const orders = await client.query(
      `SELECT * FROM "Order" where client_id=${user.id}`
    );
    const receipts = await client.query(`SELECT * FROM "Receipt"`);
    const clientReceipts = receipts.rows.filter(rec =>
      orders.rows.map(ord => ord.id).includes(rec.order_id)
    );
    const normalizedOrders = await Promise.all(
      orders.rows.map(async order => {
        const partOrders = await client.query(
          `SELECT * FROM "Order_Drug" where order_id=${order.id}`
        );
        const deliveryPharmacy = await client.query(
          `SELECT * FROM "Delivery_pharmacy" where id=${order.delivery_pharmacy_id}`
        );
        const partOrdersNormalized = {
          ...order,
          delivery_pharmacy: deliveryPharmacy.rows[0],
          items: await Promise.all(
            partOrders.rows.map(async partOrder => {
              const drug = await client.query(
                `SELECT * FROM "Drug" where id=${partOrder.drug_id}`
              );
              return {...partOrder, ...drug.rows[0]};
            })
          )
        };
        return partOrdersNormalized;
      })
    );

    client.release();
    //  res.render("index.ejs", {name: user.login, items: Array.from(drugs.rows) });
    res.status(200).send({normalizedOrders, clientReceipts});
  } catch (err) {
    console.log(err);
    res.status(500).send(err);
  }
});

app.get("/deliverypharmacies", checkAuthenticated, async (req, res) => {
  //res.send("need to login");
  try {
    const client = await poolClient.connect();
    const deliveryPharmacies = await client.query(
      'SELECT * FROM "Delivery_pharmacy"'
    );
    client.release();
    const user = await req.user;
    res.send(deliveryPharmacies.rows);
  } catch (err) {
    res.status(500).send(err);
  }
});

app.post("/deleteaccount", checkAuthenticated, async (req, res) => {
  //res.send("need to login");
  try {
    const admin = await pool.connect();
    const accounts = await admin.query(
      `delete FROM "Client" where id=${req.body.id}`
    );
    admin.release();
    res.status(200).send(accounts);
  } catch (err) {
    res.status(500).send(err);
  }
});

app.post("/changeaccountrole", checkAuthenticated, async (req, res) => {
  //res.send("need to login");
  console.log(req.body);
  try {
    const admin = await pool.connect();
    const stockmandel = await admin.query(
      `delete FROM "Stockman" where client_id=${req.body.id}`
    );
    const managerdel = await admin.query(
      `delete FROM "Manager" where client_id=${req.body.id}`
    );
    const admindel = await admin.query(
      `delete FROM "Admin" where client_id=${req.body.id}`
    );
    let newInsert;
    if (req.body.role != "Client") {
      console.log(
        `INSERT INTO "${req.body.role}" (client_id) values (${req.body.id})`
      );
      newInsert = await admin.query(
        `INSERT INTO "${req.body.role}" (client_id${
          req.body.delivery_pharmacy_id ? ", delivery_pharmacy_id" : ""
        }) values (${req.body.id}${
          req.body.delivery_pharmacy_id
            ? `, ${req.body.delivery_pharmacy_id}`
            : ""
        })`
      );
    }
    admin.release();
    res.status(200).send("changed");
  } catch (err) {
    console.log(err);
  }
});

app.post(
  "/login",
  checkNotAuthenticated,
  passport.authenticate("local", {
    failureFlash: true
  }),
  async (req, res) => {
    // If this function gets called, authentication was successful.
    // `req.user` contains the authenticated user.
    res.status(200).send(await req.user);
  }
);

app.post("/register", checkNotAuthenticated, async (req, res) => {
  try {
    const hashedPassword = await bcrypt.hash(req.body.password, 10);
    const admin = await pool.connect();
    const eventsTable = await admin.query(
      `INSERT INTO "Client" (surname, name, patronymic, birth_year, login, email, password, phone) VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING *`,
      [
        encrypt(req.body.surname).content,
        encrypt(req.body.name).content,
        encrypt(req.body.patronymic).content,
        req.body.year,
        encrypt(req.body.login).content,
        encrypt(req.body.email).content,
        hashedPassword.toString(),
        encrypt(req.body.phone).content
      ]
    );
    admin.release();
    res.status(200).send("registered");
  } catch (err) {
    console.log(err);
    res.status(500).send(err);
  }
});

app.post("/order", checkAuthenticated, async (req, res) => {
  try {
    const admin = await pool.connect();
    const orderId = await admin.query(
      `INSERT INTO "Order" (client_id, delivery_pharmacy_id, status, order_cost, date) VALUES ($1, $2, $3, $4, current_date) RETURNING id`,
      [req.body.user.id, req.body.deliveryPharmacy.id, "new order", 0]
    );
    req.body.items.map(
      async item =>
        await admin.query(
          `INSERT INTO "Order_Drug" (order_id, drug_id, quantity) VALUES ($1, $2, $3) RETURNING *`,
          [orderId.rows[0].id, item.id, item.quantity]
        )
    );
    //res.json(eventsTable.rows[0]);
    admin.release();
    res.status(200).send("ordered");
  } catch (err) {
    console.log(err);
    res.status(500).send(err);
  }
});

app.post("/manageOrder", checkAuthenticated, async (req, res) => {
  try {
    console.log(
      `UPDATE "Order" SET  status = '${req.body.status}', manager_id = ${req.body.manager_id} WHERE  id = ${req.body.id}`
    );

    const user = await req.user;
    const admin = await pool.connect();
    const orderId = await admin.query(
      `UPDATE "Order" SET  status = '${req.body.status}'${
        req.body.manager_id ? `, manager_id = ${req.body.manager_id}` : ""
      } WHERE  id = ${req.body.id}`
    );

    //res.json(eventsTable.rows[0]);
    admin.release();
    res.status(200).send("accepted");
  } catch (err) {
    console.log(err);
    res.status(500).send(err);
  }
});

app.post("/addNewDrug", checkAuthenticated, async (req, res) => {
  try {
    const admin = await pool.connect();
    const newDrugId = await admin.query(
      `INSERT INTO "Drug" (name, price, active_substance, description, release_form, single_weight, prescription, category_id, manufacturer_id, in_stock) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10) RETURNING id`,
      [
        req.body.name,
        req.body.price,
        req.body.active_substance,
        req.body.description,
        req.body.release_form,
        req.body.single_weight,
        req.body.prescription,
        req.body.category.id,
        req.body.manufacturer.id,
        req.body.in_stock
      ]
    );

    let newPictures = await Promise.all(
      req.body.pictures.map(async picture => {
        let pict = await admin.query(
          `INSERT INTO "Picture" (drug_id, path) VALUES ($1, $2) RETURNING *`,
          [newDrugId.rows[0].id, picture]
        );
      })
    );
    //res.json(eventsTable.rows[0]);
    admin.release();
    res.status(200).send("completed");
  } catch (err) {
    console.log(err);
    res.status(500).send(err);
  }
});

app.post("/addNewCategory", checkAuthenticated, async (req, res) => {
  try {
    const admin = await pool.connect();
    const newDrugId = await admin.query(
      `INSERT INTO "Category" (name, parent) VALUES ($1, $2) RETURNING id`,
      [req.body.name, req.body.category.id]
    );

    //res.json(eventsTable.rows[0]);
    admin.release();
    res.status(200).send("completed");
  } catch (err) {
    console.log(err);
    res.status(500).send(err);
  }
});

app.post("/addNewManufacturer", checkAuthenticated, async (req, res) => {
  try {
    const admin = await pool.connect();
    const newDrugId = await admin.query(
      `INSERT INTO "Manufacturer" (name, country) VALUES ($1, $2) RETURNING id`,
      [req.body.name, req.body.country]
    );

    //res.json(eventsTable.rows[0]);
    admin.release();
    res.status(200).send("completed");
  } catch (err) {
    console.log(err);
    res.status(500).send(err);
  }
});

app.post("/addNewDeliveryPharmacy", checkAuthenticated, async (req, res) => {
  try {
    const admin = await pool.connect();
    const newDrugId = await admin.query(
      `INSERT INTO "Delivery_pharmacy" (city, name, address) VALUES ($1, $2, $3) RETURNING id`,
      [req.body.city, req.body.name, req.body.address]
    );

    //res.json(eventsTable.rows[0]);
    admin.release();
    res.status(200).send("completed");
  } catch (err) {
    console.log(err);
    res.status(500).send(err);
  }
});

app.post("/changeOldDrug", checkAuthenticated, async (req, res) => {
  try {
    const admin = await pool.connect();
    console.log(req.body.single_weight);
    const newDrugId = await admin.query(
      `UPDATE "Drug" set name=$1, price=$2, active_substance=$3, description=$4, release_form=$5, single_weight=$6, prescription=$7, category_id=$8, manufacturer_id=$9, in_stock=$10 where id = ${req.body.id}`,
      [
        req.body.name,
        req.body.price,
        req.body.active_substance,
        req.body.description,
        req.body.release_form,
        req.body.single_weight,
        req.body.prescription,
        req.body.category.id,
        req.body.manufacturer.id,
        req.body.in_stock
      ]
    );
    let pictDel = await admin.query(
      `delete from "Picture" where drug_id=${req.body.id}`
    );
    let newPictures = await Promise.all(
      req.body.pictures.map(async picture => {
        let pict = await admin.query(
          `INSERT INTO "Picture" (drug_id, path) VALUES ($1, $2) RETURNING *`,
          [req.body.id, picture]
        );
      })
    );
    //res.json(eventsTable.rows[0]);
    admin.release();
    res.status(200).send("completed");
  } catch (err) {
    console.log(err);
    res.status(500).send(err);
  }
});

app.post("/changeOldCategory", checkAuthenticated, async (req, res) => {
  try {
    const admin = await pool.connect();
    const newDrugId = await admin.query(
      `UPDATE "Category" set name=$1,parent=$2 where id = ${req.body.id}`,
      [req.body.name, req.body.category.id]
    );
    admin.release();
    res.status(200).send("completed");
  } catch (err) {
    console.log(err);
    res.status(500).send(err);
  }
});

app.post("/rollBack", checkAuthenticated, async (req, res) => {
  try {
    const admin = await pool.connect();
    const newDrugId = await admin.query(`select undoopers(${req.body.num})`);
    admin.release();
    res.status(200).send("completed");
  } catch (err) {
    console.log(err);
    res.status(500).send(err);
  }
});

app.post("/backup", checkAuthenticated, async (req, res) => {
  try {
    const dump_result = child_process.execSync(dump_command);
    console.log(dump_result.toString());

    res.status(200).send("completed");
  } catch (err) {
    console.log(err);
    res.status(500).send(err);
  }
});

app.post("/restore", checkAuthenticated, async (req, res) => {
  try {
    const restore_result = child_process.execSync(restore_command);
    console.log(restore_result.toString());
    res.status(200).send("completed");
  } catch (err) {
    console.log(err);
    res.status(500).send(err);
  }
});

app.post("/changeOldManufacturer", checkAuthenticated, async (req, res) => {
  try {
    const admin = await pool.connect();
    const newDrugId = await admin.query(
      `UPDATE "Manufacturer" set name=$1,country=$2 where id = ${req.body.id}`,
      [req.body.name, req.body.country]
    );
    admin.release();
    res.status(200).send("completed");
  } catch (err) {
    console.log(err);
    res.status(200).send("completed");
  }
});
app.post("/changeOldDeliveryPharmacy", checkAuthenticated, async (req, res) => {
  try {
    const admin = await pool.connect();
    const newDrugId = await admin.query(
      `UPDATE "Delivery_pharmacy" set city=$1,name=$2,address=$3 where id = ${req.body.id}`,
      [req.body.city, req.body.name, req.body.address]
    );
    admin.release();
    res.status(200).send("completed");
  } catch (err) {
    console.log(err);
    res.status(200).send("completed");
  }
});

app.post("/mngrdelete", checkAuthenticated, async (req, res) => {
  try {
    const admin = await pool.connect();
    if (req.body.table == "Drug")
      await admin.query(`delete from "Picture" where drug_id = ${req.body.id}`);
    const newDrugId = await admin.query(
      `delete from "${req.body.table}" where id = ${req.body.id}`
    );
    admin.release();
    res.status(200).send("completed");
  } catch (err) {
    console.log(err);
    res.status(500).send(err);
  }
});

app.post("/completeOrder", checkAuthenticated, async (req, res) => {
  try {
    console.log(
      `UPDATE "Order" SET  status = '${req.body.status}', manager_id = ${req.body.manager_id} WHERE  id = ${req.body.id}`
    );

    const user = await req.user;
    const admin = await pool.connect();
    const orderId = await admin.query(
      `UPDATE "Order" SET  status = '${req.body.status}', stockman_id = ${req.body.stockman_id} WHERE  id = ${req.body.id}`
    );
    const receiptId = await admin.query(
      `INSERT INTO "Receipt" (order_id, cash, payed, date_time) VALUES ($1, $2, $3, CURRENT_TIMESTAMP) RETURNING *`,
      [req.body.id, req.body.paymentType == "cash", req.body.payed]
    );

    //res.json(eventsTable.rows[0]);
    admin.release();
    res.status(200).send("completed");
  } catch (err) {
    console.log(err);
    res.status(500).send(err);
  }
});

app.post("/removeOrder", checkAuthenticated, async (req, res) => {
  try {
    const admin = await pool.connect();
    const orderId = await admin.query(
      `delete from "Order" where id = ${req.body.id};`
    );
    //res.json(eventsTable.rows[0]);
    admin.release();
    res.status(200).send("ordered");
  } catch (err) {
    console.log(err);
    res.status(500).send(err);
  }
});

app.delete("/logout", checkAuthenticated, (req, res) => {
  try {
    req.logOut();
    res.status(200).send("loggedOut");
  } catch (err) {
    res.send(500);
  }
  //res.redirect("/login");
});

function checkAuthenticated(req, res, next) {
  if (req.isAuthenticated()) {
    return next();
  }
  res.send("logged out");
}

async function checkNotAuthenticated(req, res, next) {
  if (req.isAuthenticated()) {
    return res.send(await req.user);
  }
  next();
}

app.listen(3003);
