Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49217AF70B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 02:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjI0AHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 20:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjI0AFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 20:05:05 -0400
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472E99011;
        Tue, 26 Sep 2023 16:22:23 -0700 (PDT)
Received: from [192.168.68.112] (ppp118-210-175-231.adl-adc-lon-bras34.tpg.internode.on.net [118.210.175.231])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6B2562017B;
        Wed, 27 Sep 2023 07:22:14 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1695770536;
        bh=3xy3oYvGG7Rgvu7rXIPqMIaHFUEefO32BL/5JeivFsM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Nc1pzZmuL8BIfPa9WmVMAMK3q2oPyV6epmFy5ihSOS5smQ+L7+AvhVpWriHV8/ZLh
         uwSAqCUSfyLQ0xjfIj+vnu82oGAWij+2M3B2+zL1W/seZW/cqQHT6ST4I1+8hPC4XX
         Mdh6X04rt5eSwtTilUak5akhIQdszckz7bT2nTcbGco+CTlM1GBDShPol1EvR0ujCT
         tQY6fR69A9K80khCkl/Sl/e02bi+59zFMnyMllUCSmiNtqNSPEiNicMBTjSPerc4Xa
         erf4KHlO8DG2rj61hMoz2nnTmU3GdAci354zUOMDSndkpfgRveeh5GE7MUA2FWxBsd
         I3MhVR3d7j5tg==
Message-ID: <7a7d5a7f19fc793f157508fec7fbc09ca8c4cc4b.camel@codeconstruct.com.au>
Subject: Re: [PATCH] MAINTAINERS: aspeed: Update Andrew's email address
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     joel@jms.id.au, andrew@aj.id.au, linux-aspeed@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Date:   Wed, 27 Sep 2023 08:52:09 +0930
In-Reply-To: <CAPDyKFrFxYxSTa=z2VnCk4m_d-wEgd17wBokzyNCCRLtSUnFKw@mail.gmail.com>
References: <20230925030647.40283-1-andrew@codeconstruct.com.au>
         <CAPDyKFrFxYxSTa=z2VnCk4m_d-wEgd17wBokzyNCCRLtSUnFKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-26 at 17:03 +0200, Ulf Hansson wrote:
> On Mon, 25 Sept 2023 at 05:07, Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
> >=20
> > I've changed employers, have company email that deals with patch-based
> > workflows without too much of a headache, and am trying to steer some
> > content out of my personal mail.
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
>=20
> I guess it doesn't really matter what tree this gets funneled through,
> so I decided to pick this up via my mmc tree.
>=20
> So, applied for next, thanks!

Ah, thanks for being so prompt! However, Joel has sent a PR to Arnd
with the patch:

https://lore.kernel.org/all/CACPK8Xc+D=3DYBc2Dhk-6-gOuvKN0xGgZYNop6oJVa=3DV=
NgaEYOHw@mail.gmail.com/

I thought I'd left a note under the fold asking Joel to do that so
people knew how it would get into the tree, but that clearly isn't the
case. Sorry about that, I must have rolled the patch off again after I
put the note into the original.

Andrew

>=20
> Kind regards
> Uffe
>=20
>=20
> > ---
> >  MAINTAINERS | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index b19995690904..1965cee433b0 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1963,7 +1963,7 @@ F:        drivers/irqchip/irq-aspeed-i2c-ic.c
> >=20
> >  ARM/ASPEED MACHINE SUPPORT
> >  M:     Joel Stanley <joel@jms.id.au>
> > -R:     Andrew Jeffery <andrew@aj.id.au>
> > +R:     Andrew Jeffery <andrew@codeconstruct.com.au>
> >  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscri=
bers)
> >  L:     linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
> >  S:     Supported
> > @@ -3058,7 +3058,7 @@ F:        Documentation/devicetree/bindings/peci/=
peci-aspeed.yaml
> >  F:     drivers/peci/controller/peci-aspeed.c
> >=20
> >  ASPEED PINCTRL DRIVERS
> > -M:     Andrew Jeffery <andrew@aj.id.au>
> > +M:     Andrew Jeffery <andrew@codeconstruct.com.au>
> >  L:     linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
> >  L:     openbmc@lists.ozlabs.org (moderated for non-subscribers)
> >  L:     linux-gpio@vger.kernel.org
> > @@ -3075,7 +3075,7 @@ F:        drivers/irqchip/irq-aspeed-scu-ic.c
> >  F:     include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
> >=20
> >  ASPEED SD/MMC DRIVER
> > -M:     Andrew Jeffery <andrew@aj.id.au>
> > +M:     Andrew Jeffery <andrew@codeconstruct.com.au>
> >  L:     linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
> >  L:     openbmc@lists.ozlabs.org (moderated for non-subscribers)
> >  L:     linux-mmc@vger.kernel.org
> > --
> > 2.39.2
> >=20

