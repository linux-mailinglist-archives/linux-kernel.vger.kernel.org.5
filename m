Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2DD807059
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378220AbjLFM4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378112AbjLFM43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:56:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D13FD3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:56:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96334C433C7;
        Wed,  6 Dec 2023 12:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701867395;
        bh=FDpwgafoOGfqeUaYxZy4t8X7eZ2h7VcCSdPOW2X4ypw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RbCYYuJFjpJuAoaOmVIeBQwzx4ooCuREK8n66iOreUgfHmf/MHb99uU8xjDNk4xIL
         QKtojAJ3/3NINB8+CMNlf30MiSema9MMZ6BYNRoz6WBdMOc/VhNBo1jf2sCvKqWYZt
         Yb0FjVkoC39tFpXgyj4ciXKUsfOwhnRZ4Ezg2AO89SgtBOWutY+VP21wOArVDoP6Gm
         ndfLOI27SUzxJMF0gAS8McSZtpIOOokGV1d4e/i0vugnvH1Dr/yVl4pw5DNDYciJ1W
         Nt4EIqfQhM8wHIqvdqDVZTaYRC01YqP10mxruH/CFiP1/rhVks9BssJj6MMkxmAlAE
         UoYzhVXJWgW6g==
Date:   Wed, 6 Dec 2023 13:56:32 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Keith Zhao <keith.zhao@starfivetech.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        William Qiu <william.qiu@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Shengyang Chen <shengyang.chen@starfivetech.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "suijingfeng@loongson.cn" <suijingfeng@loongson.cn>
Subject: Re: [v3 5/6] drm/vs: Add hdmi driver
Message-ID: <abdl6kmighvpwojvafq443q7grn6w3abwpvw7zwbna4jvtsvjf@fa42rv46n2wh>
References: <20231204123315.28456-1-keith.zhao@starfivetech.com>
 <20231204123315.28456-6-keith.zhao@starfivetech.com>
 <esetsiqgqpk35zue4c6aq7l6zn4kezhxkqqa7ompaz2vhdy3lr@4d5awfqgs2ss>
 <94a1f9fc-82fb-4a04-a44b-f9b20c2bdfdd@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gejtzksqfhmcrf7c"
Content-Disposition: inline
In-Reply-To: <94a1f9fc-82fb-4a04-a44b-f9b20c2bdfdd@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gejtzksqfhmcrf7c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 08:02:55PM +0800, Keith Zhao wrote:
> >> +static const struct of_device_id starfive_hdmi_dt_ids[] =3D {
> >> +	{ .compatible =3D "starfive,jh7110-inno-hdmi",},
> >=20
> > So it's inno hdmi, just like Rockchip then?
> >=20
> > This should be a common driver.
>
> Rockchip has a inno hdmi IP. and Starfive has a inno hdmi IP.
> but the harewawre difference of them is big , it is not easy to use the c=
ommon driver
> maybe i need the inno hdmi version here to make a distinction

I just had a look at the rockchip header file: all the registers but the
STARFIVE_* ones are identical.

There's no need to have two identical drivers then, please use the
rockchip driver instead.

Maxime

--gejtzksqfhmcrf7c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZXBvgAAKCRDj7w1vZxhR
xStPAQDTvV/nRdmwVbGgRirLKYu3fEEk2bcTs2wowK1XVkHKtQEAnaZsvW3x1amk
Y3Ot2ZUNpn5FMhvwW/Xd0KRaNbS+SAM=
=Auvj
-----END PGP SIGNATURE-----

--gejtzksqfhmcrf7c--
