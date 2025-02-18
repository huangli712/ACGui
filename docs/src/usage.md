# Usage

It is quite easy to use `ACGui`.

---

## Launch ACGui

Suppose that the `ACGui` is placed in the folder `/home/your_home/acgui`, then we should execute the following command in the terminal to launch the server side of `ACGui`:

```shell
$ pwd
/home/your_home/acgui
$ ./util/acg.jl
[ Info: Listening on: 127.0.0.1:8848, thread id: 1
```

Next, we can use any favourite web browsers (such as Chrome, Edge, or Firefox) to open the following URL:

```text
http://127.0.0.1:8848
```

This is the client side of `ACGui`.

---

## Prepare input data

* Select the `Data` tab.
* Click `Drag and Drop or Select Files`.
* Choose a appropriate file that contains the necessary data.
* Click `Open` in the pop-up dialogue box.

![data.png](./assets/data.png)

**Figure 1 |** The `Data` tab in `ACGui`. 

---

## General setup

* Select the `General` tab.
* Fix filename for input data by `finput`.
* Choose suitable analytic continuation solver by `solver`.
* Fix other parameters.

![general.png](./assets/general.png)

**Figure 2 |** The `General` tab in `ACGui`.

---

## Analytic continuation solver

* Select the `Solver` tab.
* Customize the parameters for the solver. 

![solver.png](./assets/solver.png)

**Figure 3 |** The `Solver` tab in `ACGui`.

---

## Run

![run.png](./assets/run.png)

**Figure 4 |** The `Run` tab in `ACGui`.
