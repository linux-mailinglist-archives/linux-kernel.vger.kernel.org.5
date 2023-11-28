Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130387FB8C3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344428AbjK1LAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344413AbjK1LAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:00:13 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDD4197
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701169219; x=1732705219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ju4q9Np0g+GExAiNW7U8BnmxssgNRro0n3fZCX/XO0E=;
  b=iSVb3kG220hmciz30HX9KBYdvIkA15Bhk3tfDhBgsC90KgVVPfdc5ckl
   Wv17M9MnVxcu3gOnkDIAt3dfztZAf+FTQwHew6mR0EnFEkGpVoN/GMymI
   giVC00hd7lnFcFJFJrlOuHcbtHhYE8ih91qNKpCNjS2DSrdghkjp/qiN3
   +/kbqLzs2Q/w5GWkKFmxvlejo0QRqXP5HCrBLCh6k0jP5M5awCITczk+c
   w+Rd+SoGujSZ8LnlAv6yxIz+3Yad64eP2Hgl6uE96/KdKOUMSF3jc1KPG
   8bDBX3k0jJoPyharZ7H2hWdQF8o0192UJfmSZ1aqqjgHNybKyWvaFcAWB
   g==;
X-CSE-ConnectionGUID: FuQ6AW+5TlCMn49POgamoQ==
X-CSE-MsgGUID: 4qyKv6pGQZm7ZXNIOjqjwQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="asc'?scan'208";a="243074126"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Nov 2023 04:00:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Nov 2023 04:00:14 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 28 Nov 2023 04:00:12 -0700
Date:   Tue, 28 Nov 2023 10:59:44 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Nam Cao <namcao@linutronix.de>
CC:     Jia Jie Ho <jiajie.ho@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: Kconfig: Add select ARM_AMBA to SOC_STARFIVE
Message-ID: <20231128-grandma-guru-4fc6e6950a75@wendy>
References: <20230525061836.79223-1-jiajie.ho@starfivetech.com>
 <20231128102722.fQizGKfo@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="omVPbJ2Lyr3mnpXp"
Content-Disposition: inline
In-Reply-To: <20231128102722.fQizGKfo@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--omVPbJ2Lyr3mnpXp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 11:27:22AM +0100, Nam Cao wrote:
> On Thu, May 25, 2023 at 02:18:36PM +0800, Jia Jie Ho wrote:
> > Selects ARM_AMBA platform support for StarFive SoCs required by spi and
> > crypto dma engine.
> >=20
> > Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> > ---
> >  arch/riscv/Kconfig.socs | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > index 1cf69f958f10..381cd46e6373 100644
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -29,6 +29,7 @@ config SOC_STARFIVE
> >  	bool "StarFive SoCs"
> >  	select PINCTRL
> >  	select RESET_CONTROLLER
> > +	select ARM_AMBA
> >  	help
> >  	  This enables support for StarFive SoC platform hardware.
>=20
> I'm considering sending this to stable trees. Without this, it is not
> possible to configure the kernel with SPI driver for the starfive board.
>=20
> I just want to check with you first, in case I miss something obvious.
> Any objection to backporting this patch?

Personally I would be okay with that, otherwise the driver is dead code
in those stable versions. Just be sure that the rename of some pl011
variables (I think that's what it was) that was a pre-req for this being
merged is in said versions of stable. An allmodconfig should flag
whether that has happened pretty quickly.

--omVPbJ2Lyr3mnpXp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWXIHwAKCRB4tDGHoIJi
0tIeAP0Qk6kC+Ph4/2dh6HoswPR2MR7gF+g4jYowYymzMnpjGgD/Ta9CcqG6AtL4
G2djjaaTDhNFaiNDoiAAcZ7Y62SUCA8=
=Ertc
-----END PGP SIGNATURE-----

--omVPbJ2Lyr3mnpXp--
