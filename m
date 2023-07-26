Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420D4762E9E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjGZHtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjGZHrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:47:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35741FC4;
        Wed, 26 Jul 2023 00:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690357384; x=1721893384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zbfnCY12tOIDGCHWJrhLFBreINIxAOjEBVeQh4krr5w=;
  b=EA+ZjHES97Ry4qPBc9dOobgADciiLnN2WjZJjOTy9CNUHG+tKcnPfNZR
   payzNRMAq/dZyEeH+0K8emrH7XdggrCZ1AOZ5WrmNBpia5g5Kr8MKS4+M
   Nw1iWf2Y/YRkYxYJwSL+gNa2mwEBJ/r43ihswjeJiIQUVU8wB6scj4VE1
   WhY1S3VwE04Zx5dxlH0f79yCtUh0SSb5i9UXcfnQmtIq7QVG/7FEdl0jQ
   EVzL75fPrPz3DJaDZu0XvG4ModZ0jxnEl6rFOEGZ7uo/LTz+LdFxusBUz
   8+PwAKNgjicTy1R1itniT8WRT9kB5F4lYrY24b1oXpjbmBYsqQ+FYwZsM
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="asc'?scan'208";a="237830243"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jul 2023 00:43:04 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 26 Jul 2023 00:43:03 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 26 Jul 2023 00:43:01 -0700
Date:   Wed, 26 Jul 2023 08:42:27 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Peng Fan <peng.fan@nxp.com>
CC:     Conor Dooley <conor@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: power: fsl,scu-pd: separate out fsl,scu-pd
Message-ID: <20230726-trolling-chair-41f8258ef8ef@wendy>
References: <20230725102900.225262-1-peng.fan@oss.nxp.com>
 <20230725-excretory-speed-003064040657@spud>
 <DU0PR04MB94171BDFA6FF61A644138F688800A@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VALnaJ/7H33Rsjw7"
Content-Disposition: inline
In-Reply-To: <DU0PR04MB94171BDFA6FF61A644138F688800A@DU0PR04MB9417.eurprd04.prod.outlook.com>
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

--VALnaJ/7H33Rsjw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 12:21:10AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH] dt-bindings: power: fsl,scu-pd: separate out fsl,s=
cu-pd
> >=20
> > On Tue, Jul 25, 2023 at 06:29:00PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Add an entry dedicated for fsl,scu-pd which could serve i.MX8DXL
> >=20
> > Why not just add a soc-specific compatible for the i.MX8DXL?
> > The current form of this does not look right to me.
>=20
> I could add one dedicated for i.MX8DXL.

Also, where is the user for this? I'd expect to see a dts patch too?

--VALnaJ/7H33Rsjw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMDOXwAKCRB4tDGHoIJi
0qrHAP95TOltWFjbVY6ECdOwnXc2h9+ak7nsM8ik4kSVwN09SgEAsn0Abr5/Eoxl
6oC4QjnYu+V3wFEnqRavq2VrfryEdQQ=
=L4Jg
-----END PGP SIGNATURE-----

--VALnaJ/7H33Rsjw7--
