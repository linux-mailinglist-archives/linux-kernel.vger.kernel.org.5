Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609F97DC94A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343828AbjJaJT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343818AbjJaJTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:19:53 -0400
X-Greylist: delayed 919 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Oct 2023 02:19:33 PDT
Received: from msr16.hinet.net (msr16.hinet.net [IPv6:2001:b000:1c9:10:168:95:4:116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C4BED
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:19:33 -0700 (PDT)
Received: from initramfs.io (2001-b011-4002-3b71-0000-0000-0000-000a.dynamic-ip6.hinet.net [IPv6:2001:b011:4002:3b71:0:0:0:a])
        by msr16.hinet.net (8.15.2/8.15.2) with ESMTPS id 39V9450Z004392
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 31 Oct 2023 17:04:05 +0800
Received: from howl.home.internal.initramfs.io ([10.0.96.176])
        by initramfs.io with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <initramfs@initramfs.io>)
        id 1qxkfP-00024O-O0; Tue, 31 Oct 2023 09:04:07 +0000
Message-ID: <44d23bf5-9875-4ce8-a361-fb4e678f23f2@initramfs.io>
Date:   Tue, 31 Oct 2023 17:04:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ASMedia 2464PD-based SSD enclosure hotplug failure
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <2fd4b2b0-0526-4946-ad05-058366f3127a@initramfs.io>
 <ZUC3LAxK9Lyf2Rz9@debian.me>
From:   initramfs <initramfs@initramfs.io>
Autocrypt: addr=initramfs@initramfs.io; keydata=
 xjMEXU2jtxYJKwYBBAHaRw8BAQdA32TNgwBRB8zKTUDw+OD3EMHH6l7/9BctyPJZg7flyZrN
 JEFtaXQgQWduYW5pIDxpbml0cmFtZnNAaW5pdHJhbWZzLmlvPsKxBBMWCgBZAhsDBAsJCAcF
 FQoJCAsFFgIDAQACHgECF4ACGQEFCQomf3UWIQTmBUi9vIJeEJq2Q9jQE1WLzz4A7QUCXX/Y
 XBgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQ0BNVi88+AO2eqgEAhxrvCxHqcWYCjEl3
 RtK1uMI5Vl78ADXimnIO3Zx2ZygBAK7SL/m0A87AZOj1x/xMjFqYOfSMfe6a8Up//XB0av8M
 zjgEXU2k1BIKKwYBBAGXVQEFAQEHQEnBKEjJUS59EzqqgBWZE3/2Q0BIXmGqreBXzeDMizs+
 AwEIB8J+BBgWCgAmAhsMFiEE5gVIvbyCXhCatkPY0BNVi88+AO0FAl/QqPQFCQomJKAACgkQ
 0BNVi88+AO2kRQEAiznrjgTNzeNfudqZz8MzyQqPEj3F0XeiloYOCbsrm8sA/jwF56ff7aRi
 HfhNFwJQJWzduZL3kmlkCrPxf9EGcvIP
In-Reply-To: <ZUC3LAxK9Lyf2Rz9@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=R/TGpfdX c=1 sm=1 tr=0 ts=6540c309
        a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=Br9LfDWDAAAA:8
        a=-UjBj_0-ptFttSrWvF8A:9 a=O5ZNJCrf5vcWmOMJ:21 a=QEXdDO2ut3YA:10
        a=TRW-o2S9CEoA:10 a=Bg5cootq7XEA:10 a=gR_RJRYUad_6_ruzA8cR:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes the same issue occurs on the LTS kernel (tried 6.1.60):

    [  125.380911] thunderbolt 0-0:1.1: new retimer found, vendor=0x8087
    device=0x15ee
    [  125.404923] thunderbolt 0-1: new device found, vendor=0x187
    device=0xd666
    [  125.404935] thunderbolt 0-1: Gopod Group Limited. USB4 SSD Drive
    Enclosure
    [  125.511460] thunderbolt 0000:00:0d.2: 1:1: failed to enable lane
    bonding
    [  125.511793] thunderbolt 0000:00:0d.2: 1: failed to enable
    CL0s/CL1 on upstream port
    [  125.512698] thunderbolt 0000:00:0d.2: 1: failed to enable TMU
    [  125.514122] thunderbolt 0000:00:0d.2: 1:1: hop deactivation
    failed for hop 1, index 8
    [  125.514126] ------------[ cut here ]------------
    [  125.514126] thunderbolt 0000:00:0d.2: path activation failed
    [  125.514160] WARNING: CPU: 6 PID: 3029 at
    drivers/thunderbolt/path.c:573 tb_path_activate+0x10f/0x480
    [thunderbolt]
    [  125.514176] Modules linked in: ccm rfcomm snd_seq_dummy
    snd_hrtimer snd_seq snd_seq_device nft_ct nf_conntrack
    nf_defrag_ipv6 nf_defrag_ipv4 cmac algif_hash algif_skcipher af_alg
    bnep nf_tables nfnetlink ntfs3 snd_sof_pci_intel_tgl
    snd_sof_intel_hda_common soundwire_intel
    soundwire_generic_allocation soundwire_cadence snd_sof_intel_hda
    snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils
    snd_soc_hdac_hda snd_hda_ext_core snd_soc_acpi_intel_match
    intel_tcc_cooling snd_soc_acpi x86_pkg_temp_thermal soundwire_bus
    intel_powerclamp coretemp snd_soc_core snd_compress iwlmvm ac97_bus
    kvm_intel snd_hda_codec_realtek snd_hda_codec_generic
    snd_hda_codec_hdmi snd_pcm_dmaengine mei_pxp mei_hdcp kvm
    snd_hda_intel mac80211 uvcvideo snd_intel_dspcfg irqbypass
    pmt_telemetry processor_thermal_device_pci videobuf2_vmalloc
    iTCO_wdt snd_intel_sdw_acpi btusb intel_pmc_bxt videobuf2_memops
    snd_hda_codec processor_thermal_device btrtl rapl libarc4
    videobuf2_v4l2 videobuf2_common intel_cstate hid_multitouch
    [  125.514200]  iTCO_vendor_support intel_rapl_msr pmt_class
    snd_hda_core btbcm processor_thermal_rfim iwlwifi r8169
    processor_thermal_mbox mei_me btintel ucsi_acpi snd_hwdep
    intel_uncore dm_zero pcspkr asus_nb_wmi wmi_bmof realtek spi_nor
    typec_ucsi vfat btmtk processor_thermal_rapl videodev snd_pcm
    intel_lpss_pci bluetooth i2c_hid_acpi i2c_i801 snd_timer mdio_devres
    intel_lpss fat mtd cfg80211 i2c_smbus ecdh_generic typec snd libphy
    idma64 thunderbolt mc mei roles intel_vsec crc16 igen6_edac
    soundcore intel_rapl_common i2c_hid joydev int3403_thermal mousedev
    int340x_thermal_zone int3400_thermal acpi_tad acpi_thermal_rel
    acpi_pad mac_hid pkcs8_key_parser dm_multipath i2c_dev crypto_user
    fuse loop ip_tables x_tables btrfs blake2b_generic libcrc32c
    crc32c_generic xor raid6_pq dm_crypt cbc encrypted_keys trusted
    asn1_encoder tee hid_asus asus_wmi ledtrig_audio sparse_keymap
    platform_profile rfkill usbhid dm_mod i915 crct10dif_pclmul
    crc32_pclmul crc32c_intel serio_raw polyval_clmulni atkbd
    [  125.514230]  polyval_generic libps2 gf128mul vivaldi_fmap
    ghash_clmulni_intel sdhci_pci drm_buddy sha512_ssse3 nvme intel_gtt
    cqhci aesni_intel drm_display_helper sdhci crypto_simd nvme_core
    cryptd spi_intel_pci cec xhci_pci mmc_core spi_intel nvme_common
    xhci_pci_renesas ttm i8042 video serio wmi
    [  125.514241] CPU: 6 PID: 3029 Comm: pool-/usr/lib/b Tainted: G
    S                 6.1.60-1-lts #1
    788389645ca0dfa4ffa30b1532df8c1764b26b03
    [  125.514243] Hardware name: ASUSTeK COMPUTER INC. ROG Zephyrus M16
    GU603ZW_GU603ZW/GU603ZW, BIOS GU603ZW.311 12/22/2022
    [  125.514244] RIP: 0010:tb_path_activate+0x10f/0x480 [thunderbolt]
    [  125.514253] Code: 01 00 00 48 85 ed 0f 84 d7 00 00 00 48 81 c7 d0
    00 00 00 e8 b3 ca d6 eb 48 89 ea 48 c7 c7 18 a6 e9 c0 48 89 c6 e8 b1
    b0 62 eb <0f> 0b 48 8b 44 24 08 65 48 2b 04 25 28 00 00 00 0f 85 54
    03 00 00
    [  125.514254] RSP: 0018:ffffadad859b7cb0 EFLAGS: 00010282
    [  125.514256] RAX: 0000000000000000 RBX: 00000000ffffff95 RCX:
    0000000000000027
    [  125.514257] RDX: ffff8c56eb3a1668 RSI: 0000000000000001 RDI:
    ffff8c56eb3a1660
    [  125.514257] RBP: ffff8c4f83121790 R08: 0000000000000000 R09:
    ffffadad859b7b28
    [  125.514258] R10: 0000000000000003 R11: ffff8c570b7a5fe8 R12:
    0000000000000028
    [  125.514258] R13: ffff8c505a524d00 R14: ffff8c4f8f880000 R15:
    ffff8c4f851d4da0
    [  125.514259] FS:  00007f29a19fe6c0(0000) GS:ffff8c56eb380000(0000)
    knlGS:0000000000000000
    [  125.514260] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [  125.514261] CR2: 000056005d26e1d0 CR3: 0000000111ef8000 CR4:
    0000000000f50ee0
    [  125.514262] PKRU: 55555554
    [  125.514262] Call Trace:
    [  125.514264]  <TASK>
    [  125.514264]  ? tb_path_activate+0x10f/0x480 [thunderbolt
    f4f72a0462286342085ff69fa5e3502c86c4ec5a]
    [  125.514273]  ? __warn+0x7d/0xd0
    [  125.514277]  ? tb_path_activate+0x10f/0x480 [thunderbolt
    f4f72a0462286342085ff69fa5e3502c86c4ec5a]
    [  125.514285]  ? report_bug+0xe6/0x150
    [  125.514288]  ? handle_bug+0x3c/0x80
    [  125.514291]  ? exc_invalid_op+0x17/0x70
    [  125.514292]  ? asm_exc_invalid_op+0x1a/0x20
    [  125.514295]  ? tb_path_activate+0x10f/0x480 [thunderbolt
    f4f72a0462286342085ff69fa5e3502c86c4ec5a]
    [  125.514303]  tb_tunnel_restart+0x99/0x180 [thunderbolt
    f4f72a0462286342085ff69fa5e3502c86c4ec5a]
    [  125.514312]  tb_tunnel_pci+0x17b/0x370 [thunderbolt
    f4f72a0462286342085ff69fa5e3502c86c4ec5a]
    [  125.514321]  authorized_store+0x289/0x2d0 [thunderbolt
    f4f72a0462286342085ff69fa5e3502c86c4ec5a]
    [  125.514330]  kernfs_fop_write_iter+0x133/0x1d0
    [  125.514333]  vfs_write+0x236/0x3f0
    [  125.514335]  ksys_write+0x6f/0xf0
    [  125.514337]  do_syscall_64+0x5d/0x90
    [  125.514339]  ? exit_to_user_mode_prepare+0x18a/0x1f0
    [  125.514341]  ? syscall_exit_to_user_mode+0x2b/0x40
    [  125.514342]  ? do_syscall_64+0x6c/0x90
    [  125.514343]  ? exit_to_user_mode_prepare+0x18a/0x1f0
    [  125.514345]  ? syscall_exit_to_user_mode+0x2b/0x40
    [  125.514345]  ? do_syscall_64+0x6c/0x90
    [  125.514347]  entry_SYSCALL_64_after_hwframe+0x64/0xce
    [  125.514349] RIP: 0033:0x7f29a36a906f
    [  125.514368] Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 19 4d
    f8 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00
    00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 6c 4d
    f8 ff 48
    [  125.514369] RSP: 002b:00007f29a19fdc90 EFLAGS: 00000293 ORIG_RAX:
    0000000000000001
    [  125.514370] RAX: ffffffffffffffda RBX: 00007f2998008c40 RCX:
    00007f29a36a906f
    [  125.514371] RDX: 0000000000000001 RSI: 00007f29a19fdd30 RDI:
    000000000000000a
    [  125.514372] RBP: 00007f29a19fdd70 R08: 0000000000000000 R09:
    00007f29a19fdba0
    [  125.514372] R10: 0000000000000000 R11: 0000000000000293 R12:
    00007f2998002e20
    [  125.514373] R13: 000000000000000a R14: 0000000000000000 R15:
    00007f29a19fdd28
    [  125.514374]  </TASK>
    [  125.514374] ---[ end trace 0000000000000000 ]---
    [  125.514376] thunderbolt 0000:00:0d.2: 0:8 <-> 1:3 (PCI):
    activation failed
    [  125.515359] thunderbolt 0000:00:0d.2: 1:3: PCIe tunnel activation
    failed, aborting
    [  125.515397] thunderbolt 0-0:1.1: retimer disconnected
    [  125.515454] thunderbolt 0-1: device disconnected

On 31/10/2023 16:13, Bagas Sanjaya wrote:
> On Tue, Oct 31, 2023 at 12:20:08PM +0800, initramfs wrote:
>> Hi all,
>>
>> I own a ZikeDrive USB4 NVMe SSD enclosure and noticed that upon
>> hotplugging the enclosure I receive the following kernel oops (6.6.0):
>>
>>     [  138.597027] thunderbolt 0-0:1.1: new retimer found, vendor=0x8087
>>     device=0x15ee
>>     [  138.626031] thunderbolt 0-1: new device found, vendor=0x187
>>     device=0xd666
>>     [  138.626046] thunderbolt 0-1: Gopod Group Limited. USB4 SSD Drive
>>     Enclosure
>>     [  138.736546] thunderbolt 0000:00:0d.2: 1:1: failed to enable lane
>>     bonding
>>     [  138.736888] thunderbolt 0000:00:0d.2: 1: failed to enable CL states
>>     [  138.737874] thunderbolt 0000:00:0d.2: 1: failed to enable TMU
>>     [  138.739417] thunderbolt 0000:00:0d.2: 1:1: hop deactivation
>>     failed for hop 1, index 8
>>     [  138.739421] ------------[ cut here ]------------
>>     [  138.739422] thunderbolt 0000:00:0d.2: path activation failed
>>     [  138.739462] WARNING: CPU: 6 PID: 3845 at
>>     drivers/thunderbolt/path.c:573 tb_path_activate+0x10f/0x480
>>     [thunderbolt]
>>     [  138.739495] Modules linked in: ccm rfcomm snd_seq_dummy
>>     snd_hrtimer snd_seq snd_seq_device cmac algif_hash algif_skcipher
>>     af_alg nft_ct nf_conntrack nf_defrag_ipv4 nf_defrag_ipv6 bnep
>>     nf_tables nfnetlink ntfs3 snd_sof_pci_intel_tgl
>>     snd_sof_intel_hda_common soundwire_intel snd_sof_intel_hda_mlink
>>     soundwire_cadence snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp
>>     snd_sof snd_sof_utils snd_soc_hdac_hda snd_hda_ext_core
>>     snd_soc_acpi_intel_match snd_soc_acpi soundwire_generic_allocation
>>     soundwire_bus iwlmvm intel_uncore_frequency snd_soc_core
>>     intel_uncore_frequency_common intel_tcc_cooling snd_compress
>>     snd_hda_codec_realtek ac97_bus x86_pkg_temp_thermal intel_powerclamp
>>     snd_hda_codec_generic snd_hda_codec_hdmi snd_pcm_dmaengine coretemp
>>     mac80211 snd_hda_intel hid_multitouch kvm_intel snd_intel_dspcfg
>>     snd_intel_sdw_acpi libarc4 mei_pxp kvm btusb uvcvideo mei_hdcp
>>     snd_hda_codec btrtl uvc processor_thermal_device_pci videobuf2_v4l2
>>     btbcm irqbypass snd_hda_core iTCO_wdt processor_thermal_device
>>     dm_zero btintel videodev btmtk
>>     [  138.739535]  iTCO_vendor_support processor_thermal_rapl snd_hwdep
>>     r8169 rapl ucsi_acpi intel_pmc_bxt intel_rapl_msr iwlwifi bluetooth
>>     realtek videobuf2_vmalloc pmt_telemetry typec_ucsi snd_pcm spi_nor
>>     intel_cstate vfat mei_me intel_rapl_common intel_lpss_pci
>>     mdio_devres videobuf2_memops pmt_class snd_timer videobuf2_common
>>     i2c_i801 intel_lpss intel_uncore wmi_bmof asus_nb_wmi pcspkr typec
>>     ecdh_generic cfg80211 libphy mtd fat processor_thermal_rfim mc mei
>>     idma64 i2c_smbus snd thunderbolt crc16 roles i2c_hid_acpi soundcore
>>     intel_vsec processor_thermal_mbox igen6_edac i2c_hid int3403_thermal
>>     int340x_thermal_zone int3400_thermal acpi_thermal_rel acpi_tad
>>     mousedev acpi_pad joydev mac_hid pkcs8_key_parser dm_multipath
>>     i2c_dev crypto_user fuse loop ip_tables x_tables btrfs
>>     blake2b_generic libcrc32c crc32c_generic xor raid6_pq dm_crypt cbc
>>     encrypted_keys trusted tee asn1_encoder hid_asus asus_wmi
>>     ledtrig_audio sparse_keymap rfkill platform_profile usbhid i915
>>     crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni
>>     [  138.739592]  polyval_generic gf128mul serio_raw
>>     ghash_clmulni_intel drm_buddy dm_mod sha512_ssse3 intel_gtt atkbd
>>     ttm sdhci_pci vivaldi_fmap aesni_intel libps2 i2c_algo_bit cqhci
>>     nvme sdhci crypto_simd drm_display_helper nvme_core xhci_pci cryptd
>>     spi_intel_pci mmc_core xhci_pci_renesas nvme_common spi_intel cec
>>     video i8042 serio wmi
>>     [  138.739610] CPU: 6 PID: 3845 Comm: pool-/usr/lib/b Tainted: G
>>     S                 6.6.0-1-mainline #1
>>     a243c5e3c83e72fc2b2243b5ea465e514d6c24c1
>>     [  138.739614] Hardware name: ASUSTeK COMPUTER INC. ROG Zephyrus M16
>>     GU603ZW_GU603ZW/GU603ZW, BIOS GU603ZW.311 12/22/2022
>>     [  138.739615] RIP: 0010:tb_path_activate+0x10f/0x480 [thunderbolt]
>>     [  138.739637] Code: 01 00 00 48 85 ed 0f 84 d7 00 00 00 48 81 c7 c0
>>     00 00 00 e8 93 24 7b f8 48 89 ea 48 c7 c7 20 95 db c0 48 89 c6 e8 f1
>>     78 f4 f7 <0f> 0b 48 8b 44 24 08 65 48 2b 04 25 28 00 00 00 0f 85 54
>>     03 00 00
>>     [  138.739639] RSP: 0018:ffffc90005937d30 EFLAGS: 00010282
>>     [  138.739641] RAX: 0000000000000000 RBX: 00000000ffffff95 RCX:
>>     0000000000000027
>>     [  138.739642] RDX: ffff88886b3a1708 RSI: 0000000000000001 RDI:
>>     ffff88886b3a1700
>>     [  138.739644] RBP: ffff88810310edc0 R08: 0000000000000000 R09:
>>     ffffc90005937bb8
>>     [  138.739644] R10: 0000000000000003 R11: ffff88888b7aac28 R12:
>>     0000000000000028
>>     [  138.739645] R13: ffff88813ebc9100 R14: ffff888103fe5800 R15:
>>     ffff8881701d8fe0
>>     [  138.739647] FS:  00007fd6231fe6c0(0000) GS:ffff88886b380000(0000)
>>     knlGS:0000000000000000
>>     [  138.739648] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>     [  138.739650] CR2: 000055d0bbfe6610 CR3: 0000000141210000 CR4:
>>     0000000000f50ee0
>>     [  138.739651] PKRU: 55555554
>>     [  138.739652] Call Trace:
>>     [  138.739654]  <TASK>
>>     [  138.739655]  ? tb_path_activate+0x10f/0x480 [thunderbolt
>>     c85481cfb2695e02347db36bb54248816593d261]
>>     [  138.739676]  ? __warn+0x81/0x130
>>     [  138.739681]  ? tb_path_activate+0x10f/0x480 [thunderbolt
>>     c85481cfb2695e02347db36bb54248816593d261]
>>     [  138.739702]  ? report_bug+0x171/0x1a0
>>     [  138.739706]  ? console_unlock+0x78/0x120
>>     [  138.739710]  ? handle_bug+0x3c/0x80
>>     [  138.739718]  ? exc_invalid_op+0x17/0x70
>>     [  138.739721]  ? asm_exc_invalid_op+0x1a/0x20
>>     [  138.739725]  ? tb_path_activate+0x10f/0x480 [thunderbolt
>>     c85481cfb2695e02347db36bb54248816593d261]
>>     [  138.739746]  tb_tunnel_restart+0xb3/0x220 [thunderbolt
>>     c85481cfb2695e02347db36bb54248816593d261]
>>     [  138.739767]  tb_tunnel_pci+0x1b2/0x480 [thunderbolt
>>     c85481cfb2695e02347db36bb54248816593d261]
>>     [  138.739787]  authorized_store+0x289/0x2d0 [thunderbolt
>>     c85481cfb2695e02347db36bb54248816593d261]
>>     [  138.739806]  kernfs_fop_write_iter+0x133/0x1d0
>>     [  138.739810]  vfs_write+0x23b/0x420
>>     [  138.739815]  ksys_write+0x6f/0xf0
>>     [  138.739818]  do_syscall_64+0x5d/0x90
>>     [  138.739820]  ? syscall_exit_to_user_mode+0x2b/0x40
>>     [  138.739824]  ? do_syscall_64+0x6c/0x90
>>     [  138.739826]  ? do_syscall_64+0x6c/0x90
>>     [  138.739828]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>>     [  138.739830] RIP: 0033:0x7fd628ec406f
>>     [  138.739876] Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 19 4d
>>     f8 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00
>>     00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 6c 4d
>>     f8 ff 48
>>     [  138.739877] RSP: 002b:00007fd6231fdc90 EFLAGS: 00000293 ORIG_RAX:
>>     0000000000000001
>>     [  138.739880] RAX: ffffffffffffffda RBX: 00007fd614008c40 RCX:
>>     00007fd628ec406f
>>     [  138.739881] RDX: 0000000000000001 RSI: 00007fd6231fdd30 RDI:
>>     000000000000000a
>>     [  138.739882] RBP: 00007fd6231fdd70 R08: 0000000000000000 R09:
>>     00007fd6231fdba0
>>     [  138.739883] R10: 0000000000000000 R11: 0000000000000293 R12:
>>     00007fd614002e20
>>     [  138.739884] R13: 000000000000000a R14: 0000000000000000 R15:
>>     00007fd6231fdd28
>>     [  138.739886]  </TASK>
>>     [  138.739887] ---[ end trace 0000000000000000 ]---
>>     [  138.739888] thunderbolt 0000:00:0d.2: 0:8 <-> 1:3 (PCI):
>>     activation failed
>>     [  138.740586] thunderbolt 0000:00:0d.2: 1:3: PCIe tunnel activation
>>     failed, aborting
>>     [  138.740697] thunderbolt 0-0:1.1: retimer disconnected
>>     [  138.740791] thunderbolt 0-1: device disconnected
>>
>> the device is then rediscovered and the kernel oops reoccurs ad
>> infinitum (device remaining non-functional the whole time).
>>
>> If the device was plugged in during system boot, no such error occurs
>> and the device is fully functional.
>> If the device is then unplugged/replugged, the above kernel oops appears
>> and the device remains unusable.
>>
>> I have also tried enrolling the device prior to connect as well as
>> enabling auto-authorization via udev rules as described in the "USB4 and
>> Thunderbolt" admin guide, both to no avail.
>>
>> The system under test is an Asus ROG Zephyrus M16 GU603ZW (Intel
>> i9-12900H [Alder Lake]) loaded with Arch Linux (tested under
>> 6.5.2-arch1-1, 6.5.3-arch1-1, and 6.6.0-1-mainline [vanilla]).
>>
>> The external enclosure is fully functional with the same kernel on a
>> system with a TB3-only port (Intel i7-8750H [Coffee Lake] + Intel® HM370
>> chipset), including hotplugging support.
>> The external enclosure is also fully functional on the test system
>> described above booted into Windows 11 x64.
>>
>> The bug was first reported to the Arch Linux forums with no response
>> (https://bbs.archlinux.org/viewtopic.php?id=288731), more details can be
>> found there too.
>>
> Do you have this issue on kernel v6.1?
>
