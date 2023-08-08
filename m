Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD16774079
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjHHRDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjHHRC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:02:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0B51975C;
        Tue,  8 Aug 2023 09:01:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFFDD625B5;
        Tue,  8 Aug 2023 15:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF09C43391;
        Tue,  8 Aug 2023 15:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691508223;
        bh=p/gZrLJWIq9rjBprunm92rcmzahKLeL9mAVdQI8fVVo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qy1+8nyJUvB/EfBRGU/WqIuoJPDI/GX+NItsoVvhZHjuGZEA9FNTIkvUV7wzcp/vO
         TFiNMnr0oRvIZ+0b7CjviOqqavXvwjKOdxq4YZeMIwV/koBj/VnjyOF+3TqNTALbeo
         khBdOOBovJ8wU9T/ByaDAqeiOEIzgqwj+HazzzSAVaIg1f7diMd02T/Tm6HL0uM5D7
         G4g+cx4pQY84gklxi+GtRgwkx+G8OQGkSxqGhu2Xrkhz1zflarGAWb3zmpmAsMsruZ
         YizxvcUov6ok56EnIdohnSBOUNyinKRwwx5o1/md6QfsVQoqHm7FNWAx2tbJCHzqbb
         GBlhxdRN1uQnA==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-52328e96869so4958090a12.1;
        Tue, 08 Aug 2023 08:23:43 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz5qgPBB678B9kjeSeQoYecvOWfbOo04rkaQxw6QHzkizZ3y5QX
        NL0MYzULSfOuvMPLn2flwe5u26u6xzKKAQTokLI=
X-Google-Smtp-Source: AGHT+IFokLhJzs0xQ2NHVRIO9yXYHKzsfvqWkhy1RiVlRicnei4YhMS57h/OcLGJhZHDLuqZXniZJtcKEiLEmfB9g90=
X-Received: by 2002:aa7:c542:0:b0:521:8d64:df1c with SMTP id
 s2-20020aa7c542000000b005218d64df1cmr156003edr.0.1691508221350; Tue, 08 Aug
 2023 08:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230724182129.843687-1-dfustini@baylibre.com> <ZM9tUFddbRUglwfG@xhacker>
In-Reply-To: <ZM9tUFddbRUglwfG@xhacker>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 8 Aug 2023 23:23:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT4pyAT5xpSAuOJ801WSk=xouv=uC0PSpHKqB3D=GxHsg@mail.gmail.com>
Message-ID: <CAJF2gTT4pyAT5xpSAuOJ801WSk=xouv=uC0PSpHKqB3D=GxHsg@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: change TH1520 files to dual license
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Drew Fustini <dfustini@baylibre.com>, Fu Wei <wefu@redhat.com>,
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

On Sun, Aug 6, 2023 at 6:03=E2=80=AFPM Jisheng Zhang <jszhang@kernel.org> w=
rote:
>
> On Mon, Jul 24, 2023 at 11:21:29AM -0700, Drew Fustini wrote:
> > Modify the SPDX-License-Identifier for dual license of GPL-2.0 OR MIT.
> >
> > Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> > ---
> >  arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi | 2 +-
> >  arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts      | 2 +-
> >  arch/riscv/boot/dts/thead/th1520.dtsi                  | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >
> > Jisheng Zhang and Guo Ren - I thought I would post this patch based on
> > the discussion in the thread about the BeagleV Ahead patches.
>
> I need Guo's ack to this patch. Hi Guo Ren, are you OK with this patch?
I'm okay with the dual license.
Acked-by: Guo Ren <guoren@kernel.org>

>
> Thanks
>
> >
> > Message-ID:
> > 20230722-upstream-beaglev-ahead-dts-v1-0-ccda511357f4@baylibre.com
> >
> > Thanks,
> > Drew
> >
> > diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/a=
rch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> > index 4b0249ac710f..a802ab110429 100644
> > --- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> > +++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> > @@ -1,4 +1,4 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> >  /*
> >   * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> >   */
> > diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts b/arch/r=
iscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> > index a1248b2ee3a3..9a3884a73e13 100644
> > --- a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> > +++ b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> > @@ -1,4 +1,4 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> >  /*
> >   * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> >   */
> > diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dt=
s/thead/th1520.dtsi
> > index 56a73134b49e..ce708183b6f6 100644
> > --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> > +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> > @@ -1,4 +1,4 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> >  /*
> >   * Copyright (C) 2021 Alibaba Group Holding Limited.
> >   * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> > --
> > 2.34.1
> >



--=20
Best Regards
 Guo Ren
