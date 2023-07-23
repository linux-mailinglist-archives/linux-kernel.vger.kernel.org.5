Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F2F75E2B6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 16:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjGWOu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 10:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGWOu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 10:50:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DDFD1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 07:50:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 893E760DD0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 14:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E326EC43391
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 14:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690123854;
        bh=bFz5Su99lgDNw5CTuJ0Se6DmILexAB+dada3RMIyzQA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XGlNMnBeWNS67ZRcbA4rPqFc5XPtifixpM5NyhC099oqVp9wCLLVD8C0pTQQrA/dq
         fPTD0SwXQqycIq/Fs/xw2lHXIpQhTfmR3VwayO+sC/E5MDBsGJO4qwomZqkzjOqjb6
         h/NWqlORzrok6ww42xNWzor3DXCy9MQRs6rZSrR8p1XzHhP49uvZlWjD/KyEfF/+iV
         hCoqONJIJSxwlkiN+4R/hWdDvyHLwvgcoR/ib9VeCKTNOQw6B8BOzU1op56du0fC4h
         4ogbYKRmIXFc/CK+mtuhGmR1EUelaXjpFvqV/QqNnbftGcAjDyGcmIoL7knKt831vf
         tas/5WTgk/5Xw==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-9926623e367so621012266b.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 07:50:54 -0700 (PDT)
X-Gm-Message-State: ABy/qLYtQsIW3ss4hmapnuSFd2edhMtsCI80vFYcG6EbX0Sof3gzERTP
        pmwWTOBmchEtK9/GvN9WdnqdFFObWvoUp4c9hrE=
X-Google-Smtp-Source: APBJJlHNJDByT4f+1G7PHiNcAPy4OIFqDWyt7Wg8Ddv8/OBD6da3UOSqrCiEkdrm/xvkT9wp46NB9LYy8WoxjMtXTT4=
X-Received: by 2002:a17:906:3185:b0:965:fb87:4215 with SMTP id
 5-20020a170906318500b00965fb874215mr7086694ejy.15.1690123853069; Sun, 23 Jul
 2023 07:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230723010329.674186-1-dfustini@baylibre.com>
In-Reply-To: <20230723010329.674186-1-dfustini@baylibre.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 23 Jul 2023 22:50:41 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS7-N=KkDeeja_v1hvydgBPVCv6X6zZW8hj37Hntz56Sg@mail.gmail.com>
Message-ID: <CAJF2gTS7-N=KkDeeja_v1hvydgBPVCv6X6zZW8hj37Hntz56Sg@mail.gmail.com>
Subject: Re: [PATCH] scripts/spelling.txt: remove 'thead' as a typo
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Diederik de Haas <didi.debian@cknow.org>,
        Ian Rogers <irogers@google.com>, SeongJae Park <sj@kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good catch, thank you very much.

Acked-by: Guo Ren <guoren@kernel.org>

On Sun, Jul 23, 2023 at 9:04=E2=80=AFAM Drew Fustini <dfustini@baylibre.com=
> wrote:
>
> T-Head is a vendor of processor core IP, and they have recently
> introduced the RISC-V TH1520 SoC. Remove 'thead' as a typo of 'thread'
> to avoid checkpatch incorrectly warning that 'thead' is typo in patches
> that add support for T-Head designs in the kernel.
>
> Cc: Conor Dooley <conor@kernel.org>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Jisheng Zhang <jszhang@kernel.org>
> Link: https://www.t-head.cn/
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
>  scripts/spelling.txt | 1 -
>  1 file changed, 1 deletion(-)
>
> For example, checkpatch prints the following warnings for 89b0186ab532
> ("dt-bindings: riscv: Add T-HEAD TH1520 board compatibles"):
>
>   $ ./scripts/checkpatch.pl --strict -g 89b0186ab532
>   WARNING: added, moved or deleted file(s), does MAINTAINERS need updatin=
g?
>   new file mode 100644
>
>   WARNING: 'thead' may be misspelled - perhaps 'thread'?
>   +$id: http://devicetree.org/schemas/riscv/thead.yaml#
>                                           ^^^^^
>
>   WARNING: 'thead' may be misspelled - perhaps 'thread'?
>   +          - const: thead,th1520
>                     ^^^^^
>   total: 0 errors, 3 warnings, 0 checks, 29 lines checked
>
> The 'thead' typo false positive adds noise to automation like the
> linux-riscv patchwork bot:
> https://patchwork.kernel.org/project/linux-riscv/patch/20230722-upstream-=
beaglev-ahead-dts-v1-2-ccda511357f4@baylibre.com/
>
> diff --git a/scripts/spelling.txt b/scripts/spelling.txt
> index fc7ba95e86a0..855c4863124b 100644
> --- a/scripts/spelling.txt
> +++ b/scripts/spelling.txt
> @@ -1541,7 +1541,6 @@ temeprature||temperature
>  temorary||temporary
>  temproarily||temporarily
>  temperture||temperature
> -thead||thread
>  theads||threads
>  therfore||therefore
>  thier||their
> --
> 2.34.1
>


--=20
Best Regards
 Guo Ren
