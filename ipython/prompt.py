from IPython.terminal.prompts import Prompts


class MyPrompt(Prompts):
    def vi_mode(self):
        curr_mode = super().vi_mode()
        match curr_mode:
            case _ if "ins" in curr_mode:
                return "[I] "
            case _ if "rep" in curr_mode:
                return "[R] "
            case _ if "nav" in curr_mode:
                return "[N] "
            case _:
                return " "


ip = get_ipython()
ip.prompts = MyPrompt(ip)
