Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BC777C87D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 09:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbjHOHW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 03:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbjHOHWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 03:22:02 -0400
X-Greylist: delayed 572 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Aug 2023 00:22:00 PDT
Received: from pokefinder.org (pokefinder.org [135.181.139.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A347106
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:22:00 -0700 (PDT)
Received: from localhost (i5E861B55.versanet.de [94.134.27.85])
        by pokefinder.org (Postfix) with ESMTPSA id 759AFA42767;
        Tue, 15 Aug 2023 09:12:27 +0200 (CEST)
Date:   Tue, 15 Aug 2023 09:12:22 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: linux-next: manual merge of the i2c tree with the i2c-host-fixes
 tree
Message-ID: <ZNslVp/UM1EUeOBi@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@the-dreams.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andi Shyti <andi.shyti@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>
References: <20230815115735.04151abc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yhGoVvIyYezAhEqi"
Content-Disposition: inline
In-Reply-To: <20230815115735.04151abc@canb.auug.org.au>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yhGoVvIyYezAhEqi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stepehn,

> from the i2c-host-fixes tree and commit:

I think it makes sense to drop i2c-host-fixes and i2c-host from
linux-next again. Andi kindly helped out while I was on an unplanned
hiatus. But now I will populate my own branches again (with largely
pulling in Andi's branches). Thank you for the quick inclusion of his
branches and to Andi for helping out!

All the best,

   Wolfram


--yhGoVvIyYezAhEqi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmTbJVIACgkQFA3kzBSg
KbaxwBAAqNp1/PRqHX68aMHTn8M1SnhMV/te8LSD/QQ74BkNcnMCBwnIIF8KHfCB
0kW72Pls9f4F3NVr6j2oM9pU/hhoCu2ByHMYwC+V4ohaOsF/T3KHtZAv/XM/J9Sw
glBMHgmI84bc/lKrbLaFfkRv5WCRqPPWb495Q9BoWEdF7kkidCyNJgQyK2mI6T71
NstQZKhO6uCvY+LxQsCgQ7LmVmJbmi94N3yjfC2ujYiw+iBzBYhDmMIaRh/imirf
LLcHS/u0pNueX/2jwcbPA9hFdZJpG+bO9SIWj8TRHiJJRdFIy+RMXB74eDRB08Kq
NPE3zR2U/tulwlQccg+YJp8ALW9NAcvAApGKnVb25Pc9IyfKnx30AGbX3whU2FzS
0KQIiLvi1y1DEYVTdWkefGlHDZ2QwJW+g3VOhNt9gVe1QSGBZYYY823EtQvLtHb6
p/H6513uvUyFXr7nsJ9WkoUvSTPvWiRCTfjObhEC9rBsYcONgr+oTTU2cGXuSkTO
fj0J2dXi+2jmudRgDffAKap7Hc620e+JkGI/rsu0einr/H/bsvHCRtjoaJCi+Eaf
668xp1fhU0W4ygh+2+NJ+52/3dDZ/xbKNMtWSqsS7DvEw9dX/7Of81Uwm1TmuVRI
xX3SIgaU20xW03trY1QPj0i0UcKRTjsmT8rKP8djJPEQRpsKYbs=
=O46B
-----END PGP SIGNATURE-----

--yhGoVvIyYezAhEqi--
