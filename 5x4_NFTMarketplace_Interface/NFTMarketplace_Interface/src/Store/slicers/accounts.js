import { createSlice } from "@reduxjs/toolkit";

const initialState = {
  account: null,
  contract: null,
  provider: null,
  accNFTs: null,
  listedNFTs: []
};

export const accountsSlice = createSlice({
  name: "accounts",
  initialState,
  reducers: {
    setAccount: (state, action) => {
      state.account = action.payload;
      console.log(state.contract);
    },
    setContract: (state, action) => {
      state.contract = action.payload;
    },
    setProvider: (state, action) => {
      state.provider = action.payload;
    },
    setNFTs: (state, action) => {
      state.accNFTs = action.payload;
    },
    setListedNFTs: (state, action) => {
      state.listedNFTs = action.payload;
    },
  },
});

export const { setAccount, setContract, setProvider, setNFTs, setListedNFTs } = accountsSlice.actions;
export default accountsSlice.reducer;
