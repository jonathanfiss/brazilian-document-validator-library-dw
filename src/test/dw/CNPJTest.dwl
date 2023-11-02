%dw 2.0
import * from dw::test::Tests
import * from dw::test::Asserts

import * from CNPJ
---
"CNPJ" describedBy [
    "cnpjNumberSequence" describedBy [
        "It should validate if the number is a sequential number" in do {
            cnpjNumberSequence("99999999999999") must equalTo(true)
        },
        "It should validate that the number is not a sequential number" in do {
            cnpjNumberSequence("19999981000150") must equalTo(false)
        },
    ],
    "isValidCNPJ" describedBy [
        "It should validate that it is a valid CNPJ" in do {
            isValidCNPJ("19999981000150") must equalTo(true)
        },
        "It should validate that it is a invalid CNPJ" in do {
            isValidCNPJ("19999981000250") must equalTo(false)
        },
    ],
    "isCNPJ" describedBy [
        "It should validate the string size" in do {
            isCNPJ("199999810001") must [
                                            beObject(),
                                            $.valid is false,
                                            $.message is "CNPJ possui tamanho diferente de 14"
                                        ]
        },
        "It should validate if the number is a sequential number" in do {
            isCNPJ("33333333333333") must [
                                            beObject(),
                                            $.valid is false,
                                            $.message is "Numeros sequenciais"
                                        ]
        },
        "It should validate whether the CNPJ is invalid" in do {
            isCNPJ("19999981000250") must [
                                            beObject(),
                                            $.valid is false,
                                            $.message is "CNPJ inválido"
                                        ]
        },
        "It should validate whether the CNPJ is valid" in do {
            isCNPJ("19999981000150") must [
                                            beObject(),
                                            $.valid is true,
                                            $.message is "CNPJ válido"
                                        ]
        },
    ],
]
