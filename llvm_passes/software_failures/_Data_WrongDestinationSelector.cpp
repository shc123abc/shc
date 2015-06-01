#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Support/CFG.h"
#include "llvm/ADT/DepthFirstIterator.h"
#include "llvm/ADT/GraphTraits.h"
#include "llvm/IR/Instructions.h"

#include "FIInstSelector.h"
#include "FICustomSelectorManager.h"
#include "_SoftwareFaultRegSelectors.h"

#include <fstream>
#include <iostream>
#include <set>
#include <string>
/**
 * This instruction selector only selects the API call functions as target
 */

using namespace llvm;
namespace llfi{
    class _Data_WrongDestinationInstSelector: public SoftwareFIInstSelector{
        public:
            _Data_WrongDestinationInstSelector(){
                funcNames.insert(std::string("memcpy"));
                funcNames.insert(std::string("memmove"));
                funcNames.insert(std::string("memcmp"));
            }
            virtual void getCompileTimeInfo(std::map<std::string, std::string>& info){
                info["failure_class"] = "Data";
                info["failure_mode"] = "WrongDestination";
                for(std::set<std::string>::iterator SI = funcNames.begin();
                  SI != funcNames.end(); SI++){
                  info["targets"] += *SI + "()/";
                }
                //remove the '/' at the end
                info["targets"] = info["targets"].substr(0, info["targets"].length()-1);
                info["injector"] = "BitCorruptionInjector";
            }

        private:
            std::set<std::string> funcNames;

        virtual bool isInstFITarget(Instruction* inst){
            if(isa<CallInst>(inst) == false)    return false;
            else{
                CallInst* CI = dyn_cast<CallInst>(inst);
                Function* called_func = CI->getCalledFunction();
                if(called_func == NULL) return false;
                std::string func_name = std::string(called_func->getName());
                for(std::set<std::string>::iterator SI = funcNames.begin(); SI != funcNames.end(); SI++){
                	if(func_name.find(*SI) != std::string::npos)	return true;
                }
                return false;
            }
        }
    };
    static RegisterFIInstSelector A( "WrongDestination(Data)", new _Data_WrongDestinationInstSelector());
    static RegisterFIRegSelector B("WrongDestination(Data)", new FuncArgRegSelector(0));
}
