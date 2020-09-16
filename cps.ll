declare token @llvm.coro.id.retcon(i32, i32, i8*, i8*, i8*, i8*)
declare i8* @llvm.coro.begin(token, i8*)
declare i1 @llvm.coro.suspend.retcon.i1(...)
declare i1 @llvm.coro.end(i8*, i1)
declare i8* @llvm.coro.prepare.retcon(i8*)

declare i8* @malloc(i32)
declare void @free(i8*)

declare i8* @prototype(i8*, i1)

define i8* @f(i8* %buffer, i32 %x) {
entry:
  %id = call token @llvm.coro.id.retcon(i32 8, i32 8, i8* %buffer, i8* bitcast (i8* (i8*, i1)* @prototype to i8*), i8* bitcast (i8* (i32)* @malloc to i8*), i8* bitcast (void (i8*)* @free to i8*))
  %hdl = call i8* @llvm.coro.begin(token %id, i8* null)
  br label %loop

loop:
  %x.val = phi i32 [ %x, %entry ], [ %inc, %resume ]
  %unwind = call i1 (...) @llvm.coro.suspend.retcon.i1()
  br i1 %unwind, label %cleanup, label %resume

resume:
  %inc = add i32 %x.val, 1
  br label %loop

cleanup:
  call i1 @llvm.coro.end(i8* %hdl, i1 0)
  unreachable
}

define i32 @main() {
entry:
  %0 = alloca [8 x i8], align 8
  %buffer = bitcast [8 x i8]* %0 to i8*
  %prepare = call i8* @llvm.coro.prepare.retcon(i8* bitcast (i8* (i8*, i32)* @f to i8*))
  %f = bitcast i8* %prepare to i8* (i8*, i32)*
  %cont0 = call i8* %f(i8* %buffer, i32 4)
  %cont0.cast = bitcast i8* %cont0 to i8* (i8*, i1)*
  %cont1 = call i8* %cont0.cast(i8* %buffer, i1 zeroext false)
  %cont1.cast = bitcast i8* %cont1 to i8* (i8*, i1)*
  %cont2 = call i8* %cont1.cast(i8* %buffer, i1 zeroext false)
  %cont2.cast = bitcast i8* %cont2 to i8* (i8*, i1)*
  call i8* %cont2.cast(i8* %buffer, i1 zeroext true)
  ret i32 0
}
