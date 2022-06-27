import { createSlice } from "@reduxjs/toolkit";

const initialState = {
  provider: null,
  signer: null,
  address: null,
  account: null,
};

export const dataSlice = createSlice({
  name: "data",
  initialState,
  reducers: {
    setProvider: (state, action) => {
      state.provider = action.payload;
    },
    setSigner: (state, action) => {
      state.signer = action.payload;
    },
    setAddress: (state, action) => {
      state.address = action.payload;
    },
    setAccount: (state, action) => {
      state.account = action.payload;
    },
  },
});

// Action creators are generated for each case reducer function
export const { setProvider, setSigner, setAddress, setAccount } =
  dataSlice.actions;

export default dataSlice.reducer;
