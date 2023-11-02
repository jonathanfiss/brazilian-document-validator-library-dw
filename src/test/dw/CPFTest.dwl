%dw 2.0
import * from dw::test::Tests
import * from dw::test::Asserts

import * from CPF
---
"CPF" describedBy [
    "cpfNumberSequence" describedBy [
        "It should validate if the number is a sequential number" in do {
            cpfNumberSequence("99999999999") must equalTo(true)
        },
        "It should validate that the number is not a sequential number" in do {
            cpfNumberSequence("19999981000") must equalTo(false)
        },
    ],
    "isValidCPF" describedBy [
        "It should validate that it is a valid CPF" in do {
            isValidCPF("15772321005") must equalTo(true)
        },
        "It should validate that it is a invalid CPF" in do {
            isValidCPF("15772321003") must equalTo(false)
        },
    ],
    "isCPF" describedBy [
        "It should validate the string size" in do {
            isCPF("1577232100") must [
                                            beObject(),
                                            $.valid is false,
                                            $.message is "CPF possui tamanho diferente de 11"
                                        ]
        },
        "It should validate if the number is a sequential number" in do {
            isCPF("33333333333") must [
                                            beObject(),
                                            $.valid is false,
                                            $.message is "Numeros sequenciais"
                                        ]
        },
        "It should validate whether the CPF is invalid" in do {
            isCPF("15772321002") must [
                                            beObject(),
                                            $.valid is false,
                                            $.message is "CPF inválido"
                                        ]
        },
        "It should validate whether the CPF is valid" in do {
            isCPF("15772321005") must [
                                            beObject(),
                                            $.valid is true,
                                            $.message is "CPF válido"
                                        ]
        },
    ],
]
