import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";
import { getStorage } from "firebase/storage";

const firebaseConfig = {
  apiKey: "AIzaSyCSATNP9YA346NouFnDTwWEfDjU8yTRDFQ",
  authDomain: "smartbeehive-f67f1.firebaseapp.com",
  databaseURL: "https://smartbeehive-f67f1-default-rtdb.europe-west1.firebasedatabase.app/",
  projectId: "smartbeehive-f67f1",
  storageBucket: "smartbeehive-f67f1.appspot.com",
  messagingSenderId: "558701834479",
  appId: "1:558701834479:web:aa64a25e30657fe9422b1a"
}

export const app = initializeApp(firebaseConfig);
export const db = getFirestore(app);
export const storage = getStorage(app);
