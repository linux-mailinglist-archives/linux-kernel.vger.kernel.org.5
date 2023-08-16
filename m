Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC72C77E5C8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344464AbjHPP7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344461AbjHPP6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:58:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6E62D46;
        Wed, 16 Aug 2023 08:58:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3094B6397C;
        Wed, 16 Aug 2023 15:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0244FC433C8;
        Wed, 16 Aug 2023 15:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692201496;
        bh=yI3jO41F7I/D3o6O2gOqgEinRf/cP8uzb58UxsDvrsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lOcjP2EXCONRBcqrbt5zkrB422WqcWN4nFbUcpq1VSIrMSUqz/I+eOOLH51KG4mUP
         /oR92BYvYXlmHEB9etc0pB1mRX/y2xTv1f2qEFEC4n0Gp7pci+mKwh0+oumUO+8AqU
         19i3pVPE4pHViUJpU/y4Geoo7v5Xvwx/UzBrmw1JoghVf/mnfSEM8GkZQ16jCz/OxT
         rd32ztPE31TzWNp1fPQQZ7/+tzmn0f8iRvJwebRBjnNEvCxev0kB5uV4i/Unzb3rzJ
         qzvHIsZQmPwqyFw54c6PuLhwxSluXo0SLZWczAAqyZ501d7u3/5zvTHQbzY3qryRuO
         D84MQ9hFjdAfg==
Date:   Wed, 16 Aug 2023 23:46:30 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Drew Fustini <dfustini@baylibre.com>, Fu Wei <wefu@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: change TH1520 files to dual license
Message-ID: <ZNzvVuJ9fW8xTCTN@xhacker>
References: <20230724182129.843687-1-dfustini@baylibre.com>
 <ZM9tUFddbRUglwfG@xhacker>
 <CAJF2gTT4pyAT5xpSAuOJ801WSk=xouv=uC0PSpHKqB3D=GxHsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTT4pyAT5xpSAuOJ801WSk=xouv=uC0PSpHKqB3D=GxHsg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 11:23:30PM +0800, Guo Ren wrote:
> On Sun, Aug 6, 2023 at 6:03 PM Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > On Mon, Jul 24, 2023 at 11:21:29AM -0700, Drew Fustini wrote:
> > > Modify the SPDX-License-Identifier for dual license of GPL-2.0 OR MIT.
> > >
> > > Signed-off-by: Drew Fustini <dfustini@baylibre.com>

Acked-by: Jisheng Zhang <jszhang@kernel.org>

> > > ---
> > >  arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi | 2 +-
> > >  arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts      | 2 +-
> > >  arch/riscv/boot/dts/thead/th1520.dtsi                  | 2 +-
> > >  3 files changed, 3 insertions(+), 3 deletions(-)
> > >
> > > Jisheng Zhang and Guo Ren - I thought I would post this patch based on
> > > the discussion in the thread about the BeagleV Ahead patches.
> >
> > I need Guo's ack to this patch. Hi Guo Ren, are you OK with this patch?
> I'm okay with the dual license.
> Acked-by: Guo Ren <guoren@kernel.org>
> 
> >
> > Thanks
> >
> > >
> > > Message-ID:
> > > 20230722-upstream-beaglev-ahead-dts-v1-0-ccda511357f4@baylibre.com
> > >
> > > Thanks,
> > > Drew
> > >
> > > diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> > > index 4b0249ac710f..a802ab110429 100644
> > > --- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> > > +++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> > > @@ -1,4 +1,4 @@
> > > -// SPDX-License-Identifier: GPL-2.0
> > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > >  /*
> > >   * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> > >   */
> > > diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> > > index a1248b2ee3a3..9a3884a73e13 100644
> > > --- a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> > > +++ b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
> > > @@ -1,4 +1,4 @@
> > > -// SPDX-License-Identifier: GPL-2.0
> > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > >  /*
> > >   * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> > >   */
> > > diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> > > index 56a73134b49e..ce708183b6f6 100644
> > > --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> > > +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> > > @@ -1,4 +1,4 @@
> > > -// SPDX-License-Identifier: GPL-2.0
> > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > >  /*
> > >   * Copyright (C) 2021 Alibaba Group Holding Limited.
> > >   * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> > > --
> > > 2.34.1
> > >
> 
> 
> 
> -- 
> Best Regards
>  Guo Ren
