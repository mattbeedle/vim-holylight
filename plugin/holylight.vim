let g:holylight_checker_path = expand('<sfile>:p:h:h').'/bin/holylight-checker'
let g:holylight_day_colorscheme = get(g:, 'holylight_day_theme', 'PaperColor')
let g:holylight_night_colorscheme = get(g:, 'holylight_night_theme', 'grb256')

au CursorHold,BufNewFile,BufRead,VimEnter * nested silent! call HolyLight()

function! HolyLight()
  let brightness  = system(g:holylight_checker_path)
  let exit_status = v:shell_error

  if (exit_status != 0)
    echo "Holy Light: Failed to initialize the ambient light sensor"
    return
  endif

  if !exists('g:holylight_threshold')
    let g:holylight_threshold = 1000000
  endif

  echo brightness

  if (brightness < g:holylight_threshold)
    set background=dark
    execute "colorscheme " . g:holylight_night_colorscheme
  else
    set background=light
    execute "colorscheme " . g:holylight_day_colorscheme
  endif
endfunction


command! HolyLightCheck call HolyLight()
