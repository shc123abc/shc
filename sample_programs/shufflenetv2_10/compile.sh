printf "\n[Compile Script]: Convert TF model to LLVM IR\n"
onnx-mlir --EmitLLVMIR  --instrument-onnx-ops="ALL" --InstrumentBeforeOp --InstrumentAfterOp $1.onnx
mlir-translate -mlir-to-llvmir $1.onnx.mlir > model.mlir.ll

printf "\n[Compile Script]: Compile main driver program and link to TF model in LLVM IR\n"
clang++ -DONNX_ML=1 image.c -o main.ll -O0 -S -emit-llvm -lonnx_proto -lprotobuf -I$ONNX_MLIR_SRC/include 
llvm-link -o model.ll -S main.ll model.mlir.ll

printf "\n[Compile Script]: Generate model.exe \n"
/home/llvm-project/build/bin/llc -filetype=obj -o model.o model.ll -O0 --relocation-model=pic
clang++ -o model.exe model.o -L/home/LLTFI/LLTFI/build/bin/../runtime_lib -lllfi-rt -lpthread -L /Debug/lib -Wl,-rpath /home/LLTFI/LLTFI/build/bin/../runtime_lib -I$ONNX_MLIR_SRC/include -O0 -lonnx_proto -lprotobuf -lcruntime -ljson-c

printf "\n[Compile Script]: Compilation complete\n"
