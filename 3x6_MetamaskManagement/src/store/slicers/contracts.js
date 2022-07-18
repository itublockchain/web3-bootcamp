import { createSlice } from "@reduxjs/toolkit";

const initialState = {
  lock: null,
  beeToken: null,
};

export const contractsSlice = createSlice({
  name: "contracts",
  initialState,
  reducers: {
    setLockContract: (state, action) => {
      state.lock = action.payload;
    },
    setBeeTokenContract: (state, action) => {
      state.beeToken = action.payload;
    },
  },
});

// Action creators are generated for each case reducer function
export const { setLockContract, setBeeTokenContract } = contractsSlice.actions;

export default contractsSlice.reducer;
