Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183DD7E8C45
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 20:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjKKTGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 14:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjKKTGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 14:06:32 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5883A98;
        Sat, 11 Nov 2023 11:06:28 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7FB041C0071; Sat, 11 Nov 2023 20:06:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1699729587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zgR/3lTA5jyugRu1Bfxz5TwrBkC6vi/F9zTWmWvKmoM=;
        b=J+jL/ot+2rUterTlYljEl2M0RnhbihneFjlS2rA0qwdfMIvPSuSwUd4nUkROlN4+tMrGT+
        Oms8A47F76x4jE8DX1R3l/koopTSuFkyBZroEb+/2yjnfCuKrntosk76mT7UdXhsIL627x
        KVRt0suN7lm61UPLrnYoFFuOZzfPYdk=
Date:   Sat, 11 Nov 2023 20:06:27 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Alain Volmat <alain.volmat@foss.st.com>, icenowy@aosc.xyz,
        megous@megous.com, phone-devel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Rob Herring <robh@kernel.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] media: i2c: gc2145: GC2145 sensor support
Message-ID: <ZU/Qswj7anG6aux/@duo.ucw.cz>
References: <20231107081345.3172392-1-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="c99IJSi2TNNS+dvo"
Content-Disposition: inline
In-Reply-To: <20231107081345.3172392-1-alain.volmat@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c99IJSi2TNNS+dvo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This serie adds support for the GalaxyCore GC2145 sensor.
> Initialization is based on scripts provided by GalaxyCore,
> allowing 3 fixed configurations supported for the time being.

There is another version of the driver, from Ondrej Jirman, floating
around. See mail "gc2145 camera driver (front camera on
PinePhone)". I've added some cc-s in case people wanted to comment on
it.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--c99IJSi2TNNS+dvo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZU/QswAKCRAw5/Bqldv6
8gZ/AJ0VmOePHLmVMeiAn8wUhOJNzmbGpQCgo5PNc2t4ip+Y4u4a1wGrJsj0GfY=
=tfn/
-----END PGP SIGNATURE-----

--c99IJSi2TNNS+dvo--
