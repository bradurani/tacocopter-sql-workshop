# tacocopter-sql-workshop

<h3>Using SQL Fiddle</h3>

Visit <a href='http://sqlfiddle.com'>http://sqlfiddle.com</a>

Switch to Postgres 9.3:<br/>
<img src="https://github.com/bradurani/tacocopter-sql-workshop/blob/master/images/switch_to_postgres.png"/>
<br/>
<br/>
In a different tab open <a href="https://raw.githubusercontent.com/bradurani/tacocopter-sql-workshop/master/tacocopter.sql"/>https://raw.githubusercontent.com/bradurani/tacocopter-sql-workshop/master/tacocopter.sql</a>
<br/>
Select the entire contents of this file, copy it and paste it into the schema panel in SQL Fiddle:<br/>
<img src="https://github.com/bradurani/tacocopter-sql-workshop/blob/master/images/paste_sql.png"/>
<br/>
<br/>
press the 'Build Schema' button. You should see a <code>schema ready</code> message. You are now ready to start writting SQL in the "Run SQL" pane.

<h3>Using psql</h3>
ssh into your ude and clone the repo into the user directory<br/>

```
cd ~/
git clone git@github.com:bradurani/tacocopter-sql-workshop.git
```

From inside the tacocopter directory, open psql:
```
cd ~/tacocopter-sql-workshop
psql -U postgres
```
In the psql terminal, run these 4 lines <i>separately</i>:
```
\c postgres
DROP DATABASE IF EXISTS tacocopter;
CREATE DATABASE tacocopter;
\c tacocopter
```
Your prompt should now be `tacocopter=#`<br/>
Run the following command to build the schema:
```
\i tacocopter.sql
```
You are now ready to start querying.
<br/><br/>
To run SQL from a text editor, create a test SQL file in the tacocopter directory:
```
cd ~/tacocopter-sql-workshop
touch test.sql
```
Open the `test.sql` file in your favorite code editor. Add the line:
```
SELECT * FROM stores;
```
Don't forget the semi-colon ;)<br>
Switch back to the psql terminal and enter:
```
\i test.sql
```
Your query should run!
