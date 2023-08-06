Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D15F771449
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 12:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjHFKEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 06:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjHFKD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 06:03:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A496A11D;
        Sun,  6 Aug 2023 03:03:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D62360FFF;
        Sun,  6 Aug 2023 10:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDD0C433C7;
        Sun,  6 Aug 2023 10:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691316236;
        bh=qQdlDvWcY55UI4xJZRVgfN/DeT4JnF2lo47IlKtWxBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fhstg5yZNrU6Mr63+O2DUHYI61MkDUhbHygY9MOVisRC5TpCh0P33b6bZnVOAka0v
         KDLZ7CCsw/USQ6c6aJvH9vBbsidxD75f5QGsnI4X/GvbbxGimOsv1WlWwX8uw8whIW
         OHrUHPeOX10w87kA4tuRWX9KWv3GMsbfecxCuZe6w0Ae2+FzzvJ0Pg5YLaMf/UNh4u
         fx3LM8byNZsr3uzv79s/3Q0Ep76blL4BmT/2XzVRFuotXYkwL5S/JoLmDcJCiKojUx
         s01l9brhiR3ulcENLKHstfHnBcShjIX+Cg35Cn52HisMlIyXdlM3lV5cRMzVDqVyAn
         sgpGuGGu9SLLg==
Date:   Sun, 6 Aug 2023 17:52:16 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: change TH1520 files to dual license
Message-ID: <ZM9tUFddbRUglwfG@xhacker>
References: <20230724182129.843687-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230724182129.843687-1-dfustini@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 11:21:29AM -0700, Drew Fustini wrote:
> Modify the SPDX-License-Identifier for dual license of GPL-2.0 OR MIT.
> 
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
>  arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi | 2 +-
>  arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts      | 2 +-
>  arch/riscv/boot/dts/thead/th1520.dtsi                  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> Jisheng Zhang and Guo Ren - I thought I would post this patch based on
> the discussion in the thread about the BeagleV Ahead patches.

I need Guo's ack to this patch. Hi Guo Ren, are you OK with this patch?

Thanks

> 
> Message-ID:
> 20230722-upstream-beaglev-ahead-dts-v1-0-ccda511357f4@baylibre.com
> 
> Thanks,
> Drew
> 
> diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> index 4b0249ac710f..a802ab110429 100644
> --- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>  /*
>   * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
>   */
> diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> index a1248b2ee3a3..9a3884a73e13 100644
> --- a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> +++ b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>  /*
>   * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
>   */
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> index 56a73134b49e..ce708183b6f6 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>  /*
>   * Copyright (C) 2021 Alibaba Group Holding Limited.
>   * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> -- 
> 2.34.1
> 
