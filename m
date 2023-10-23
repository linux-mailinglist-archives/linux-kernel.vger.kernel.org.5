Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B647D2D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjJWIvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjJWIvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:51:05 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F43D79;
        Mon, 23 Oct 2023 01:51:00 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 487F31C0050; Mon, 23 Oct 2023 10:50:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1698051059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3pSUpZDQ5vUD6HgxTJJjjap2/VmSGErzcPPCNPi0Vq4=;
        b=fUPoqHJDI6WoN6o7F9DijeIoNAvXFi4TqcOFI2vlawYycz4nvg5INCK2+QwCYR/aigmT14
        JEyyKMs5dsN/dyK1lxuxZRIGsn3bmttYscoIVzXa4CXElHafn+m8KbWPXEbTUdEgG/vHZK
        eL5aLjQes1FKCgysCVN+rYvACHT9kl4=
Date:   Mon, 23 Oct 2023 10:50:58 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Luka Panio <lukapanio@gmail.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6 2/2] arm64: dts: qcom: sm8250-xiaomi-pipa: Add initial
 device tree
Message-ID: <ZTYz8uvCOzMy+TE0@duo.ucw.cz>
References: <20231022173811.8229-1-lukapanio@gmail.com>
 <20231022173811.8229-2-lukapanio@gmail.com>
 <3307fcb9-1697-4a9e-b4f6-c00c2b10ba89@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OJcLppF572H4TwG4"
Content-Disposition: inline
In-Reply-To: <3307fcb9-1697-4a9e-b4f6-c00c2b10ba89@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OJcLppF572H4TwG4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Initial support for Xiaomi Pad 6 tablet, that have sm8250 soc.
> >=20
> > Signed-off-by: Luka Panio <lukapanio@gmail.com>

> > +++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-pipa.dts
> > @@ -0,0 +1,625 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
>=20
> If there are no other copyrights here, why did you use BSD-3 license?

We like BSD license for dts files. (But dual GPL or BSD is more
common. Not that it matters).

> > +/*
> > + * Copyright (c) 2023 luka177 <lukapanio@gmail.com>
> > + */

This should have real name.
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--OJcLppF572H4TwG4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZTYz8gAKCRAw5/Bqldv6
8pPMAJ9UWSxbLwNmMlcw4piFDwYzY7c4ZACgvrp1u4Dx0f2Tacu0ekmzryB8Eqo=
=/+v8
-----END PGP SIGNATURE-----

--OJcLppF572H4TwG4--
