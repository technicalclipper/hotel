$(".profile").on("click",(e)=>{
    e.stopPropagation(); 
    $(".options").toggleClass("optionvisible");
})
$(document).on("click",()=>{
    $(".options").removeClass("optionvisible")
})

$(".button").on("click", function () {
    const rno = $(this).attr('data-id'); 
    window.location.href = `/getroomdetails/${rno}`;
});


