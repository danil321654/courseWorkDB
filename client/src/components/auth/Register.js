import React, {useState, useEffect} from "react";

import {connect} from "react-redux";
import {register} from "../../actions/register";

import {BrowserRouter, Route, Redirect} from "react-router-dom";
import Login from "./Login";
import {createUseStyles} from "react-jss";

const useStyles = createUseStyles({
  loginGrid: {
    display: "grid",
    gridTemplateColumns: "200px max-content",
    gridGap: "20px"
  }
});
const Register = ({auth, register}) => {
  const classes = useStyles();
  const [surname, setSurname] = useState("qq");
  const [name, setName] = useState("qq");
  const [patronymic, setPatronymic] = useState("qq");

  const [year, setYear] = useState(2000);

  const [login, setLogin] = useState("test1");
  const [email, setEmail] = useState("t@t");
  const [password, setPassword] = useState("t");

  const [phone, setPhone] = useState("1234567890");

  useEffect(() => {
    if (auth.isAuthenticated) {
    }
  }, []);

  const onSubmit = e => {
    e.preventDefault();
    console.log({
      surname,
      name,
      patronymic,
      year,
      login,
      email,
      password,
      phone
    });
    register({surname, name, patronymic, year, login, email, password, phone});
  };

  return (
    <React.Fragment>
      {auth.regError == "registered" && (
        <Redirect to="/login" component={Login} />
      )}
      <h1>Register</h1>
      <h1>{auth.regError}</h1>
      <form action="/register" method="POST" onSubmit={onSubmit}>
        <div className={classes.loginGrid}>
          <label htmlFor="surname">Surname</label>
          <input
            type="text"
            id="surname"
            name="surname"
            value={surname}
            onChange={e => setSurname(e.target.value)}
            required
          />
        </div>
        <div className={classes.loginGrid}>
          <label htmlFor="name">Name</label>
          <input
            type="text"
            id="name"
            name="name"
            value={name}
            onChange={e => setName(e.target.value)}
            required
          />
        </div>

        <div className={classes.loginGrid}>
          <label htmlFor="patronymic">Patronymic</label>
          <input
            type="text"
            id="patronymic"
            name="patronymic"
            value={patronymic}
            onChange={e => setPatronymic(e.target.value)}
          />
        </div>

        <div className={classes.loginGrid}>
          <label htmlFor="year">Year</label>
          <input
            type="number"
            min="1900"
            max="2002"
            step="1"
            id="year"
            name="year"
            value={year}
            onChange={e => setYear(e.target.value)}
            required
          />
        </div>
        <div className={classes.loginGrid}>
          <label htmlFor="login">Login</label>
          <input
            type="text"
            id="login"
            name="login"
            pattern="^(?=.*[A-Za-z0-9]$)[A-Za-z][A-Za-z\d.-]{0,19}$"
            value={login}
            onChange={e => setLogin(e.target.value)}
            required
          />
        </div>
        <div className={classes.loginGrid}>
          <label htmlFor="email">Email</label>
          <input
            type="email"
            id="email"
            name="email"
            value={email}
            onChange={e => setEmail(e.target.value)}
            required
          />
        </div>
        <div className={classes.loginGrid}>
          <label htmlFor="password">Password</label>
          <input
            type="password"
            id="password"
            name="password"
            value={password}
            onChange={e => setPassword(e.target.value)}
            required
          />
        </div>

        <div className={classes.loginGrid}>
          <label htmlFor="phone">Phone</label>
          <input
            type="tel"
            id="phone"
            name="phone"
            pattern="[0-9]{10}"
            value={phone}
            onChange={e => setPhone(e.target.value)}
            required
          />
        </div>

        <button type="submit">Register</button>
      </form>

      <a href="/login">Login</a>
    </React.Fragment>
  );
};

const mapStateToProps = state => ({auth: state.auth});

export default connect(mapStateToProps, {register})(Register);
