declare i8* @llvm.coro.begin(token, i8*)
declare i1 @llvm.coro.end(i8*, i1)
declare token @llvm.coro.id(i32, i8*, i8*, i8*)
declare i32 @llvm.coro.size.i32()
declare i8* @llvm.coro.free(token, i8*)
declare i8 @llvm.coro.suspend(token, i1)

declare i8* @malloc(i32)
declare void @free(i8*)
declare void @print(i32)

define i8* @gen(i32 %n) {
entry:
  %id = call token @llvm.coro.id(i32 0, i8* null, i8* null, i8* null)
  %size = call i32 @llvm.coro.size.i32()
  %alloc = call i8* @malloc(i32 %size)
  %hdl = call i8* @llvm.coro.begin(token %id, i8* %alloc)
  br label %loop
loop:
  %n.val = phi i32 [ %n, %entry ], [ %inc, %loop ]
  %inc = add nsw i32 %n.val, 1
  call void @print(i32 %n.val)
  %0 = call i8 @llvm.coro.suspend(token none, i1 false)
  switch i8 %0, label %suspend_or_ret [i8 0, label %loop
  i8 1, label %cleanup]
cleanup:
  %mem = call i8* @llvm.coro.free(token %id, i8* %hdl)
  call void @free(i8* %mem)
  br label %suspend_or_ret
suspend_or_ret:
  %unused = call i1 @llvm.coro.end(i8* %hdl, i1 false)
  ret i8* %hdl
}
