from filter import IShapedFilter
import raimad as rai

class FilterBank(rai.Compo):
    def _make(self):
      for position, length in ((0, 10), (20, 12), (40, 16)):

          filt = IShapedFilter(beam_length=length).proxy()
          filt.movex(position)

          self.subcompos.append(filt)

filterbank = FilterBank()
rai.export_cif(filterbank, "filterbank.cif")
