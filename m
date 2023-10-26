Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCF67D83FF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345156AbjJZN4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbjJZN4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:56:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F0D10CC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:55:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0594C433C7;
        Thu, 26 Oct 2023 13:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698328557;
        bh=oLER38uzMemoYORtxSf8v3sO8wvhBgq1cBskSk2dZUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o7XHfTZf2OmYUZBep76VeSpHf1ZC3qq81skVhaj/J4XXDBEbK5Q1EP4Artm6S1813
         pKIZlnAObtE1gBSa/p2iURA3R81FJXp7BL8Z8VuDOTVbw7gRb+usnQK0PxnK43DxxT
         bciwtK9te3bXP/L/nIRaPgxlbZvs8mc/r2S3DsKcP12qswNmaOc3YJoShDfhgB7IB1
         fYXFe6gwlYphaKMqOYu2gNHWw0gCergElS3ohBdnpaFV8ENgQMthhkrE0M2ydJkPo5
         YiGeF1rHO6ZnXit/gyk6TrLnthBwbSSroaEBages4qgckInuztrXdfqSGNJs6t6IaN
         VPHN5H5er3HsA==
Date:   Thu, 26 Oct 2023 14:55:51 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "clin@suse.com" <clin@suse.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: Re: [EXT] Re: [PATCH v6 02/11] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Message-ID: <20231026-unbalance-trickster-cefc5be65326@spud>
References: <20230927175401.1962733-1-pankaj.gupta@nxp.com>
 <20230927175401.1962733-3-pankaj.gupta@nxp.com>
 <20230928185159.GA1035361-robh@kernel.org>
 <DU2PR04MB8630FF5994D65A5404E8B9B095CBA@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <95ce1ef5-dad6-4014-8aec-44adec5b6435@linaro.org>
 <DU2PR04MB863004DCF8AEC09BCB809BD495DDA@DU2PR04MB8630.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2qCaAz9wwJig13+u"
Content-Disposition: inline
In-Reply-To: <DU2PR04MB863004DCF8AEC09BCB809BD495DDA@DU2PR04MB8630.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2qCaAz9wwJig13+u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > >>> +
> > >>> +additionalProperties: false
> > >>> +
> > >>> +examples:
> > >>> +  - |
> > >>> +    ele_fw: se-fw {
> > >>
> > >> Drop unused labels.
> > > I am sorry, if I am not able to understand your point here.
> > > But, all the below labels are getting used.
> > > I can remove the fsl,mu-id. Will do it in V7.
> >=20
> > Comment was about labels, not properties.
> The label "ele_fw", is needed to be placed in different DTSI file.
>=20
> For instance, node is added in i.mx93.dtsi.
> Using label, the memory-region property dependent on size of DDR on the p=
latform, is placed in:
>=20
> - imx93-11x11-evk.dts

This is a standalone example, whether or not you need a label in the
dts/dtsi is not relevant to this example.

--2qCaAz9wwJig13+u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTpv5wAKCRB4tDGHoIJi
0jfCAQCc2ggFktxsIOBoKixC7bNaPyiCMhR1vx+q+DNY4aQxYwD9GeOC3DU8KaPA
u+R+xISlvpWJiXPsye5Quoc2TdAIswc=
=BPts
-----END PGP SIGNATURE-----

--2qCaAz9wwJig13+u--
