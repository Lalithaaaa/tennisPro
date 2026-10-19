<script>
	import { session } from '$lib/auth.svelte.js';
</script>

<svelte:head>
	<title>TennisPro</title>
</svelte:head>

<section class="flex flex-1 items-center justify-center">
	<h1 class="text-3xl">Welcome, {session.user.displayName}</h1>
</section>
