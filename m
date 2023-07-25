Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DB5760C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjGYHou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjGYHop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:44:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCA0DA;
        Tue, 25 Jul 2023 00:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690271084; x=1721807084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GkLqQ6DAg/UKQuy+uWECAwtfkMKE2HdTGALC1tF0kGs=;
  b=zCMFL38670WYMXpQTHH82cNVGSxsbT2hBKAcBdIzVOOgeh1zCZTa8905
   4WrIkGKtebYJit3xNv08XYB48mME9HERFhgH9rbsIb1m/2020GeetpW8s
   Lr1VreBreMQwz7uaC75HI55qpfPltNQ50MRA9ksPC9JIsbLawuKTt2SWF
   cJAxhaCvuxi9qWRoHVd0vbZHT7ClKmTi3VbcglajjxZEjKkEa4UGE/am4
   jwRfSheJjoRXo4Dd0Zaw0R9UQ3df8lzOnEtHfQC7d8ZZTHnugeHenHimh
   YNAzDkt3EzwXTK/WTfjbEutqE4v6rdGuWKcpqvxdxcm7JX13BLSKbyNmv
   A==;
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="asc'?scan'208";a="237576831"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jul 2023 00:44:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 25 Jul 2023 00:44:42 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 25 Jul 2023 00:44:40 -0700
Date:   Tue, 25 Jul 2023 08:44:06 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Samin Guo <samin.guo@starfivetech.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>
Subject: Re: [-next v1 1/1] riscv: dts: starfive: visionfive 2: Add v1.3B
 gmac phy configuration
Message-ID: <20230725-rental-struck-d49a18d1c382@wendy>
References: <20230725073039.14382-1-samin.guo@starfivetech.com>
 <20230725073039.14382-2-samin.guo@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Gtc3Rp2UzxbWAgFm"
Content-Disposition: inline
In-Reply-To: <20230725073039.14382-2-samin.guo@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Gtc3Rp2UzxbWAgFm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 03:30:39PM +0800, Samin Guo wrote:
> Add visionfive 2 v1.3B gmac phy configuration, including drive strength
> and inverting configuration.
>=20
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Samin Guo <samin.guo@starfivetech.com>

I opted to squash this (and my temporary revert that becomes a NOP) into
the original patch. It should appear in linux-next tomorrow as 0104340a67b1
("riscv: dts: starfive: visionfive 2: Add configuration of gmac and phy").

Thanks,
Conor.

--Gtc3Rp2UzxbWAgFm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL99RgAKCRB4tDGHoIJi
0tXtAP9Ky4whbpfoJQYqSCSbEjzqKFKnZ3OObobEooJ0DczHqAEA/ADUDL0f+5tB
8g3hgSIQ+p70NnxwTPSaYMzK5/JqLwc=
=G3zZ
-----END PGP SIGNATURE-----

--Gtc3Rp2UzxbWAgFm--
