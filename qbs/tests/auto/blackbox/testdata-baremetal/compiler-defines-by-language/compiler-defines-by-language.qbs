import "../BareMetalApplication.qbs" as BareMetalApplication

Project {
    property bool supportsCpp: {
        if (qbs.toolchain.contains("cosmic"))
            return false;
        if (qbs.toolchain.contains("sdcc"))
            return false;
        if (qbs.toolchain.contains("keil")) {
            if (qbs.architecture === "mcs51"
                    || qbs.architecture === "mcs251"
                    || qbs.architecture === "c166") {
                return false;
            }
        }
        return true;
    }

    BareMetalApplication {
        name: "c_language"
        files: ["app.c", "ctest.c"]
        cpp.enableCompilerDefinesByLanguage: []
        property var foo: {
            if (!cpp.compilerDefinesByLanguage)
                throw "ASSERT cpp.compilerDefinesByLanguage: "
                        + cpp.compilerDefinesByLanguage;
            if (!cpp.compilerDefinesByLanguage["c"])
                throw "ASSERT cpp.compilerDefinesByLanguage[\"c\"]: "
                        + cpp.compilerDefinesByLanguage["c"];
            if (cpp.compilerDefinesByLanguage["cpp"])
                throw "ASSERT !cpp.compilerDefinesByLanguage[\"cpp\"]: "
                        + cpp.compilerDefinesByLanguage["cpp"];
        }
    }

    BareMetalApplication {
        condition: supportsCpp
        name: "cpp_language"
        files: ["app.c", "cpptest.cpp"]
        cpp.enableCompilerDefinesByLanguage: ["cpp"]
        property var foo: {
            if (!cpp.compilerDefinesByLanguage)
                throw "ASSERT cpp.compilerDefinesByLanguage: "
                        + cpp.compilerDefinesByLanguage;
            if (cpp.compilerDefinesByLanguage["c"])
                throw "ASSERT !cpp.compilerDefinesByLanguage[\"c\"]: "
                        + cpp.compilerDefinesByLanguage["c"];
            if (!cpp.compilerDefinesByLanguage["cpp"])
                throw "ASSERT cpp.compilerDefinesByLanguage[\"cpp\"]: "
                        + cpp.compilerDefinesByLanguage["cpp"];
        }
    }

    BareMetalApplication {
        condition: supportsCpp
        name: "c_and_cpp_language"
        files: ["app.c", "ctest.c", "cpptest.cpp"]
        cpp.enableCompilerDefinesByLanguage: ["c", "cpp"]
        property var foo: {
            if (!cpp.compilerDefinesByLanguage)
                throw "ASSERT cpp.compilerDefinesByLanguage: "
                        + cpp.compilerDefinesByLanguage;
            if (!cpp.compilerDefinesByLanguage["c"])
                throw "ASSERT cpp.compilerDefinesByLanguage[\"c\"]: "
                        + cpp.compilerDefinesByLanguage["c"];
            if (!cpp.compilerDefinesByLanguage["cpp"])
                throw "ASSERT cpp.compilerDefinesByLanguage[\"cpp\"]: "
                        + cpp.compilerDefinesByLanguage["cpp"];
        }
    }
}
