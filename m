Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803BF763664
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjGZMea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjGZMe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:34:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFC01BF8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690374868; x=1721910868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w29lViVVWh93yAhWfMgQLPne+qNTAAPnp+PikDVun/A=;
  b=XeskO17c+HlnLLJGbhfxj6DSt9wYkkokIv+99GXHhtAgNbZHLo3XPnzf
   Aed1IHG8BOz2O52iu0PkPIiQn+RfHezbpJ/qsrVqk/I1CAAPwEAX13OZx
   qv06h6V86C/RcAxrlpq9j5XQXNQQHPHrBeL6mhlJ4Z/r+mu/pWgz66M3J
   BswA3gzZ3oFpidWqd6SdQ6t4SMWvt+iPR/Exdrn7X9vKHU1oLIHlQxbY7
   CFry0xAe811+nk3woSTP/y/s5XIsc0jKO+/fxH3KrnoFvN81iqz7rViHo
   68JdFYshSUzsAlbSIGWSaNLAF7KIMATPH0nuPIvGinJyfyh9sMABKGRxR
   w==;
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="asc'?scan'208";a="222314247"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jul 2023 05:34:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 26 Jul 2023 05:34:26 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 26 Jul 2023 05:34:25 -0700
Date:   Wed, 26 Jul 2023 13:33:50 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Walker Chen <walker.chen@starfivetech.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Emil Renner Berthing <kernel@esmil.dk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] soc: starfive: remove stale Makefile entry
Message-ID: <20230726-target-flashy-b9033ea36ae4@wendy>
References: <20230726121724.3701240-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gXVSTWIiPan783iD"
Content-Disposition: inline
In-Reply-To: <20230726121724.3701240-1-arnd@kernel.org>
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

--gXVSTWIiPan783iD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 02:17:14PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> After the only starfive driver was moved out to the genpd subsystem, we g=
et
> a build failure:
>=20
> scripts/Makefile.build:41: drivers/soc/starfive/Makefile: No such file or=
 directory
>=20
> Fixes: f3fb16291f486 ("soc: starfive: Move the power-domain driver to the=
 genpd dir")

> Reported=3Dby: kernel test robot <lkp@intel.com

There's a - & a missing > in this tag.
Otherwise,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reminds me, I need to also send a patch moving the Kconfig entry &
delete the directory and MAINTAINERS entry.

Thanks,
Conor.

--gXVSTWIiPan783iD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMESrgAKCRB4tDGHoIJi
0hG/APi7RD4ltJa59IyiS5HgQzpoPOPwKwklVaw8IEhW9rUGAP4x2TY3Th/Q6kuh
8bA26LSSvdug7PW5jGR6o13ys97KAg==
=uy78
-----END PGP SIGNATURE-----

--gXVSTWIiPan783iD--
