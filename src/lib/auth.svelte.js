import { onAuthStateChanged, signInWithPopup, signOut } from 'firebase/auth';
import { doc, onSnapshot, serverTimestamp, setDoc } from 'firebase/firestore';
import { auth, db, googleProvider } from '$lib/firebase.js';

export const session = $state({ user: null, profile: null, ready: false });

let stopProfile = () => {};

onAuthStateChanged(auth, (user) => {
	stopProfile();
	session.user = user;
	session.profile = null;
	if (!user) {
		session.ready = true;
		return;
	}
	session.ready = false;
	stopProfile = onSnapshot(
		doc(db, 'users', user.uid),
		(snap) => {
			session.profile = snap.data() ?? null;
			session.ready = true;
		},
		() => {
			session.ready = true;
		}
	);
});

export function isNewUser() {
	return !!session.user && !session.profile?.onboarded;
}

export function signInWithGoogle() {
	return signInWithPopup(auth, googleProvider);
}

// got help from this part https://firebase.google.com/docs/firestore/manage-data/add-data#set_a_document
export function saveProfile(details) {
	const { uid, displayName, email, photoURL } = session.user;
	return setDoc(
		doc(db, 'users', uid),
		{
			...details,
			name: displayName,
			email,
			photoURL,
			onboarded: true,
			createdAt: serverTimestamp()
		},
		{ merge: true }
	);
}

export function signOutUser() {
	return signOut(auth);
}
