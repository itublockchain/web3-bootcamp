import { configureStore } from "@reduxjs/toolkit";
import accountReducer from "./slicers/accounts";

export default configureStore({
  reducer: {
    accounts: accountReducer,
  },
});
