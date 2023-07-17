Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4091375650D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjGQNdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGQNd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:33:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A5B8F;
        Mon, 17 Jul 2023 06:33:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F202361050;
        Mon, 17 Jul 2023 13:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59548C433C7;
        Mon, 17 Jul 2023 13:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689600807;
        bh=6vaYo9hRLCt/NfLnm9tEovMmyqkg7M1p+KIm3omd/ic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sg/FPr17C2vjofle9KTJT2l4N21PnfXzNYaBhAn8VpLbLFV8MKW9QjcbjARlMpmTP
         qfl8G6cO6XsMvRqpcqyHh96ob1EKftSA7mJtWp24FJpwdJ41UYNo2N7ol2nGeskGw0
         9jrSFLJOXmnG1czg55YBAxuLu2ZTibe9rb0NlrV1/TpHikTMvwZv4OsqlZmlmJun3k
         PNlJ9Lz6OFkXn/LIlmCldEfbzR1NXR0cmhlOUNqXRYJlI4n0M67EiEWBPur3/SGLwA
         UkgdUwliWD9vxOtk0imdsRrnWmpBF8MhD0G/DNOvWjDU5MQECM2/vj20XRGc+y+TJF
         OTSVSOKel+YRw==
Date:   Mon, 17 Jul 2023 14:33:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Joy Zou <joy.zou@nxp.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v1 2/3] regulator: pca9450: add pca9451a support
Message-ID: <2c1dabb7-f1fd-478c-a249-994c450eb758@sirena.org.uk>
References: <20230531065724.3671795-1-joy.zou@nxp.com>
 <3505527.iIbC2pHGDl@steina-w>
 <VI1PR04MB5936370C11D1523558437D9BE12FA@VI1PR04MB5936.eurprd04.prod.outlook.com>
 <4630917.iIbC2pHGDl@steina-w>
 <AM6PR04MB5925D0B730978A949D48E25BE13BA@AM6PR04MB5925.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lnvs8OB3JnKKLcTO"
Content-Disposition: inline
In-Reply-To: <AM6PR04MB5925D0B730978A949D48E25BE13BA@AM6PR04MB5925.eurprd04.prod.outlook.com>
X-Cookie: Not a flying toy.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lnvs8OB3JnKKLcTO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 09:53:15AM +0000, Joy Zou wrote:
>=20
> > -----Original Message-----
> > From: Alexander Stein <alexander.stein@ew.tq-group.com>
> > Sent: 2023=E5=B9=B47=E6=9C=885=E6=97=A5 21:13
> > To: Jacky Bai <ping.bai@nxp.com>; lgirdwood@gmail.com;
> > broonie@kernel.org; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.o=
rg;
> > conor+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > linux-arm-kernel@lists.infradead.org; Joy Zou <joy.zou@nxp.com>
> > Cc: kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx
> > <linux-imx@nxp.com>; devicetree@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: [EXT] Re: [PATCH v1 2/3] regulator: pca9450: add pca9451a supp=
ort

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--lnvs8OB3JnKKLcTO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS1QyAACgkQJNaLcl1U
h9BkUQf/eG50jyD0n2+Xpz629uluZVbPW+HAbEbW9LbfrdgWePvwWGPDWJGTICIO
cAOdr3YJVZPU/ZCjPQOmPd1Wbud6ZLCyAC2zm5MvMD8owGJMSWHH4mxSoyOaBl+d
BHiAG3YIqEwddHxU80Nz8U0b+MKX+4ebaGyNyewxKvfC1iNsPIu50MTLzuH6kNXy
4Ms9+UW8WBZolqZPHMFRx8HQABibpHJ5uFqV6gYWIalrOhCK123tUu/Ww8JzofxU
iEKXSDV7gwV/vlLkLSqEvEOVcw8qDU8IOaEdSRsnNcdVZa6tfd67ym3ixDGqkWf3
b2SmvW4NbPx0PoUH3O7UED3CY1D5RQ==
=BMR8
-----END PGP SIGNATURE-----

--lnvs8OB3JnKKLcTO--
