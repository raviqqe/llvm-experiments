declare void @print(i32)

define fastcc void @f(i32 %x) {
entry:
  br label %loop
loop:
  %y = add i32 %x, 1
  call void @print(i32 %y)
  tail call fastcc void @f(i32 %y)
  ret void
}

define fastcc i32 @main() {
entry:
  tail call fastcc void @f(i32 0)
  ret i32 0
}
