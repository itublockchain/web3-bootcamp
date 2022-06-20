import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import "./App.css";
import { useRandomUser } from "./hooks/useRandomUser";

function App() {
  const [value, setValue] = useState(1);
  const ref = useRef(false);

  const { state } = useRandomUser();

  const renderEmail = () => {
    if (!state) return null;
    return state.email;
  };

  return (
    <div className="App">
      <h1>Week {value} - Introduction to custom hooks</h1>
      <button
        onClick={() => {
          if (ref.current === true) return;
          console.log("hello world");
          ref.current = true;
          setValue(2);
        }}
      >
        {" "}
        Button
      </button>
      <h1>{renderEmail()}</h1>
    </div>
  );
}

export default App;
