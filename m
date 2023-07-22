Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E960475DF35
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 01:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjGVXBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 19:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGVXBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 19:01:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BA610E9;
        Sat, 22 Jul 2023 16:01:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD40060BC8;
        Sat, 22 Jul 2023 23:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAFEC433CD;
        Sat, 22 Jul 2023 23:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690066902;
        bh=f5fJ5pt4NPXx34Hb37BM+d9wtJCqjXyDFsIKLF1ji4M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ktzByZSHZKMnUFFHYr9Kda8gzWkeIJllN3e4aoc4Ms7oFfuy1TiF9k9Way7zxbLNO
         k8qWagPd5Aq8OgFMRjlEWQ9SWARNokLqZ8TrqazVSg/JECY5AhlrmZXmn6NXi+dpSn
         GIZbhcorwh2wABAVj5PysI4rN/L5y1skFqT8wRModTdSI3t7EKMQ6fQaTHuiWmUT7e
         SbgHEX90zPUqNjYkRjwZguV/zh47m6/4mNKu9AG+bpJ828yFPOGrM35MWjdn+39cKs
         OC8xtIjqhFK531Phret/ENXQcTwzyvc1MPt5YpTF4eE8m0xx89qqU5GMWnFuPstACD
         cIp3iokwQx4Tw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-992ca792065so516017266b.2;
        Sat, 22 Jul 2023 16:01:42 -0700 (PDT)
X-Gm-Message-State: ABy/qLZxtEYo3YzSXeB6cN6mdH9nCD4PWTqQn28WkdAgmOUq7HJJTuSl
        nqr6Il3RrA92zK+DJsNK48sTbaO51eSPJVXQiRM=
X-Google-Smtp-Source: APBJJlF26FPEiQllO/7cbxZ7b0mlUSpKebzJvhSee6tgA9QZyHuDxj84+S630hPdYKUJ6Jbtr2VvSneKxurZON2Of18=
X-Received: by 2002:a17:906:649a:b0:993:d616:7ca9 with SMTP id
 e26-20020a170906649a00b00993d6167ca9mr6057799ejm.23.1690066900315; Sat, 22
 Jul 2023 16:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230722-upstream-beaglev-ahead-dts-v1-0-ccda511357f4@baylibre.com>
 <20230722-upstream-beaglev-ahead-dts-v1-3-ccda511357f4@baylibre.com>
In-Reply-To: <20230722-upstream-beaglev-ahead-dts-v1-3-ccda511357f4@baylibre.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 23 Jul 2023 07:01:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ4pdFruCgfwT=pkXEoLN91cC6S2op6RyiBmGm_Vw2xMw@mail.gmail.com>
Message-ID: <CAJF2gTQ4pdFruCgfwT=pkXEoLN91cC6S2op6RyiBmGm_Vw2xMw@mail.gmail.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: add reviewer for T-Head RISC-V SoC support
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>, Fu Wei <wefu@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>
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

Acked-by: Guo Ren <guoren@kernel.org>

On Sun, Jul 23, 2023 at 5:56=E2=80=AFAM Drew Fustini <dfustini@baylibre.com=
> wrote:
>
> I will maintain support for the TH1520-based BeagleV Ahead board so
> adding myself as a reviewer for T-Head SoC patches.
>
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d516295978a4..eaec3333f2ed 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18326,6 +18326,7 @@ RISC-V THEAD SoC SUPPORT
>  M:     Jisheng Zhang <jszhang@kernel.org>
>  M:     Guo Ren <guoren@kernel.org>
>  M:     Fu Wei <wefu@redhat.com>
> +R:     Drew Fustini <dfustini@baylibre.com>
>  L:     linux-riscv@lists.infradead.org
>  S:     Maintained
>  F:     arch/riscv/boot/dts/thead/
>
> --
> 2.34.1
>


--=20
Best Regards
 Guo Ren
