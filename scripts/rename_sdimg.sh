#[K] (c)2020
# ** 1st: 1 normal, 2 lite; 2nd: 1 19.07.1, 2 lean, 3 19.07.3, 4 snapshot

case ${1} in
"11")
    sed -i 's/FriendlyWrt_$(date +%Y%m%d)_NanoPi-R2S_arm64_sd.img/NanoPi-R2S_$(date +%Y%m%d)_190701_arm64_sd.img/g' device/friendlyelec/nanopi_r2s.mk
    ;;
"21")
    sed -i 's/FriendlyWrt_$(date +%Y%m%d)_NanoPi-R2S_arm64_sd.img/NanoPi-R2S_$(date +%Y%m%d)_190701_lite_arm64_sd.img/g' device/friendlyelec/nanopi_r2s.mk
    ;;
"12")
    sed -i 's/FriendlyWrt_$(date +%Y%m%d)_NanoPi-R2S_arm64_sd.img/NanoPi-R2S_$(date +%Y%m%d)_lean_arm64_sd.img/g' device/friendlyelec/nanopi_r2s.mk
    ;;
"22")
    sed -i 's/FriendlyWrt_$(date +%Y%m%d)_NanoPi-R2S_arm64_sd.img/NanoPi-R2S_$(date +%Y%m%d)_lean_lite_arm64_sd.img/g' device/friendlyelec/nanopi_r2s.mk
    ;;
"13")
    sed -i 's/FriendlyWrt_$(date +%Y%m%d)_NanoPi-R2S_arm64_sd.img/NanoPi-R2S_$(date +%Y%m%d)_190703_arm64_sd.img/g' device/friendlyelec/nanopi_r2s.mk
    ;;
"23")
    sed -i 's/FriendlyWrt_$(date +%Y%m%d)_NanoPi-R2S_arm64_sd.img/NanoPi-R2S_$(date +%Y%m%d)_190703_lite_arm64_sd.img/g' device/friendlyelec/nanopi_r2s.mk
    ;;
"14")
    sed -i 's/FriendlyWrt_$(date +%Y%m%d)_NanoPi-R2S_arm64_sd.img/NanoPi-R2S_$(date +%Y%m%d)_original_arm64_sd.img/g' device/friendlyelec/nanopi_r2s.mk
    ;;
"24")
    sed -i 's/FriendlyWrt_$(date +%Y%m%d)_NanoPi-R2S_arm64_sd.img/NanoPi-R2S_$(date +%Y%m%d)_original_lite_arm64_sd.img/g' device/friendlyelec/nanopi_r2s.mk
    ;;
*)
    sed -i 's/FriendlyWrt_$(date +%Y%m%d)_NanoPi-R2S_arm64_sd.img/NanoPi-R2S_$(date +%Y%m%d)_arm64_sd.img/g' device/friendlyelec/nanopi_r2s.mk
    ;;
esac
