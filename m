Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19AB7F9C85
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjK0JVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjK0JVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:21:32 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A833125
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701076900; x=1732612900;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VUSPYjDKlMwuW2JRSJ61+FAHHiwznJIqIhpJdIbiNJw=;
  b=SLz7GxyfOVYjATL3N09NuR0IVEVm7d+iH0QBMBuiHaZrAQMTClwS+xED
   dgn0tMCqzLOcvNTLeYFW1Fxc+5/K+BZWm8fwTZ30zy2VcTg4m82WCQnYA
   YUSXoCPfyVzrsHIFJJQ8bKoJFHGZLbo9rwr7nHiWnc95ZeXmCz28nQ1fW
   52Llmk7nhBXLr4g0pHS83gSgluSXeKFafPurnPf+ZnvwH5L1XtI/BIjiy
   bSrYuAIZDEO6doxR5SH/SdGankezA3Lz7dH7EbDxm0XSjdNKTNppXOgkV
   1gDu/yILwh4suvNipV4C6Yf6A1rwvJ5KtWb8BU7YZFGNzE4NWfIhvVEkH
   Q==;
X-CSE-ConnectionGUID: 8HWE/KGCT9Cu+VA5//C5YQ==
X-CSE-MsgGUID: xPwz78lvSnKAE4YDWTljVQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="asc'?scan'208";a="12324235"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Nov 2023 02:21:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Nov 2023 02:21:12 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 27 Nov 2023 02:21:10 -0700
Date:   Mon, 27 Nov 2023 09:20:41 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <conor@kernel.org>, <kernel@esmil.dk>,
        <robh+dt@kernel.org>, <emil.renner.berthing@canonical.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <leyfoon.tan@starfivetech.com>
Subject: Re: [PATCH 7/7] riscv: dts: starfive: Add initial StarFive JH8100
 device tree
Message-ID: <20231127-undying-sauciness-a5c1a2e7c89b@wendy>
References: <20231127013602.253835-1-jeeheng.sia@starfivetech.com>
 <20231127013602.253835-8-jeeheng.sia@starfivetech.com>
 <20b13322-3cd1-47b1-bb39-2710ddc59a11@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UIZ7q/jzaCkPlcNJ"
Content-Disposition: inline
In-Reply-To: <20b13322-3cd1-47b1-bb39-2710ddc59a11@kernel.org>
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

--UIZ7q/jzaCkPlcNJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 09:50:35AM +0100, Krzysztof Kozlowski wrote:
> On 27/11/2023 02:36, Sia Jee Heng wrote:

> > +	chosen {
> > +		stdout-path =3D "serial0:115200n8";
> > +	};
> > +
> > +	cpus {
> > +		timebase-frequency =3D <4000000>;
>=20
> This was fixed recently on the mailing lists.

Actually, I only fixed this for the microchip stuff, as I don't know
whether or not having this in $board.dts is valid for other cases.

As far as I understand it, this works just like regular clock nodes, so
if the clock is provided by an off-chip crystal it is okay to have it in
$board.dts, but otherwise it should go in $soc.dts.

The same applies to the jh7100/jh7110, so if you could clarify it for
that platform too, that'd be great. Doing it in response to
https://lore.kernel.org/all/20231126-attractor-swampland-b1b95bd1322b@spud/
would be great.

Thanks,
Conor.

--UIZ7q/jzaCkPlcNJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWRfZQAKCRB4tDGHoIJi
0gHWAQC+qna0EhtpL1qCEG6ofq0rMPUV6Ic0TYQILJz5IPX2AgEAgjxLKeIm8q6D
LemVXtIRAcw5kl6QPfdqlkh2VPQxrww=
=P5+r
-----END PGP SIGNATURE-----

--UIZ7q/jzaCkPlcNJ--
