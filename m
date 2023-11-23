Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B457F6513
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345401AbjKWRRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjKWRRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:17:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92599D53
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:17:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B0FC433CC;
        Thu, 23 Nov 2023 17:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700759859;
        bh=ts+zqQc2FfD6+up8RHX6pODysbXRP+HNaBy6BBRqtZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hBuJmB01jH44PO6tf54BIK+xjnjyj3ttz7jh18Fw5eSzvA+g3tsgaP9iBWoIwKoc2
         iLBaPkyFpsGYABM9U4JyhfTWNIfzFd+l5Bij1mw/o8fIgpfEdas8TCWDBvsXx6YvER
         dL6R/W6u6Uc7ezFvnlfXhw8QGw9wsn54YvJMhzJKUIuTd9vlx0zzpV2Hp94mAL5GRL
         okq/jNr6mV/osPxj1VBv88LY2V8yOXXdzR8PZZ6GyvHgjdEiG/tB6TD7PJVFb/0BoS
         k4YELSUx9SewzfmMwizuz0fa8zdJzfCeuwwB7V0eL5ETqRQw3BbUETTBM+CptC/ShN
         Ap1rDH3Z3tjgQ==
Date:   Thu, 23 Nov 2023 17:17:34 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Michael Walle <mwalle@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: pwm: remove Xinlei's mail
Message-ID: <20231123-swell-outlast-d09bee7f85fe@spud>
References: <20231123134716.2033769-1-mwalle@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9vUpuWVFk7p9BYFj"
Content-Disposition: inline
In-Reply-To: <20231123134716.2033769-1-mwalle@kernel.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9vUpuWVFk7p9BYFj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 02:47:16PM +0100, Michael Walle wrote:
> Xinlei Lee's mail is bouncing:
>=20
> <xinlei.lee@mediatek.com>: host mailgw02.mediatek.com[216.200.240.185] sa=
id:
>     550 Relaying mail to xinlei.lee@mediatek.com is not allowed (in reply=
 to
>     RCPT TO command)
>=20
> Remove it.
>=20
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--9vUpuWVFk7p9BYFj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV+JLgAKCRB4tDGHoIJi
0t5zAPoCpbE32A6RWoUyYWg7kdcQQ4hIkcinmEa+cuTb40dvFwD/RlVSJ1Dt2mC/
1TVGlA4sr492Jn6Wm/7BbXm4QYIHhAM=
=s9a9
-----END PGP SIGNATURE-----

--9vUpuWVFk7p9BYFj--
