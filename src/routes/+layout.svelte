<script>
	import { goto } from '$app/navigation';
	import { resolve } from '$app/paths';
	import { page } from '$app/state';
	import { isNewUser, session } from '$lib/auth.svelte.js';
	import Header from './Header.svelte';
	import './layout.css';
	import { signOutUser } from '$lib/auth.svelte.js';
	import { Navbar, NavBrand, NavLi, NavUl, NavHamburger } from "flowbite-svelte";
	
	let { children } = $props();

	const gates = ['/login', '/newusercreation'];
	const gate = $derived(!session.user ? '/login' : isNewUser() ? '/newusercreation' : null);

	const allowed = $derived(session.ready && (gate
		? page.route.id === gate
		: !gates.includes(page.route.id)));

	$effect(() => {
		if (!session.ready) return;
		if (gate && page.route.id !== gate) goto(resolve(gate));
		else if (!gate && gates.includes(page.route.id)) goto(resolve('/'));
	});
</script>

<div class="flex min-h-screen flex-col bg-[#1e482f] text-zinc-900">
	{#if page.route.id !== '/login'}
	<Navbar fluid={true} class="relative border-b border-white/20 !bg-[#1e482f] px-6 py-3">
	<NavBrand href="/">
		<img src="src/tennisPro_logo.png" class="me-3 h-7 sm:h-9" alt="TennisPro Logo" />
	</NavBrand>

<div class="flex items-center gap-3 md:order-2">
  {#if session.user}
  	{#if session.user.photoURL}
  		<img src={session.user.photoURL} class="h-8 w-8 rounded-full object-cover" alt="Profile" referrerpolicy="no-referrer"/>
			{/if}
			<button type="button" onclick={signOutUser} class="cursor-pointer text-sm font-medium text-white/80 hover:text-white">
			Sign out
			</button>
  				{/if}
  				<NavHamburger />
			</div>
			<NavUl class = "md:order-1">
				<NavLi href="/">Dashboard</NavLi>
				<NavLi href="/library">Library</NavLi>
				<NavLi href="/analysis">Analysis</NavLi>
  			</NavUl>
		</Navbar>
	{/if}


	<main class="mx-auto flex w-full max-w-5xl flex-1 flex-col p-4">
		{#if allowed}
			{@render children()}
		{/if}
	</main>
</div>
