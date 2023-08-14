Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B0E77BD9E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjHNQHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjHNQGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:06:53 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798A712D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:06:51 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37EG6XiI027678;
        Mon, 14 Aug 2023 11:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692029193;
        bh=ZNQJo806xcMlqEDUrZ0eN5yXZDBMlZETHefxKr8T9e4=;
        h=Date:From:To:CC:Subject;
        b=tCG7OaUznYM/NXFrl9BBSlUKyYpQGjLyODUAY+YnVVLMsAw4Ae4Oz/8IPEYQaDoU3
         k/DbimvpIG7h9/tIQLRbVUzkMYEhTSzhe3kSU/VRRcvqUhOzr1+XcW68tm2SV9ECjl
         R3GiCO1LVyrYwteWbrQwLpxYbNFzIhWZxJPP1JNM=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37EG6XJU077070
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Aug 2023 11:06:33 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Aug 2023 11:06:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Aug 2023 11:06:33 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37EG6Xdb001740;
        Mon, 14 Aug 2023 11:06:33 -0500
Date:   Mon, 14 Aug 2023 11:06:33 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Arnd <arnd@arndb.de>, Olof <olof@lixom.net>, SoC <soc@kernel.org>
CC:     <arm@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/4] soc: ti: Driver updates for v6.6
Message-ID: <20230814160633.my3xbk5k2pxkvjyi@degrease>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cyhyynyyddn4vzug"
Content-Disposition: inline
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--cyhyynyyddn4vzug
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please pull:

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-driv=
er-soc-for-v6.6

for you to fetch changes up to 443012dd31e5939cb53bc9c5713d32d87321b0d8:

  soc: ti: k3-socinfo.c: Add JTAG ID for AM62PX (2023-08-11 16:01:09 -0500)

----------------------------------------------------------------
TI SoC driver updates for v6.6

- Generic fixups: Explicitly include correct DT include.
- omap_prm: Cosmetic fixups for using devm_ api for ioremap_resource
- ti_sci: Documentation fixups, Using system_state to determine if
  polling is needed.
- k3-ringcc: Documentation fixups, cleanup of log messages, using
  devm_ to handle ioremap_resource.
- k3-socinfo: Add AM62PX detection.

----------------------------------------------------------------
Jayesh Choudhary (1):
      soc: ti: k3-ringacc: remove non-fatal probe deferral log

Nishanth Menon (3):
      firmware: ti_sci: Use system_state to determine polling
      firmware: ti_sci: Fixup documentation errors
      soc: ti: k3-ringacc: Fixup documentation errors

Rob Herring (1):
      soc: ti: Explicitly include correct DT includes

Vignesh Raghavendra (1):
      soc: ti: k3-socinfo.c: Add JTAG ID for AM62PX

Yangtao Li (1):
      soc: ti: omap-prm: Use devm_platform_get_and_ioremap_resource()

Zhang Zekun (1):
      soc: ti: Use devm_platform_ioremap_resource_byname simplify logic

 drivers/firmware/ti_sci.c        | 49 ++++++++----------------------------=
----
 drivers/soc/ti/k3-ringacc.c      | 31 +++++++++----------------
 drivers/soc/ti/k3-socinfo.c      |  1 +
 drivers/soc/ti/omap_prm.c        | 13 ++++-------
 drivers/soc/ti/pruss.c           |  4 +++-
 drivers/soc/ti/ti_sci_inta_msi.c |  3 ++-
 6 files changed, 30 insertions(+), 71 deletions(-)
--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--cyhyynyyddn4vzug
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmTaUQEACgkQ3bWEnRc2
JJ2B9hAApsvr/ZgVT2TXkGx+lA3lBcv4RMyXW1ib1SVFbJh33IYRPz+2IDUgd0la
zlYWIIIDAwAKsLWqsP+BJsPZP3wMp7Tp6QdMUk4o4S/rSPOJza1SoHdVAnS1sXt5
wx4+gRHdyhkEqd+CMiAyfUh4AZDP70LBFP1Cxp7f7e33KxU7XiNH+eOEUJC/R53b
AZ8OHXSBYXoZIv3s4gg5Q64wlEiQwgHy4uBJtCjT7qmW5xrlVLKi3H0MURFXmd53
TB0oREazBUvanXrICSVaR42GFcLvLS6urqt0f9A3LQEYJh/D9XdEFPbkQb4RHdpw
/6jQZ82pXIioI868Ko9yCQnedFOFpz/PuCD1DJecdKZw/SgsH6zoGde9smmaja2F
Nkpttv1Hx6Joth+WvQ06/YFvwsFirbXwU/K6/ShpGnp3W7X26H9buOJwYpXYvpO7
hNOAxCflqwwnvBaDUKdJb23NNxzDOOWMDqdkkRSAgMWNC1WfZ15gucPQtAZ08/Ae
/vlyzupEYPM7ZQQPpczr6Gy1/ZjrWD8+QqfGxB9YdtYjSd3jBexFjdEzfemNbjHd
m/IkYbnAxf71ySzqWH72wtFjDbxSOivHRi7H7ogrlpHqCjnzqHTTosyzZutBiydt
TIZZsm1hh9w/DRLytnMOvo5l33WlXnRpLUbMa09/C5iJZVxcbZw=
=gZa2
-----END PGP SIGNATURE-----

--cyhyynyyddn4vzug--
