Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FE77CA96A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjJPNar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbjJPNaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:30:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0000120
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1697463034; x=1728999034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L74gHPCkBuK8xNMGAh1zvXNAucTnSwRTolNX+SQdDIY=;
  b=kTNiQj9IqdpG00yd//WZ0q7/yMJHRmLnNeey4Ou/6USs3hk6llfEmEQE
   A6RNS1dgjJURVBpaQ/E6yjv1kHyxxDoBRdkfEttW4sYuOhrenalcY3l8P
   hXfOZelvZnBkNSoNOwXy1KwCBfjtqHJkCA2MRCb7z2Mg1z7NPyZlC1u/F
   sfwvKXPaFXliyZIxRMpvslKvfqMY9V4G4a7SSVMRb0jBq+ZxLE0WSqaDR
   Mzy8mjflJsm/Hq9WeQxTEzjFuvgoKl9FnneDEZ9xp0kmPK91fof2WL+i0
   +G/XCO+xwrZssNqsbCZiHmQXGv4qDRVYqBdnmr3kASV6FFYdHXTo04nMo
   g==;
X-CSE-ConnectionGUID: 6cXb+oOzSa6V6Bq0KOVSUA==
X-CSE-MsgGUID: LgC+lP7BTB+nfnKJPbMbig==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="asc'?scan'208";a="10554384"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2023 06:30:34 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 16 Oct 2023 06:30:30 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 16 Oct 2023 06:30:29 -0700
Date:   Mon, 16 Oct 2023 14:30:07 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Nam Cao <namcao@linutronix.de>
CC:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: Kconfig: Add select ARM_AMBA to SOC_STARFIVE
Message-ID: <20231016-scrunch-sabotage-27e12b446c47@wendy>
References: <20230525061836.79223-1-jiajie.ho@starfivetech.com>
 <20230709-rundown-unsettled-403e8bf5cca5@spud>
 <20231016132613.m8o1+AMG@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MWRFTSvKhAmZnZ/b"
Content-Disposition: inline
In-Reply-To: <20231016132613.m8o1+AMG@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MWRFTSvKhAmZnZ/b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 03:26:13PM +0200, Nam Cao wrote:
> On Sun, Jul 09, 2023 at 11:10:47PM +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > On Thu, 25 May 2023 14:18:36 +0800, Jia Jie Ho wrote:
> > > Selects ARM_AMBA platform support for StarFive SoCs required by spi a=
nd
> > > crypto dma engine.
> > >=20
> > >=20
> >=20
> > Applied to riscv-soc-for-next, thanks!
> >=20
> > [1/1] riscv: Kconfig: Add select ARM_AMBA to SOC_STARFIVE
> >       https://git.kernel.org/conor/c/1fcaaa1d489c
> >=20
> > Thanks,
> > Conor.
>=20
> Sorry if it's a stupid question, but did this patch get lost somehow? It
> hasn't made it to Linus's tree, and there is this message in your tree:
> "Notice: this object is not reachable from any branch."

No, it is not a stupid question sadly. I screwed up and forgot to send a
PR for that branch to Arnd, only realising _after_ the merge window had
closed already. It'll be in 6.7, the branch got rebased so the hash is
no longer valid.

--MWRFTSvKhAmZnZ/b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZS063wAKCRB4tDGHoIJi
0qJPAP4xIZq34xZVWYByUGebA+um/WpfShd4dQRjxtzcfVPaBwD/dI/ACmp8MGZU
ycygHR0nvv/4WtirGpx8EI2eKvabOgo=
=/5xt
-----END PGP SIGNATURE-----

--MWRFTSvKhAmZnZ/b--
