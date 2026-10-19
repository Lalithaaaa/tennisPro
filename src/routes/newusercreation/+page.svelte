<script>
	import { saveProfile } from '$lib/auth.svelte.js';
</script>

<section class="flex flex-1 flex-col items-center justify-center gap-4">
	<h1 class="text-2xl">Are you a player or a coach?</h1>
	<div class="flex gap-2">
		<button
			class="cursor-pointer rounded"
			onclick={() => saveProfile({ role: 'player' })}>Player</button
		>
		<button
			class="cursor-pointer rounded"
			onclick={() => saveProfile({ role: 'coach' })}>Coach</button
		>
	</div>
</section>
