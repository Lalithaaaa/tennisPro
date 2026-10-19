<script>
	import { resolve } from '$app/paths';
	import { session, signOutUser } from '$lib/auth.svelte.js';
</script>

<header class="flex items-center justify-between px-4 py-3">
	<a class="text-lg font-bold" href={resolve('/')}>TennisPro</a>

	{#if session.user}
		<div class="flex items-center gap-3">
			{#if session.user.photoURL}
				<img
					class="size-8 rounded-full"
					src={session.user.photoURL}
					alt=""
					referrerpolicy="no-referrer"
				/>
			{/if}
			<button class="cursor-pointer text-sm hover:underline" onclick={signOutUser}>Sign out</button>
		</div>
	{/if}
</header>
