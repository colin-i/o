
ld -nostdlib --large-address-aware -mi386pe -e _start -subsystem windows -s -o ../build/ostream.exe ./_dif/dif~win.o  ./_exec/ostream.o  ./_exec/start.o  ./_exec/mainhandles.o  ./_exec/uri.o  ./_exec/uristream.o  ./_exec/capture/save.o  ./_exec/mediainfo.o  ./_prepare/view.o  ./_prepare/pipe.o  ./_prepare/sel.o  ./_prepare/prevw.o  ./_prepare/paint.o  ./_prepare/stagempeg.o  ./_prepare/output/all.o  ./_prepare/output/stagefileoptions.o  ./_prepare/output/sound.o  ./_prepare/output/avi.o  ./_prepare/output/mkv.o  ./_prepare/frame/frame.o  ./_prepare/frame/add.o  ./_prepare/frame/remove.o  ./_prepare/frame/frametime.o  ./_prepare/frame/imagetools.o  ./_prepare/frame/scale.o  ./_prepare/frame/crop.o  ./_prepare/frame/pencil.o  ./_prepare/frame/screenshot.o  ./_prepare/frame/brightness.o  ./_prepare/frame/overlay.o  ./_prepare/frame/rotate.o  ./_prepare/effect/base.o  ./_prepare/effect/fade.o  ./_prepare/effect/move.o  ./_prepare/effect/scale_effect.o  ./_prepare/effect/reveal.o  ./_prepare/effect/reveal_shape.o  ./_prepare/effect/reveal_diagonal.o  ./_search/dialog.o  ./_search/dialog_fns.o  ./_search/parse.o  ./_search/previews.o  ./_exec/mix.o  ./_exec/help.o  ./_capture/capture.o  ./util/util.o  ./util/update.o  ./util/numbers.o  ./util/floating.o  ./util/lists.o  ./util/asm.o  ./media/audiovideo.o  ./media/jpeg.o  ./media/jpeg_enc.o  ./media/mpeg.o  ./media/mpeg_init.o  ./media/mpeg_enc.o  ./media/mpeg_pred.o  ./media/mpeg_code.o  ./media/mpeg_interframe.o  ./media/mp4.o  ./media/mp4_data.o  ./media/mpeg-avc_data.o  ./media/mpeg-avc_wrap.o  ./media/mpeg-avc_bs.o  ./media/mpeg-avc_encode.o  ./media/mpeg-avc_mb.o  ./media/mpeg-avc_block.o  ./media/mpeg-avc_action.o  ./media/mpeg-mp3_data.o  ./media/mpeg-mp3_tables.o  ./media/mpeg-mp3_wrap.o  ./media/mpeg-mp3_bs.o  ./media/mpeg-mp3_huffman.o  ./media/mpeg-mp3_input.o  ./media/mpeg-mp3_mdct.o  ./media/mpeg-mp3_encode.o  ./media/mpeg-mp3_iteration.o  ./media/mpeg-mp3_iteration_code.o  ./obj/containers.o  ./obj/items.o  ./obj/tool.o  ./obj/images.o  ./str/str.o  ./mem/alloc.o  ./mem/op.o  ./net/net-base.o  ./err/err.o  ./event/event.o  ./file-folder/file-base.o  ./file-folder/folder-base.o  ./interface/buttons.o  ./gnu/gst.o  -L../_fix/w/ -lgtk -lgdk -lgdkpix -lglib -lgobject -lgio -lgthread -lgstreamer -lgstinterfaces -lgstpbutils -lgstapp -lsoup -ljpeg -lcairo -lpango -lmsvcr100 -lkernel32 -lmsvcrt -lgdi32 -luser32 -lwinmm