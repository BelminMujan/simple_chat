export class UserMessageDto {
    id
    email
    username
    image
    constructor(user) {
        this.id = user.id
        this.email = user.email
        this.username = user.username
        this.image = user.image
    }

}