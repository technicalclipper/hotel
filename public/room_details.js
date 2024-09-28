$(".profile").on("click",(e)=>{
    e.stopPropagation(); 
    $(".options").toggleClass("optionvisible");
})
$(document).on("click",()=>{
    $(".options").removeClass("optionvisible")
})

$(".bookbutton").on("click",function (){
    const rno = $(this).attr('data-id'); 
    const date=$("#bookingdate").val();
    add_transaction_to_db(rno,date);


})

async function add_transaction_to_db(rno,date){
    try {
        const response = await fetch("/addbooking", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({rno:rno,date:date})
        });

        if (response.status===200) {
            console.log("booked successfully");
            window.location.href = "/home";
        } 
        else {
            console.error("Failed to book:", response.statusText);
        }
    } catch (error) {
        console.error("Error:", error);
    }
}
