from pathlib import Path
import matplotlib.pyplot as plt

here = Path(__file__).parent

xaxis = (
    "Deshima2\n(Original PyCleWin)",
    "ToyDESHIMA2\n(RAIMAD)",
    "MEGADESHIMA\n(RAIMAD)"
    )
yaxis = (140.39, 7.43, 30.39)

fig, ax = plt.subplots()
ax.bar(xaxis[:2], yaxis[:2])
ax.set_ylabel("Wall time [seconds]")
fig.savefig(here / "speed.svg")


fig, ax = plt.subplots()
ax.bar(xaxis[:3], yaxis[:3])
ax.set_ylabel("Wall time [seconds]")
fig.savefig(here / "speed2.svg")

