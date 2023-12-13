Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370ED810E08
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjLMJqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMJqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:46:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B327783
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 01:46:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F15C433C7;
        Wed, 13 Dec 2023 09:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702460812;
        bh=k3h+x5Vi0c4IUc2BgiJewMzJeCYyvSk8+ZHJK/SWAOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tB5OQxh//OBSfXK0FUdFSzcfEoIJyEniRxaI6FF3p7iKPcZ+k+7oHa13+VC5BtTVW
         AIvVDladP54+eKEj0Gizw4euRRRU6KZCljmIlisdNUIFEIPMh59eypu8BxdaDEnvgg
         +J1/VytncX+iPP7xylS4qbsFfaeCyc35ucSWlT1PIR9VG8UK+IadGA4rhnRd1kZdNI
         /xMEdLMTt+iCLnF06HyS5MK4EQ/RO1rWc5rGrvf97MSFIVP3+KQmnXpVVESH+jjOa7
         Y3XgFLpzUW+W4LKrAmsIIn5S1Y6lJPRrOn80Znicol+dSEaP5p+knty92G1xUrhR47
         j9Ggn0ti7Ij1A==
Date:   Wed, 13 Dec 2023 09:46:44 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Couzens <lynxis@fe80.eu>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [RFC PATCH net-next v3 1/8] dt-bindings: phy:
 mediatek,xfi-pextp: add new bindings
Message-ID: <20231213-confined-shaping-f56b1fdfb135@spud>
References: <cover.1702352117.git.daniel@makrotopia.org>
 <b875f693f6d4367a610a12ef324584f3bf3a1c1c.1702352117.git.daniel@makrotopia.org>
 <20231212-renderer-strobe-2b46652cd6e7@spud>
 <ZXiNhSYDbowUiNvy@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TQLtrFVr4ShS8Ew7"
Content-Disposition: inline
In-Reply-To: <ZXiNhSYDbowUiNvy@makrotopia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TQLtrFVr4ShS8Ew7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 04:42:45PM +0000, Daniel Golle wrote:
> On Tue, Dec 12, 2023 at 04:21:38PM +0000, Conor Dooley wrote:
> > On Tue, Dec 12, 2023 at 03:46:26AM +0000, Daniel Golle wrote:
> >=20
> > > +  mediatek,usxgmii-performance-errata:
> > > +    $ref: /schemas/types.yaml#/definitions/flag
> > > +    description:
> > > +      USXGMII0 on MT7988 suffers from a performance problem in 10GBa=
se-R
> > > +      mode which needs a work-around in the driver. The work-around =
is
> > > +      enabled using this flag.
> >=20
> > Why do you need a property for this if you know that it is present on
> > the MT7988?
>=20
> Because it is only present in one of the two SerDes channels.
> Channel 0 needs the work-around, Channel 1 doesn't.
>=20
> See also this commit in the vendor driver for reference[1].
>=20
> We previously discussed that[2] and it was decided that a property
> would be the prefered way to represent this as there aren't any other
> per-instance differences which would justify another compatible.

Please put it in the commit message so that when the next version shows
up, Krzysztof doesn't show up and question the property for the third
time.

Also, on another note, this series is aimed at net-next but half the
series is fixed for incorrect bindings. Why not net?

--TQLtrFVr4ShS8Ew7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXl9hAAKCRB4tDGHoIJi
0l51AP9AfxTVJus53lwalnfKdDDM6fu9GnfTQ1DaU51hYEgGlAD+KJiVYUIfbVyH
NeYoGDoBXFZkUEImGzZ7OfYXmDAzTQw=
=+6BB
-----END PGP SIGNATURE-----

--TQLtrFVr4ShS8Ew7--
