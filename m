Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61651779FDD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 13:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjHLL7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 07:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjHLL7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 07:59:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6DE12D;
        Sat, 12 Aug 2023 04:59:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 232B3618B8;
        Sat, 12 Aug 2023 11:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC60C433C9;
        Sat, 12 Aug 2023 11:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691841545;
        bh=joc6twYzyq/OMO7DgVZmPVJLx3nC/hyckB9nZLCu7yk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JkRy1szDOkp2ampIAHbMPZ6Gd3xEhRJhWl101TXmcwADC3oxsnYclRFJ+eNvYamEF
         5ZbkGpypYLY31+PWcSK/3+9ZoKF4fFSu4JsFEYZ73/ifbYovn0DGbIGf2q7sWJiHdw
         tuv6FwmuNv90A/LTFB1zrzqr3Zp3Qip7rAtrsGEy9rjwVLn9j7sFuNN3Tw5O5ZmSqn
         jEkiWNZKtgsd/M7fuaqJX9eC5bv7iEB+QoaotobAAIZsNRXl2jfQHeqDfwqjV/RWLN
         D4BAopVjMquIgW5s6llWkHs7Cr5Kc2lzbaZzHGQ/urK/bjpZREuBEK5qnsSXyWuo74
         1FEY4M/Z3UoSg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b9b5ee9c5aso44004821fa.1;
        Sat, 12 Aug 2023 04:59:05 -0700 (PDT)
X-Gm-Message-State: AOJu0YyI5UZHQzlFsFczHc17n+2IJwz0u2yM7pT14V65uxlsZDUqbiiA
        3KF6ucLQgZ7G6bwz9fYsz0U70wet4iHEuXAYYSg=
X-Google-Smtp-Source: AGHT+IHZj996J8JNz9Gnnk7beXztJdnkbYwezXhNN/AZcdC/47G1QWQSmWiznUlqQMXlkgsuao6dE13FmA0yW5tI3jo=
X-Received: by 2002:a05:6512:2206:b0:4fe:19ef:879e with SMTP id
 h6-20020a056512220600b004fe19ef879emr3546527lfu.28.1691841543485; Sat, 12 Aug
 2023 04:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230724182129.843687-1-dfustini@baylibre.com>
In-Reply-To: <20230724182129.843687-1-dfustini@baylibre.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 12 Aug 2023 19:58:52 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRNjk_3z6QWGBs7vMNqTQuUaFvA-XsPe7Ek+YL6UzwWpQ@mail.gmail.com>
Message-ID: <CAJF2gTRNjk_3z6QWGBs7vMNqTQuUaFvA-XsPe7Ek+YL6UzwWpQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: change TH1520 files to dual license
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>, Fu Wei <wefu@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Tue, Jul 25, 2023 at 2:21=E2=80=AFAM Drew Fustini <dfustini@baylibre.com=
> wrote:
>
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
>
> Message-ID:
> 20230722-upstream-beaglev-ahead-dts-v1-0-ccda511357f4@baylibre.com
>
> Thanks,
> Drew
>
> diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arc=
h/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> index 4b0249ac710f..a802ab110429 100644
> --- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>  /*
>   * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
>   */
> diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts b/arch/ris=
cv/boot/dts/thead/th1520-lichee-pi-4a.dts
> index a1248b2ee3a3..9a3884a73e13 100644
> --- a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> +++ b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>  /*
>   * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
>   */
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/=
thead/th1520.dtsi
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


--=20
Best Regards
 Guo Ren
