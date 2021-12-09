let uid = document.getElementById('uid').innerHTML

if (uid)
{
	function pause() {
		audio.pause();
		document.getElementById("pause1").classList.toggle("d-none");
		document.getElementById("play1").classList.toggle("d-none");
		document.getElementById("pause2").classList.toggle("d-none");
		document.getElementById("play2").classList.toggle("d-none");
	}

	function play() {
		audio.play();
		document.getElementById("pause1").classList.toggle("d-none");
		document.getElementById("play1").classList.toggle("d-none");
		document.getElementById("pause2").classList.toggle("d-none");
		document.getElementById("play2").classList.toggle("d-none");
	}

	window.addEventListener('load', (e) => {

		let audio = new Audio(`/songs/${uid}`);
		audio.loop=true;

		audio.play();
		document.getElementById('userpage').addEventListener('click', () => {
			if (audio.paused) audio.play(); 
		}, {once : true});
	});
}