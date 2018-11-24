declare void @llvm.memcpy.p0i8.p0i8.i32(i8*, i8*, i32, i1)

define void @main() {
  %1 = alloca i8
  %2 = alloca i8
  call void @llvm.memcpy.p0i8.p0i8.i32(i8* %1, i8* %2, i32 1, i1 false)
  ret void
}
