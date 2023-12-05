Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FAD80533F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347011AbjLELnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345199AbjLELna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:43:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E6E12C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:43:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CE7C433C7;
        Tue,  5 Dec 2023 11:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701776616;
        bh=CE6KeruqrweCASUNRj8l3NLAhaKiE9f+ajaLD7DyzBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tzp0bQy6ill/5Yq+AC7k8iQCH1KHRHVfvkhah1vGJwEKH5ovVNCBJp4I6ofLo6hYr
         Ie94/fThn7xf7CtrHcSFMaQ3deb4YeuHNQUCqWuxy0IQA+rtXNA5qxbB62POxCVp35
         bvLi+EYZB8o890DOe8DZCeBv/TVtSOi6nryNFJTXmQ19t5NM0XQPpKkieBCtDSMHT9
         PrqpDpettFvwg7nC2y+DT8pByqdSpqAhfoi2goCg2OL8qVY2pyz18ppWYC3DtqVKie
         Y9CsM+Kb+rTVv7ZXlz0IywVyV5cREH3QVnyZLeEj3pKjoRGz2qLfmH602uBGYVKrFe
         TXBlHzlcPEZBA==
Date:   Tue, 5 Dec 2023 12:43:33 +0100
From:   "mripard@kernel.org" <mripard@kernel.org>
To:     Donald Robson <Donald.Robson@imgtec.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexander.sverdlin@siemens.com" <alexander.sverdlin@siemens.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kristo@kernel.org" <kristo@kernel.org>, "nm@ti.com" <nm@ti.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        Sarah Walker <Sarah.Walker@imgtec.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62-main: Add GPU device node
Message-ID: <jjndcpbk7g6quyusdd3yz42gjh7szkzyj4wlrs3tjl7bh6nmvn@ge5i75ywjtv7>
References: <20231204121522.47862-1-donald.robson@imgtec.com>
 <c20b213534667337f08b75a6c325fafec6526135.camel@siemens.com>
 <6e71745a9258ecd384261369656dd05da5ab10fa.camel@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5jesdngv6qe6kcit"
Content-Disposition: inline
In-Reply-To: <6e71745a9258ecd384261369656dd05da5ab10fa.camel@imgtec.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5jesdngv6qe6kcit
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 11:26:04AM +0000, Donald Robson wrote:
> Hello Alexander,
>=20
> On Tue, 2023-12-05 at 11:15 +0000, Sverdlin, Alexander wrote:
> > Hi Donald, Sarah et al,
> >=20
> > thanks for the patch!
> >=20
> > On Mon, 2023-12-04 at 12:15 +0000, Donald Robson wrote:
> > > From: Sarah Walker <sarah.walker@imgtec.com>
> > >=20
> > > Add the Series AXE GPU node to the AM62 device tree.
> > >=20
> > > Signed-off-by: Sarah Walker <sarah.walker@imgtec.com>
> > > Signed-off-by: Donald Robson <donald.robson@imgtec.com>
> >=20
> > powervr fd00000.gpu: [drm] loaded firmware powervr/rogue_33.15.11.3_v1.=
fw
> > powervr fd00000.gpu: [drm] FW version v1.0 (build 6503725 OS)
> > [drm] Initialized powervr 1.0.0 20230904 for fd00000.gpu on minor 0
> >=20
> > In general it allows the driver to be probed on TI AM625 EK, so
> > Tested-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>=20
> Thanks!
>=20
> >=20
> > But I'm not sure if you maybe want to disable it by default like
> > other HW blocks for the (potential) boards which don't have video at al=
l.
>=20
> Nor I. I guess it should still be enabled so it can be used for compute?

It's standalone and doesn't require any additional (or external)
resources that boards could just ignore.

So there's no real reason to disable it, ever.

Maxime

--5jesdngv6qe6kcit
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZW8M5QAKCRDj7w1vZxhR
xUV5APsF4CIS8KQJYG8CEcd6Dj5Ch5Ch6UaSMRvxYwFdEhTmsAD/draeEFb1kwaf
3TPqLjMKBek/NfOxJxKxm4Y9ZbHWsQc=
=eUy9
-----END PGP SIGNATURE-----

--5jesdngv6qe6kcit--
