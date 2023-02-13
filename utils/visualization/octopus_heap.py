
import dash
from dash import html, dcc
import plotly.graph_objects as go
from igraph import *

labels = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35,
    64,
    65,
    66,
    67,
    96,
    97,
    98,
    99,
    128,
    129,
    130,
    131,
    160,
    161,
    162,
    163,
    192,
    193,
    194,
    195,
    224,
    225,
    226,
    227,
    256,
    257,
    258,
    259,
    36,
    37,
    38,
    39,
    40,
    41,
    42,
    43,
    68,
    69,
    70,
    71,
    72,
    73,
    74,
    75,
    100,
    101,
    102,
    103,
    104,
    105,
    106,
    107,
    132,
    133,
    134,
    135,
    136,
    137,
    138,
    139,
    164,
    165,
    166,
    167,
    168,
    169,
    170,
    171,
    196,
    197,
    198,
    199,
    200,
    201,
    202,
    203,
    228,
    229,
    230,
    231,
    232,
    233,
    234,
    235,
    260,
    261,
    262,
    263,
    264,
    265,
    266,
    267,
    44,
    45,
    46,
    47,
    48,
    49,
    50,
    51,
    52,
    53,
    54,
    55,
    56,
    57,
    58,
    59,
    76,
    77,
    78,
    79,
    80,
    81,
    82,
    83,
    84,
    85,
    86,
    87,
    88,
    89,
    90,
    91,
    108,
    109,
    110,
    111,
    112,
    113,
    114,
    115,
    116,
    117,
    118,
    119,
    120,
    121,
    122,
    123,
    140,
    141,
    142,
    143,
    144,
    145,
    146,
    147,
    148,
    149,
    150,
    151,
    152,
    153,
    154,
    155,
    172,
    173,
    174,
    175,
    176,
    177,
    178,
    179,
    180,
    181,
    182,
    183,
    184,
    185,
    186,
    187,
    204,
    205,
    206,
    207,
    208,
    209,
    210,
    211,
    212,
    213,
    214,
    215,
    216,
    217,
    218,
    219,
    236,
    237,
    238,
    239,
    240,
    241,
    242,
    243,
    244,
    245,
    246,
    247,
    248,
    249,
    250,
    251,
    268,
    269,
    270,
    271,
    272,
    273,
    274,
    275,
    276,
    277,
    278,
    279,
    280,
    281,
    282,
    283,
    60,
]


def make_annotations(pos, text, font_size=10, font_color="rgb(250,250,250)"):
    L = len(pos)
    if len(text) != L:
        raise ValueError("The lists pos and text must have the same len")
    annotations = []
    for k in range(L):
        if 95 <= k and k <= 126 or 191 <= k and k <= 254:
            label = ""
        else:
            label = labels[k]
        annotations.append(
            dict(
                text=label,
                x=pos[k][0],
                y=2 * M - position[k][1],
                xref="x1",
                yref="y1",
                font=dict(color=font_color, size=font_size),
                showarrow=False,
            )
        )
    return annotations


def add_trace(fig, Xn, Yn, name, color):
    fig.add_trace(
        go.Scatter(
            x=Xn,
            y=Yn,
            mode="markers",
            name=name,
            marker=dict(
                symbol="circle-dot",
                size=18,
                color=color,
                line=dict(color="rgb(50,50,50)", width=1),
            ),
            text=labels,
            hoverinfo="text",
            opacity=0.8,
        ),
    )


if __name__ == "__main__":
    nr_vertices = 256
    D = 6

    g = Graph.Tree(nr_vertices, 2)
    lay = g.layout("rt", root=(0, 0))

    position = {k: lay[k] for k in range(nr_vertices)}
    root_x, root_y = position[0]
    for (k, (x, y)) in position.items():
        if x < root_x:
            position[k] = [x - (root_x - x) * D, y]

    Y = [lay[k][1] for k in range(nr_vertices)]
    M = max(Y)

    L = len(position)
    Xn = [position[k][0] for k in range(L)]
    Yn = [2 * M - position[k][1] for k in range(L)]
    Xe, Ye = [], []

    for edge in [e.tuple for e in g.es]:
        Xe += [position[edge[0]][0], position[edge[1]][0], None]
        Ye += [2 * M - position[edge[0]][1], 2 * M - position[edge[1]][1], None]

    fig = go.Figure()
    fig.add_trace(
        go.Scatter(
            x=Xe,
            y=Ye,
            mode="lines",
            line=dict(color="rgb(210,210,210)", width=1),
            hoverinfo="none",
        )
    )

    add_trace(fig, Xn, Yn, "", "#6175c1")

    add_trace(fig, Xn[:31], Yn[:31], "Head", "#25e014")
    add_trace(
        fig,
        Xn[31:35] + Xn[63:71] + Xn[127:143] + [Xn[-1]],
        Yn[31:35] + Yn[63:71] + Yn[127:143] + [Yn[-1]],
        "Leg1",
        "#282ffa",
    )
    add_trace(
        fig,
        Xn[35:39] + Xn[71:79] + Xn[143:159],
        Yn[35:39] + Yn[71:79] + Yn[143:159],
        "Leg2",
        "#f01aec",
    )
    add_trace(
        fig,
        Xn[39:43] + Xn[79:87] + Xn[159:175],
        Yn[39:43] + Yn[79:87] + Yn[159:175],
        "Leg3",
        "#ff0000",
    )
    add_trace(
        fig,
        Xn[43:47] + Xn[87:95] + Xn[175:191],
        Yn[43:47] + Yn[87:95] + Yn[175:191],
        "Leg4",
        "#0f0f0f",
    )

    axis = dict(showline=False, zeroline=False, showgrid=False, showticklabels=False,)

    fig.update_layout(
        title="Octopus Heap",
        annotations=make_annotations(position, labels),
        font_size=12,
        xaxis=axis,
        yaxis=axis,
        margin=dict(l=40, r=40, b=85, t=100),
        hovermode="closest",
        plot_bgcolor="rgb(248,248,248)",
    )

    app = dash.Dash()
    app.layout = html.Div([
        dcc.Graph(figure=fig ,style={'width': '100vw', 'height': '100vh'})
    ])

    app.run_server(debug=True, use_reloader=False, host="0.0.0.0")