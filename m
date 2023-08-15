Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B265177D07C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237969AbjHOQ6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238600AbjHOQ62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:58:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9EB133
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:58:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1170062337
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA78DC433C8;
        Tue, 15 Aug 2023 16:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692118706;
        bh=U2JasvPZKz8JUMPbTvu0BodAJYZFGbYKpiGNGE3nvcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VxXAaaEo0xn0uO+M+jdn7uSwjvQJaWV3vzzjvdMj3v5nGrfHEA3hMccp2Qs12Sxh4
         LD5Wjf5qqBoQACBegI5CaHaA9xcKBCg8UILwrRblSMJn9MxED41/bkiQfw/a9OuA47
         RMM3kXcGctHMf2QKr6JClCZ8WrbR/HwfKhyfu2d5LHmKI9q4nRWeHjP59ajBAx+bWm
         LoRdYksd4DlFU4FZbYBp1H7WTTD1U1U76G3J2GqjeDyxOFqLKOwNVbHl8dk3q70D/7
         BqcpFiQWGlV+ZaXkqv3+l1OyVAIZNPsEVJvIulH61MSOJ1hfmik7ZXZ5hoR/UHW9+V
         ZbhwA3At/GEbw==
Date:   Tue, 15 Aug 2023 17:58:22 +0100
From:   Lee Jones <lee@kernel.org>
To:     =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCe0YTQuNGG0LXRgNC+0LI=?= 
        <oficerovas@basealt.ru>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Fwd: [PATCH 2/3] mfd: intel-lpss: Add Alder Lake's PCI devices
 IDs
Message-ID: <20230815165822.GA648357@google.com>
References: <20230810115938.3741058-4-oficerovas@altlinux.org>
 <d70c4ffa-2493-9c2e-a526-8006f4108cbf@basealt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d70c4ffa-2493-9c2e-a526-8006f4108cbf@basealt.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023, Александр Офицеров wrote:

> [PATCH 2/3] mfd: intel-lpss: Add Alder Lake's PCI devices IDs
> 
> I've sent patch to email address which is not monitored now, so I am
> forwarding this email to the correct address

That doesn't work.  Please resend it properly as a [RESEND].

> -------- Перенаправленное сообщение --------
> Тема: 	[PATCH 2/3] mfd: intel-lpss: Add Alder Lake's PCI devices IDs
> Дата: 	Thu, 10 Aug 2023 14:59:37 +0300
> От: 	Alexander Ofitserov <oficerovas@altlinux.org>
> Кому: 	oficerovas@altlinux.org, Lee Jones <lee.jones@linaro.org>
> Копия: 	linux-kernel@vger.kernel.org
> 
> 
> 
> Intel Alder Lake PCH has the same LPSS as Intel Broxton.
> Add the new IDs to the list of supported devices.
> 
> Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>
> ---
> drivers/mfd/intel-lpss-pci.c | 41 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
> index 2d7c588ef1edaa..dc0292aa2e6e42 100644
> --- a/drivers/mfd/intel-lpss-pci.c
> +++ b/drivers/mfd/intel-lpss-pci.c
> @@ -277,6 +277,32 @@ static const struct pci_device_id intel_lpss_pci_ids[]
> = {
> { PCI_VDEVICE(INTEL, 0x4dea), (kernel_ulong_t)&bxt_i2c_info },
> { PCI_VDEVICE(INTEL, 0x4deb), (kernel_ulong_t)&bxt_i2c_info },
> { PCI_VDEVICE(INTEL, 0x4dfb), (kernel_ulong_t)&spt_info },
> + /* ADL-P */
> + { PCI_VDEVICE(INTEL, 0x51a8), (kernel_ulong_t)&bxt_uart_info },
> + { PCI_VDEVICE(INTEL, 0x51a9), (kernel_ulong_t)&bxt_uart_info },
> + { PCI_VDEVICE(INTEL, 0x51aa), (kernel_ulong_t)&bxt_info },
> + { PCI_VDEVICE(INTEL, 0x51ab), (kernel_ulong_t)&bxt_info },
> + { PCI_VDEVICE(INTEL, 0x51c5), (kernel_ulong_t)&bxt_i2c_info },
> + { PCI_VDEVICE(INTEL, 0x51c6), (kernel_ulong_t)&bxt_i2c_info },
> + { PCI_VDEVICE(INTEL, 0x51c7), (kernel_ulong_t)&bxt_uart_info },
> + { PCI_VDEVICE(INTEL, 0x51e8), (kernel_ulong_t)&bxt_i2c_info },
> + { PCI_VDEVICE(INTEL, 0x51e9), (kernel_ulong_t)&bxt_i2c_info },
> + { PCI_VDEVICE(INTEL, 0x51ea), (kernel_ulong_t)&bxt_i2c_info },
> + { PCI_VDEVICE(INTEL, 0x51eb), (kernel_ulong_t)&bxt_i2c_info },
> + { PCI_VDEVICE(INTEL, 0x51fb), (kernel_ulong_t)&bxt_info },
> + /* ADL-M */
> + { PCI_VDEVICE(INTEL, 0x54a8), (kernel_ulong_t)&bxt_uart_info },
> + { PCI_VDEVICE(INTEL, 0x54a9), (kernel_ulong_t)&bxt_uart_info },
> + { PCI_VDEVICE(INTEL, 0x54aa), (kernel_ulong_t)&bxt_info },
> + { PCI_VDEVICE(INTEL, 0x54ab), (kernel_ulong_t)&bxt_info },
> + { PCI_VDEVICE(INTEL, 0x54c5), (kernel_ulong_t)&bxt_i2c_info },
> + { PCI_VDEVICE(INTEL, 0x54c6), (kernel_ulong_t)&bxt_i2c_info },
> + { PCI_VDEVICE(INTEL, 0x54c7), (kernel_ulong_t)&bxt_uart_info },
> + { PCI_VDEVICE(INTEL, 0x54e8), (kernel_ulong_t)&bxt_i2c_info },
> + { PCI_VDEVICE(INTEL, 0x54e9), (kernel_ulong_t)&bxt_i2c_info },
> + { PCI_VDEVICE(INTEL, 0x54ea), (kernel_ulong_t)&bxt_i2c_info },
> + { PCI_VDEVICE(INTEL, 0x54eb), (kernel_ulong_t)&bxt_i2c_info },
> + { PCI_VDEVICE(INTEL, 0x54fb), (kernel_ulong_t)&bxt_info },
> /* APL */
> { PCI_VDEVICE(INTEL, 0x5aac), (kernel_ulong_t)&apl_i2c_info },
> { PCI_VDEVICE(INTEL, 0x5aae), (kernel_ulong_t)&apl_i2c_info },
> @@ -293,6 +319,21 @@ static const struct pci_device_id intel_lpss_pci_ids[]
> = {
> { PCI_VDEVICE(INTEL, 0x5ac4), (kernel_ulong_t)&bxt_info },
> { PCI_VDEVICE(INTEL, 0x5ac6), (kernel_ulong_t)&bxt_info },
> { PCI_VDEVICE(INTEL, 0x5aee), (kernel_ulong_t)&bxt_uart_info },
> + /* ADL-S */
> + { PCI_VDEVICE(INTEL, 0x7aa8), (kernel_ulong_t)&bxt_uart_info },
> + { PCI_VDEVICE(INTEL, 0x7aa9), (kernel_ulong_t)&bxt_uart_info },
> + { PCI_VDEVICE(INTEL, 0x7aaa), (kernel_ulong_t)&bxt_info },
> + { PCI_VDEVICE(INTEL, 0x7aab), (kernel_ulong_t)&bxt_info },
> + { PCI_VDEVICE(INTEL, 0x7acc), (kernel_ulong_t)&bxt_i2c_info },
> + { PCI_VDEVICE(INTEL, 0x7acd), (kernel_ulong_t)&bxt_i2c_info },
> + { PCI_VDEVICE(INTEL, 0x7ace), (kernel_ulong_t)&bxt_i2c_info },
> + { PCI_VDEVICE(INTEL, 0x7acf), (kernel_ulong_t)&bxt_i2c_info },
> + { PCI_VDEVICE(INTEL, 0x7adc), (kernel_ulong_t)&bxt_uart_info },
> + { PCI_VDEVICE(INTEL, 0x7af9), (kernel_ulong_t)&bxt_info },
> + { PCI_VDEVICE(INTEL, 0x7afb), (kernel_ulong_t)&bxt_info },
> + { PCI_VDEVICE(INTEL, 0x7afc), (kernel_ulong_t)&bxt_i2c_info },
> + { PCI_VDEVICE(INTEL, 0x7afd), (kernel_ulong_t)&bxt_i2c_info },
> + { PCI_VDEVICE(INTEL, 0x7afe), (kernel_ulong_t)&bxt_uart_info },
> /* LKF */
> { PCI_VDEVICE(INTEL, 0x98a8), (kernel_ulong_t)&bxt_uart_info },
> { PCI_VDEVICE(INTEL, 0x98a9), (kernel_ulong_t)&bxt_uart_info },
> 
> -- 
> 2.33.8

-- 
Lee Jones [李琼斯]
