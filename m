Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC67180CB59
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343676AbjLKNvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbjLKNvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:51:19 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE395AD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1702302685; x=1733838685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EPnk+1iTwI7AC2x+0wS4hbR6+o+OWWfoPlltROH9p3Q=;
  b=vSkpmzLcWjzvbRh9MNlURosyvE9zUgv7OFl3/38vfQMz61e3EMmah6a3
   5/rWn09atcnXbUN80cJ/FOfGXXS/mSFhWOSWkP4DrZfwPycfcbSOE6sbu
   i6IQXxlH0cMwMe8zGFMnh3cHGWZS/1evkuPINx3RavgdXjU2uck8ZL+x9
   VKHQF0G9BnFmyxRAitNd3XCcE45p5Iy8eD9wSR0Nppf+KET9ZZtXx81MR
   Ylv7dcUc7N3Zm3iYHbMVZxzF2P55Q200gcNnaRR/dngHisTxnTM0QaYAE
   kpu8H/jfxD+ak8YYG25wYvHevtnyyPGdNNjX6v7uyWhzBnPrsPXMDdGnZ
   A==;
X-CSE-ConnectionGUID: 022W40a+Tn+gRAO+g//8+A==
X-CSE-MsgGUID: d4MnW3q3SBu85cF5m2EhcA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="asc'?scan'208";a="180280039"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Dec 2023 06:51:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 06:50:44 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 11 Dec 2023 06:50:43 -0700
Date:   Mon, 11 Dec 2023 13:50:12 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Nam Cao <namcao@linutronix.de>
CC:     Jia Jie Ho <jiajie.ho@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: Kconfig: Add select ARM_AMBA to SOC_STARFIVE
Message-ID: <20231211-grumble-haphazard-e95ab97e0e57@wendy>
References: <20230525061836.79223-1-jiajie.ho@starfivetech.com>
 <20231128102722.fQizGKfo@linutronix.de>
 <20231128-grandma-guru-4fc6e6950a75@wendy>
 <20231211143611.5d0248bf@namcao>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/CfqRG+3NaUoxF3y"
Content-Disposition: inline
In-Reply-To: <20231211143611.5d0248bf@namcao>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--/CfqRG+3NaUoxF3y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 02:36:11PM +0100, Nam Cao wrote:
> On Tue, 28 Nov 2023 10:59:44 +0000 Conor Dooley <conor.dooley@microchip.c=
om> wrote:
> > On Tue, Nov 28, 2023 at 11:27:22AM +0100, Nam Cao wrote:
> > > On Thu, May 25, 2023 at 02:18:36PM +0800, Jia Jie Ho wrote: =20
> > > > Selects ARM_AMBA platform support for StarFive SoCs required by spi=
 and
> > > > crypto dma engine.
> > > >=20
> > > > Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> > > > ---
> > > >  arch/riscv/Kconfig.socs | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >=20
> > > > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > > > index 1cf69f958f10..381cd46e6373 100644
> > > > --- a/arch/riscv/Kconfig.socs
> > > > +++ b/arch/riscv/Kconfig.socs
> > > > @@ -29,6 +29,7 @@ config SOC_STARFIVE
> > > >  	bool "StarFive SoCs"
> > > >  	select PINCTRL
> > > >  	select RESET_CONTROLLER
> > > > +	select ARM_AMBA
> > > >  	help
> > > >  	  This enables support for StarFive SoC platform hardware. =20
> > >=20
> > > I'm considering sending this to stable trees. Without this, it is not
> > > possible to configure the kernel with SPI driver for the starfive boa=
rd.
> > >=20
> > > I just want to check with you first, in case I miss something obvious.
> > > Any objection to backporting this patch? =20
> >=20
> > Personally I would be okay with that, otherwise the driver is dead code
> > in those stable versions. Just be sure that the rename of some pl011
> > variables (I think that's what it was) that was a pre-req for this being
> > merged is in said versions of stable. An allmodconfig should flag
> > whether that has happened pretty quickly.
>=20
> Thanks for the info. I think I found what you are talking about:
> a1a5f2c88725 ("dmaengine: pl330: rename _start to prevent build error")
>=20
> It's been a while and no one else said anything, so I am going forward wi=
th
> this.

Yeah, that's the one. Sorry that I did not recall correctly.

--/CfqRG+3NaUoxF3y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXcTlAAKCRB4tDGHoIJi
0tSPAP0fomHmi7YWds0F/oHh3hVM4oN/K4hsf7KhyN6R6KXa7wD9FjJRHv9kYkrc
Hg2vmv/mB1FHAe7vdrFoRjf7hzLJYQc=
=+aPE
-----END PGP SIGNATURE-----

--/CfqRG+3NaUoxF3y--
