import raimad as rai

class IShapedFilter(rai.Compo):
    def _make(self, beam_length: float = 10.5):
        beam = rai.RectLW(2, beam_length).proxy()
        coup_top = rai.RectLW(10, 2).proxy()
        coup_bot = rai.RectLW(12, 2).proxy()

        coup_top.snap_above(beam)
        coup_bot.snap_below(beam)

        self.subcompos.beam = beam
        self.subcompos.coup_top = coup_top
        self.subcompos.coup_bot = coup_bot

filt = IShapedFilter()
rai.export_cif(filt, "filter.cif")
