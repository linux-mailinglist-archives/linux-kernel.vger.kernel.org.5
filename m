Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C5B75F2FC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjGXKYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbjGXKX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:23:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ACF4C3F;
        Mon, 24 Jul 2023 03:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690193850; x=1721729850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N9j/ubjb14KYeVTqGuXmeyX8gTse+DRrHNcAXBsXH/M=;
  b=cYscqBdWq+NDMk9OiYDl294EP4NLV15CRBLB/yV4/2hrcAku+QCeKZcD
   hm9yxS/pfQnmp6j4Ef+MIzudegc/qIVe0Z+/PMDDBDCo779dNcTzscAPU
   2VQtKjzMTqfGYhvuC8opsylKUrXmt1lHxptj4uuab7k+fWABPRMiNKZu3
   BGPTuIoDySmaY5JJMv9Bcy1uk7fHwR1IASj1vhyvYJBZHuCIqyWZJbmAU
   2W2IkaR/oy0MzvUY5ACWOkdQa7iASgeslBiKb9f9rDcmGfD2xZ9lUCVAm
   eUfb4dTlVUqyDcNyRZnD2gfnm4YnzQ1kLQv/VfdpPrb7EaD1tO4IQyCQV
   w==;
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="asc'?scan'208";a="221852815"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jul 2023 03:17:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 24 Jul 2023 03:17:27 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 24 Jul 2023 03:17:25 -0700
Date:   Mon, 24 Jul 2023 11:16:51 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
CC:     <linux-riscv@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v1] reset: starfive: jh7110: Add StarFive STG/ISP/VOUT
 resets support
Message-ID: <20230724-junkman-dominion-5a0ccfa0ba11@wendy>
References: <20230724055440.100947-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8I5cd4AYGkoQ6umA"
Content-Disposition: inline
In-Reply-To: <20230724055440.100947-1-xingyu.wu@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--8I5cd4AYGkoQ6umA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2023 at 01:54:40PM +0800, Xingyu Wu wrote:
> Add new struct members and auxiliary_device_id of resets to support
> System-Top-Group, Image-Signal-Process and Video-Output on the StarFive
> JH7110 SoC.
>=20
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>=20
> Hi Stephen,
>=20
> I found that the PR sent by Conor was missing this STG/ISP/VOUT
> resets patch:
> https://lore.kernel.org/all/20230719-trough-frisk-40b92acb485a@spud/
>=20
> I resend this patch to make the CRG drivers completed.

The context here being that I did not realise that the reset patch also
depended on the dt-binding headers & thought it could go separately.

--8I5cd4AYGkoQ6umA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL5PkwAKCRB4tDGHoIJi
0uG7AP4idzqiMp3mx7axRB5CH1pm7aQqGrsKI1ov2Rtr/2eW/AD+LiCS9ZYRQ81r
9m/rPkMhd7Jtl8YQ2z+Ifo63IZdjTgM=
=2j3k
-----END PGP SIGNATURE-----

--8I5cd4AYGkoQ6umA--
