

// To set the counterbalancing variable. Below is an example of four conditions (0, 1, 2, 3):

//var counterOverride = 0;
// var counterOverride = 1;
// var counterOverride = 2;
// var counterOverride = 3;

var shuffleSequence = seq("intro", rshuffle("practice"), "sep", rshuffle(rshuffle("stat_high", "percep_high", "stat_low", "percep_low"), rshuffle("filler", "FM")));
var practiceItemTypes = ["practice"];


var defaults = [
    "Separator", {
        transfer: 2000,
        normalMessage: "La session d'entraînement est terminée. L'expérience commencera dans quelques instants.",
        errorMessage: "La session d'entraînement est terminée. L'expérience commencera dans quelques instants."
    },
    "DashedSentence", {
        mode: "self-paced reading"
    },
    "AcceptabilityJudgment", {
        presentAsScale: false,
        instructions: "Utiliza las teclas de los números 1 y 2 para contestar.",
        leftComment: "(Bad)", rightComment: "(Good)"
    },
    "Question", {
        hasCorrect: true
    },
    "Message", {
        hideProgressBar: true
    },
    "Form", {
        showProgressBar: false,
        continueOnReturn: true,
        saveReactionTime: true,
    },

"completion", {

        saveReactionTime: true,
    }
];

var items = [



    ["sep", "Separator", { }],
["setcounter", "__SetCounter__", { }],

    ["intro", "completion", {
        html: { include: "intro.html" },
        validators: {
            age: function (s) { if (s.match(/^\d+$/)) return true; else return "Bad value for \u2018age\u2019"; }
        }
    } ],


    [["practice",    102    ], "completion", { html:  '   La boulangerie est fermé le <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
    [["practice",    103    ], "completion", { html:  '   Les pommes vertes sont <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
    [["practice",    101    ], "completion", { html:  '   Les soldats partent à la guerre sans <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
    [["practice",    31    ], "completion", { html:  '    8+72-4 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],                            
    [["practice",    32    ], "completion", { html:  '    90-54+6+1 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],                            
    [["practice",    33    ], "completion", { html:  '    3+(4-2)+23 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],                            
    [["practice",    34    ], "completion", { html:  '    10-5+22-10 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],                            
    [["practice",    35    ], "completion", { html:  '    30-(1+1)-7 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],  


[["FM",    31    ], "completion", { html:  '    7+10-4 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["FM",    32    ], "completion", { html:  '    11-2+6-3 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["FM",    33    ], "completion", { html:  '    27-(8+1)-9 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["FM",    34    ], "completion", { html:  '    73-50+5=    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["FM",    35    ], "completion", { html:  '    3+8-7=    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["FM",    36    ], "completion", { html:  '    13+(20-1)-8 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["FM",    37    ], "completion", { html:  '    6-4+5 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["FM",    38    ], "completion", { html:  '    17+11-7 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["FM",    39    ], "completion", { html:  '    15+7+3 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["FM",    40    ], "completion", { html:  '    16-7+6 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["FM",    41    ], "completion", { html:  '    8*7+6 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["FM",    42    ], "completion", { html:  '    14-5+6 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["FM",    43    ], "completion", { html:  '    87-5*6 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["FM",    44    ], "completion", { html:  '    25-8/2 =    <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["filler",    60    ], "completion", { html:  '    Le moniteur de kayak prépare <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["filler",    61    ], "completion", { html:  '    La pétanque est un sport de <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["filler",    62    ], "completion", { html:  '    Le rock est <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["filler",    63    ], "completion", { html:  '    Hier, tu as commandé des <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["filler",    64    ], "completion", { html:  '    Demain, je vais au <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["filler",    65    ], "completion", { html:  '    Maintenant, le musicien commence <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["filler",    66    ], "completion", { html:  '    Malheureusement, le conseiller dénigre <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["filler",    67    ], "completion", { html:  '    Les pilotes suivent <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["filler",    68    ], "completion", { html:  '    Les pompiers se préparent pour <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["filler",    69    ], "completion", { html:  '    Les sportifs vont <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["filler",    70    ], "completion", { html:  '    La mode est de plus en plus <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["filler",    71    ], "completion", { html:  '    Ce thé a un goût <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["filler",    72    ], "completion", { html:  '    Maintenant, les téléphones <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],
[["filler",    73    ], "completion", { html:  '    Tes oreillettes sont bizarrement <input name="in" type="text" size="60" class="obligatory"  /> . '}    ],




];


      var MAX_PARTICIPANTS = 40;
function modifyRunningOrder(ro) {
    if (__counter_value_from_server__ >= MAX_PARTICIPANTS) {
             alert("Cette partie de l'expérience est terminée (déjà assez de participants). Merci de cliquer sur le lien suivant. Merci!");
      document.write('<div style="width:40em;text-align:center"> <p> <a href="http://spellout.net/ibexexps/chevaleret/ContJust4_b/experiment.html"> Cliquez ici svp pour la Partie II </a> </p>');
   //  document.write('<div style="width:40em;text-align:center"> <p> <a href="http://spellout.net/ibexexps/chevaleret/ContJust4_c/experiment.html">Cliquez ici svp pour la Partie III </a> </p>');
    // document.write('<div style="width:40em;text-align:center"> <p> <a href="http://spellout.net/ibexexps/chevaleret/ContJust4_d/experiment.html"> Cliquez ici svp pour la Partie IV </a> </p>');
        // alert("Cette expérience est terminée. Merci.");
        throw "";
    }
    else {
        return ro;
    }
}
