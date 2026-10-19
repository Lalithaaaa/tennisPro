<script>
	import { goto } from '$app/navigation';
	import { resolve } from '$app/paths';
	import { page } from '$app/state';
	import { isNewUser, session } from '$lib/auth.svelte.js';
	import Header from './Header.svelte';
	import './layout.css';

	let { children } = $props();

	const gates = ['/login', '/newusercreation'];
	const gate = $derived(!session.user ? '/login' : (isNewUser() ? '/newusercreation' : null));
	const allowed = $derived(
		session.ready && (gate ? page.route.id === gate : !gates.includes(page.route.id))
	);

	$effect(() => {
		if (!session.ready) return;
		if (gate && page.route.id !== gate) goto(resolve(gate));
		else if (!gate && gates.includes(page.route.id)) goto(resolve('/'));
	});
</script>

<div class="flex min-h-screen flex-col bg-zinc-100 text-zinc-900">
	<Header />

	<main class="mx-auto flex w-full max-w-5xl flex-1 flex-col p-4">
		{#if allowed}
			{@render children()}
		{/if}
	</main>

	
</div>
