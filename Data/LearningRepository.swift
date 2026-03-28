//
//  LearningRepository.swift
//  Simply
//
//  Created by Rishi Shah on 04/02/26.
//


import Foundation

struct LearningRepository {
    
    static let all: [LearningTerm] = [

        // TECH TERMS
        LearningTerm(
            id: "cloud",
            title: "Cloud Storage",
            domain: .tech,
            pronunciation: "kl-ow-d",
            meaning: "Online storage for your files",
            explanation:
                "The cloud stores your photos and documents on the internet instead of your phone.",

            visualAsset: "cloud_storage",

            example:
                "My photos are saved in the internet data servers just like we store books in a library, ordered and section wise",

            quiz: [

                QuizQuestion(
                    question: "Where are files stored in the cloud?",
                    options: [
                        QuizOption(text: "On SIM card"),
                        QuizOption(text: "On internet servers"),
                        QuizOption(text: "Only on phone")
                    ],
                    correctIndex: 1
                )
            ]
        ),
        
        LearningTerm(
            id: "ai",
            title: "Artificial Intelligence",
            domain: .tech,
            pronunciation: "ar-ti-fi-shul in-tel-i-jens",
            meaning: "Machines that can think and learn like humans",
            explanation: "AI allows computers to recognize patterns, understand language, and make decisions.",
            visualAsset: "ai_explain",
            example: "AI is like a super-smart computer brain that learns from examples, just like you learn from practice and experience.",
            quiz: [
                QuizQuestion(
                    question: "What does AI help computers do?",
                    options: [
                        QuizOption(text: "Think and learn"),
                        QuizOption(text: "Cook food"),
                        QuizOption(text: "Charge batteries")
                    ],
                    correctIndex: 0
                )
            ]
        ),
        
        LearningTerm(
            id: "genai",
            title: "Generative AI",
            domain: .tech,
            pronunciation: "jen-er-uh-tiv ai",
            meaning: "AI that creates new content",
            explanation: "Generative AI can create text, images, music, and more.",
            visualAsset: "generative_ai",
            example: "Generative AI is like a magic drawing and storytelling robot.",
            quiz: [
                QuizQuestion(
                    question: "What does Generative AI do?",
                    options: [
                        QuizOption(text: "Deletes files"),
                        QuizOption(text: "Creates new content"),
                        QuizOption(text: "Speeds up internet")
                    ],
                    correctIndex: 1
                )
            ]
        ),
        
        LearningTerm(
            id: "ml",
            title: "Machine Learning",
            domain: .tech,
            pronunciation: "muh-sheen ler-ning",
            meaning: "AI that learns from data",
            explanation: "Machine learning improves automatically by analyzing patterns in data.",
            visualAsset: "machine_learning",
            example: "Computer learns by itself from examples. It’s like teaching a puppy tricks — you show it many times, and it slowly figures out what to do on its own.",
            quiz: [
                QuizQuestion(
                    question: "Machine learning learns from?",
                    options: [
                        QuizOption(text: "Data"),
                        QuizOption(text: "Water"),
                        QuizOption(text: "Air")
                    ],
                    correctIndex: 0
                )
            ]
        ),
        
//        LearningTerm(
//            id: "encryption",
//            title: "Encryption",
//            domain: .tech,
//            pronunciation: "en-krip-shun",
//            meaning: "Protecting data by turning it into secret code",
//            explanation: "Encryption keeps your messages and passwords secure.",
//            visualAsset: "encryption_lock",
//            example: "Encryption is like turning your message into a secret code so no one else can read it. Only the person with the special key can unlock it and see the real message. ",
//            quiz: [
//                QuizQuestion(
//                    question: "Why is encryption used?",
//                    options: [
//                        QuizOption(text: "To protect data"),
//                        QuizOption(text: "To decorate apps"),
//                        QuizOption(text: "To delete data")
//                    ],
//                    correctIndex: 0
//                )
//            ]
//        ),
//        
        LearningTerm(
            id: "llm",
            title: "LLM",
            domain: .tech,
            pronunciation: "el-el-em",
            meaning: "Large Language Model",
            explanation: "An LLM is an AI trained on massive text data to understand and generate language.",
            visualAsset: "llm",
            example: "LLM is like an encylopedia that has read everything, and when you ask something it answers it in it's own words",
            quiz: [
                QuizQuestion(
                    question: "LLM stands for?",
                    options: [
                        QuizOption(text: "Large Language Model"),
                        QuizOption(text: "Low Level Machine"),
                        QuizOption(text: "Long Learning Mode")
                    ],
                    correctIndex: 0
                )
            ]
        ),
        
//        LearningTerm(
//            id: "vibecoding",
//            title: "Vibecoding",
//            domain: .tech,
//            pronunciation: "vyb-koh-ding",
//            meaning: "Coding by describing ideas to AI",
//            explanation: "Instead of writing all code manually, developers describe what they want and AI helps generate it.",
//            visualAsset: "vibecoding_ai",
//            example: "He vibecoded his app using AI tools.",
//            quiz: [
//                QuizQuestion(
//                    question: "Vibecoding involves?",
//                    options: [
//                        QuizOption(text: "Manual typing only"),
//                        QuizOption(text: "Using AI to generate code"),
//                        QuizOption(text: "Deleting code")
//                    ],
//                    correctIndex: 1
//                )
//            ]
//        ),
//        
//        LearningTerm(
//            id: "cookies",
//            title: "Cookies",
//            domain: .tech,
//            pronunciation: "ku-keys",
//            meaning: "Small files websites save on your device",
//            explanation: "Cookies remember login details and preferences.",
//            visualAsset: "cookies_web",
//            example: "Cookies keep me logged into my account, like you have the key to your house always which you can access anytime",
//            quiz: [
//                QuizQuestion(
//                    question: "Cookies help websites?",
//                    options: [
//                        QuizOption(text: "Bake food"),
//                        QuizOption(text: "Remember preferences"),
//                        QuizOption(text: "Delete accounts")
//                    ],
//                    correctIndex: 1
//                )
//            ]
//        ),
//        
//        LearningTerm(
//            id: "vr",
//            title: "Virtual Reality",
//            domain: .tech,
//            pronunciation: "vur-chu-ul ree-al-i-tee",
//            meaning: "A computer-generated 3D world",
//            explanation: "VR uses headsets to create immersive digital experiences.",
//            visualAsset: "vr_headset",
//            example: "VR lets you explore virtual worlds.",
//            quiz: [
//                QuizQuestion(
//                    question: "VR creates?",
//                    options: [
//                        QuizOption(text: "Physical buildings"),
//                        QuizOption(text: "Virtual 3D worlds"),
//                        QuizOption(text: "Paper books")
//                    ],
//                    correctIndex: 1
//                )
//            ]
//        ),
//        
//        LearningTerm(
//            id: "cybersecurity",
//            title: "Cybersecurity",
//            domain: .tech,
//            pronunciation: "sy-ber si-kyur-i-tee",
//            meaning: "Protecting systems and data from attacks",
//            explanation: "Cybersecurity prevents hacking and data theft.",
//            visualAsset: "cyber_shield",
//            example: "Strong passwords improve cybersecurity.",
//            quiz: [
//                QuizQuestion(
//                    question: "Cybersecurity protects against?",
//                    options: [
//                        QuizOption(text: "Rain"),
//                        QuizOption(text: "Cyber attacks"),
//                        QuizOption(text: "Sunlight")
//                    ],
//                    correctIndex: 1
//                )
//            ]
//        ),

        // GEN-Z TERMS
        LearningTerm(
            id: "sus",
            title: "Sus",
            domain: .genz,
            pronunciation: "suhs",
            meaning: "Suspicious or strange",

            explanation:
                "Used when something feels weird or untrustworthy.",

            visualAsset: "sus",

            example:
                "That story sounds sus.",

            quiz: [

                QuizQuestion(
                    question: "What does 'sus' usually mean?",
                    options: [
                        QuizOption(text: "Funny"),
                        QuizOption(text: "Happy"),
                        QuizOption(text: "Suspicious")
                    ],
                    correctIndex: 2
                )
            ]
        ),


        LearningTerm(
            id: "slay",
            title: "Slay",
            domain: .genz,
            pronunciation: "slay",

            meaning: "Doing something very well",

            explanation:
                "Used to praise someone who looks good or did great.",

            visualAsset: "slay",

            example:
                "You slayed that presentation!",

            quiz: [

                QuizQuestion(
                    question: "When do people say 'slay'?",
                    options: [
                        QuizOption(text: "When someone does well"),
                        QuizOption(text: "When someone fails"),
                        QuizOption(text: "When tired")
                    ],
                    correctIndex: 0
                )
            ]
        ),
        
        LearningTerm(
            id: "vibe",
            title: "Vibe",
            domain: .genz,
            pronunciation: "vyb",
            meaning: "The feeling or mood of something",
            explanation: "Used to describe the atmosphere or energy of a place or person.",
            visualAsset: "vibe",
            example: "This cafe has a chill vibe.",
            quiz: [
                QuizQuestion(
                    question: "Vibe refers to?",
                    options: [
                        QuizOption(text: "Temperature"),
                        QuizOption(text: "Mood or feeling"),
                        QuizOption(text: "Noise level")
                    ],
                    correctIndex: 1
                )
            ]
        ),
        
        LearningTerm(
            id: "nocap",
            title: "No Cap",
            domain: .genz,
            pronunciation: "noh kap",
            meaning: "Not lying / being honest",
            explanation: "Used to emphasize that you're telling the truth.",
            visualAsset: "nocap",
            example: "That movie was amazing, no cap.",
            quiz: [
                QuizQuestion(
                    question: "'No cap' means?",
                    options: [
                        QuizOption(text: "Not lying"),
                        QuizOption(text: "Wearing no hat"),
                        QuizOption(text: "Being angry")
                    ],
                    correctIndex: 0
                )
            ]
        ),
        
        LearningTerm(
            id: "drip",
            title: "Drip",
            domain: .genz,
            pronunciation: "drip",
            meaning: "Stylish outfit or fashion sense",
            explanation: "Used to compliment someone’s fashionable or trendy look.",
            visualAsset: "drip",
            example: "That jacket is pure drip.",
            quiz: [
                QuizQuestion(
                    question: "'Drip' refers to?",
                    options: [
                        QuizOption(text: "Water leaking"),
                        QuizOption(text: "Fast running"),
                        QuizOption(text: "Stylish fashion"),
                    ],
                    correctIndex: 2
                )
            ]
        ),

        
//        LearningTerm(
//            id: "rizz",
//            title: "Rizz",
//            domain: .genz,
//            pronunciation: "riz",
//            meaning: "Charm or flirting ability",
//            explanation: "Used to describe someone's ability to attract others.",
//            visualAsset: "rizz_charm",
//            example: "He has serious rizz.",
//            quiz: [
//                QuizQuestion(
//                    question: "Rizz is about?",
//                    options: [
//                        QuizOption(text: "Cooking"),
//                        QuizOption(text: "Charm"),
//                        QuizOption(text: "Sports")
//                    ],
//                    correctIndex: 1
//                )
//            ]
//        ),
//        
//        LearningTerm(
//            id: "aura",
//            title: "Aura",
//            domain: .genz,
//            pronunciation: "aw-rah",
//            meaning: "Someone’s overall vibe or energy",
//            explanation: "Used to describe the energy or presence someone gives off — confident, calm, mysterious, etc.",
//            visualAsset: "aura_glow",
//            example: "She walked in with such a powerful aura.",
//            quiz: [
//                QuizQuestion(
//                    question: "What does 'aura' usually describe?",
//                    options: [
//                        QuizOption(text: "Clothing brand"),
//                        QuizOption(text: "Energy or presence"),
//                        QuizOption(text: "Phone battery")
//                    ],
//                    correctIndex: 1
//                )
//            ]
//        ),
//        
//        LearningTerm(
//            id: "delulu",
//            title: "Delulu",
//            domain: .genz,
//            pronunciation: "de-loo-loo",
//            meaning: "Delusional in a funny way",
//            explanation: "Used playfully when someone has unrealistic beliefs, often about romance or success.",
//            visualAsset: "delulu_dream",
//            example: "I think he likes me — I might be delulu though.",
//            quiz: [
//                QuizQuestion(
//                    question: "'Delulu' is short for?",
//                    options: [
//                        QuizOption(text: "Delicious"),
//                        QuizOption(text: "Delusional"),
//                        QuizOption(text: "Delicate")
//                    ],
//                    correctIndex: 1
//                )
//            ]
//        ),
//        
//        LearningTerm(
//            id: "tea",
//            title: "Tea",
//            domain: .genz,
//            pronunciation: "tee",
//            meaning: "Gossip or interesting information",
//            explanation: "Spilling the tea means sharing gossip or juicy news.",
//            visualAsset: "tea_gossip",
//            example: "Tell me the tea about what happened!",
//            quiz: [
//                QuizQuestion(
//                    question: "If someone says 'spill the tea', they mean?",
//                    options: [
//                        QuizOption(text: "Drop a drink"),
//                        QuizOption(text: "Share gossip"),
//                        QuizOption(text: "Make tea")
//                    ],
//                    correctIndex: 1
//                )
//            ]
//        ),
//        
//        LearningTerm(
//            id: "bruh",
//            title: "Bruh",
//            domain: .genz,
//            pronunciation: "bruh",
//            meaning: "Expression of disbelief or frustration",
//            explanation: "Used when something surprising, silly, or annoying happens.",
//            visualAsset: "bruh_face",
//            example: "Bruh, did that really just happen?",
//            quiz: [
//                QuizQuestion(
//                    question: "'Bruh' is often used to show?",
//                    options: [
//                        QuizOption(text: "Excitement"),
//                        QuizOption(text: "Disbelief or frustration"),
//                        QuizOption(text: "Hunger")
//                    ],
//                    correctIndex: 1
//                )
//            ]
//        )

    ]
}


extension LearningRepository {

    static func terms(for domain: LearningDomain) -> [LearningTerm] {
        all.filter { $0.domain == domain }
    }

    static func term(by id: String) -> LearningTerm? {
        all.first { $0.id == id }
    }
}
