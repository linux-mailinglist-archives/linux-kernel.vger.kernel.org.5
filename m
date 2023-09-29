Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652657B2F8C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 11:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjI2JuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 05:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjI2Jt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 05:49:58 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E1C195;
        Fri, 29 Sep 2023 02:49:55 -0700 (PDT)
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MUGqT-1rCOJf04cV-00RFr6; Fri, 29 Sep 2023 11:44:48 +0200
Message-ID: <dd94cc5b-4918-0342-4781-69a031ab2d1f@vivier.eu>
Date:   Fri, 29 Sep 2023 11:44:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: fr
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <6f30b86b83b972e9902b62295f397a20512d5507.1695977960.git.geert@linux-m68k.org>
From:   Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] m68k: defconfig: Update virt_defconfig for v6.6-rc3
In-Reply-To: <6f30b86b83b972e9902b62295f397a20512d5507.1695977960.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YoF0H0srviqgAdJ0dtMwDlrEEuP2GWcpFSpasLURQvVW9YeSZKG
 xDi35H5/HqN35SyF9SbDlGVbjxKRW4fz2vdULZF5lNPTARGm7Eu7o15N5ewKL9PVmkmZK36
 QA7FA00tOKr8Ay/mIbV2TbkHp2X6yGF1wVU7wg0aVNb1T6yHJ/9fIkVO8i9Ap79kL3JRiAw
 2/rPFcWI72rfTxW9eS8og==
UI-OutboundReport: notjunk:1;M01:P0:7n+sKMtlpCQ=;chT7YhDL6R/JBWTUAH75lJZ6Mfc
 HbilaPCME7Cx8jm/Xqg4StrvR5BlyG9AgRghS4ytdmsLBZIE8Ag/0HJzPfuH1oNBYVBgTMVj5
 xdczwoDJX6Pm6kU+SIQ3JSWpRpJbOMSih4dUTg0hhHQ80mW8wGnNm0gDAOo4zLR/fGIIrdfri
 ehEIlAuiILAHauxkcqf0a+yBQuLFoGcdX3t+juKcYHbszKB4yNuAvLHDFvLnL8/2e7L92Diyc
 vn1xchmSrrxCZ3BAX2YS6hzT8gChSJD/9nOEWuCmIgpvKv2A5QxeflMPlcSolP3b9G24AX1cJ
 5z3Z0wOL9Z+v12il+nfwNL0L25eRN1Oj5+qTWH8FJOFCvrJndNuqqH5nd6DkOpHVQD0rY96ZC
 ZpExLteG9ziGocDxO9eCtYUz7wSnDiIiIMgKNRj7fg9fQimni31hBh/aXteDppyX9ZQxorTYR
 TDpwumUucT0qjxbgMud2yE+WB8J2pJ9LDikaboaBrhhDQvPEUKUHnf9wmYMxP0w+32Rouhk3c
 vdmbsj416ZhKd46DCPA7pavmYoHjsHeSpGToOECjfUTLBf0Cah7vSVu2p4OvaDGgA9go119aL
 2uXqSDwa6+Mgp5YCRX8Q36IB2d1WBq7cihGhTfOebTMfpeMjZQ0Ft0TFU2OpGeMQepAmOsR94
 jhI0rG0RvC2RnuOW2C4qvhO/wzUb9ICx8tBL8hojDr7RUKT5npks5bFeCudW91raerQ3t+6ga
 fQoHxmnVlMkpA+dXjBFG8KcDJ9Rbv7sEuRUO8H3U+/cEYQm1AUKcCY+Dt3hTF2eqT/MsMYcZW
 sopMvjySWrjVMCXv5gRaugSyKMP4xslCD2xGHRJwuXQvZHU2hHTY0pp9iitm+lzKcOf8jVT4X
 GtgabD4Uio0s4bw==
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 29/09/2023 à 11:01, Geert Uytterhoeven a écrit :
>    - Enable CONFIG_DRM_FBDEV_EMULATION and CONFIG_FB_DEVICE (no longer
>      auto-enabled since commit bb6c4507fe825f1b ("drm: fix up fbdev
>      Kconfig defaults")),
>    - Drop CONFIG_FRAMEBUFFER_CONSOLE=y (auto-enabled since commit
>      bb6c4507fe825f1b ("drm: fix up fbdev Kconfig defaults")).
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Perhaps CONFIG_FB_DEVICE should not be enabled?

Why do you think it should not be enabled?

I think X was needing this to work on m68k.

Thanks,
Laurent

> 
> To be queued in the m68k for-v6.7 branch.
> ---
>   arch/m68k/configs/virt_defconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/configs/virt_defconfig b/arch/m68k/configs/virt_defconfig
> index 3afc6762b0946aa6..ec021a1d48ee7d86 100644
> --- a/arch/m68k/configs/virt_defconfig
> +++ b/arch/m68k/configs/virt_defconfig
> @@ -47,8 +47,9 @@ CONFIG_INPUT_EVDEV=y
>   CONFIG_VIRTIO_CONSOLE=y
>   CONFIG_HW_RANDOM_VIRTIO=y
>   CONFIG_DRM=y
> +CONFIG_DRM_FBDEV_EMULATION=y
>   CONFIG_DRM_VIRTIO_GPU=y
> -CONFIG_FRAMEBUFFER_CONSOLE=y
> +CONFIG_FB_DEVICE=y
>   CONFIG_SOUND=y
>   CONFIG_SND=y
>   CONFIG_SND_VIRTIO=y

