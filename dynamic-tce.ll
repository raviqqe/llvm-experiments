declare void @print(i32)

define fastcc void @final(i32) {
entry:
  ret void
}

define fastcc void @print.cps(i32 %x, void ()* %k) {
entry:
  call void @print(i32 42)
  tail call fastcc void %k()
  ret void
}

define fastcc void @add42(i32 %x, void (i32)* %k) {
entry:
  %y = add i32 %x, 42
  tail call fastcc void %k(i32 %y)
  ret void
}

define fastcc i32 @main() {
entry:
  tail call fastcc void @add42(i32 42, void (i32)* @final)
  ret i32 0
}
