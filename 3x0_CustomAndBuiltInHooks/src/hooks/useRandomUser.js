import { useEffect, useState } from "react";

export const useRandomUser = () => {
  const [state, setState] = useState(null);

  useEffect(() => {
    const fn = async () => {
      const result = await fetch("https://randomuser.me/api/");
      const json = await result.json();
      setState(json.results[0]);
    };
    console.log("hjere");
    fn();
  }, []);

  return { state };
};
