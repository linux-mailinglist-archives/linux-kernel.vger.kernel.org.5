Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC3078F888
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 08:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348377AbjIAGZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 02:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjIAGZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 02:25:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517F810DD;
        Thu, 31 Aug 2023 23:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693549486; x=1725085486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QRNW0mmcEm0U5hthS099MEK7qNzHYNv/4Or5oaKKF7I=;
  b=J27EOgqO2O8OyumegRjVqQz9g9LySxdA7ctiKQaVgSGpb54Hb72/k8cm
   +5HskjY1LbTPqxL0e8dsErh/V4xYs47t9Y/4HxEbPJebbbYyY6TM0eUZ1
   UQjXsrAKMwW6plHx7GW5BsbNkD6p6p2wJTqPkzfeyzMH7B+k6PHO/FpVI
   rWwOKjbVtM3ig62I/p8tUeNLHbw2A+zQHYjiAZ47bcx6Ei50l3qCGlQBD
   xqDFsf1xLkHSg43EwZL23WdXeh6AFXbJzjW7iT7Cr5RB8Y2c95aOPs5+Y
   CRzlLAZMey0DF8fidlRPd1ro1WLpThxHdcOzSCrWiINZZEQ3SQi1jS1yE
   w==;
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="asc'?scan'208";a="2393948"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Aug 2023 23:24:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 31 Aug 2023 23:24:40 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 31 Aug 2023 23:24:38 -0700
Date:   Fri, 1 Sep 2023 07:23:56 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: linux-next: Tree for Aug 31 (riscv: ANDES errata)
Message-ID: <20230901-headed-unsigned-794833b7b5d5@wendy>
References: <20230831135535.13c67178@canb.auug.org.au>
 <33a5e278-fb4b-b5db-e4f6-bb5a1e4228ef@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pyMsjv/SDk+2OvlN"
Content-Disposition: inline
In-Reply-To: <33a5e278-fb4b-b5db-e4f6-bb5a1e4228ef@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--pyMsjv/SDk+2OvlN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 10:33:40PM -0700, Randy Dunlap wrote:
>=20
>=20
> On 8/30/23 20:55, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Please do *not* include material destined for v6.7 in your linux-next
> > included branches until *after* v6.6-rc1 has been released.  Also,
> > do *not* rebase you linu-next included branches onto v6.5.
> >=20
> > Changes since 20230830:
> >=20
> > The risc-v tree gained conflicts aginst Linus' tree.
> >=20
>=20
> On risc-v 32-bit or 64-bit, when CONFIG_MMU is not set:

lkp reported this yesterday too, Prabhakar is conjuring up a fix.

Thanks Randy for the report,
Conor.

--pyMsjv/SDk+2OvlN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZPGDWAAKCRB4tDGHoIJi
0geaAP948UleALoWfE9W0GAqY18T27FIepedxZnpl8hSeGrJlgD+OoY4l9Nzo3lu
qaYzaBi5aPCWlPxu/HoaxKR8Ypl1ugg=
=fh9/
-----END PGP SIGNATURE-----

--pyMsjv/SDk+2OvlN--
