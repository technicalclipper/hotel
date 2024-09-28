$(".profile").on("click",(e)=>{
    e.stopPropagation(); 
    $(".options").toggleClass("optionvisible");
})
$(document).on("click",()=>{
    $(".options").removeClass("optionvisible")
})