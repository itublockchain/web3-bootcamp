export function clsnm(...classNames) {
  let className = "";

  for (let i = 0; i < classNames?.length; i++) {
    if (classNames[i] && classNames[i] !== true) {
      className += `${i === 0 ? "" : " "}${classNames[i]}`;
    }
  }

  return className;
}