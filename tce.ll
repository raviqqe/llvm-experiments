declare void @print(i32)

define fastcc void @f() {
entry:
  br label %loop
loop:
  call void @print(i32 42)
  tail call fastcc void @f()
  ret void
}

define fastcc i32 @main() {
entry:
  tail call fastcc void @f()
  ret i32 0
}
