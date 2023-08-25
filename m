Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC188788C18
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343881AbjHYPFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343571AbjHYPFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:05:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E642127
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:05:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEE1364D40
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BA7C433C8;
        Fri, 25 Aug 2023 15:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692975919;
        bh=eHpdomHqz2leXbmraR960nt9YH0gz7JmtwmpSircQLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z8aKF+T3AUgnpDQ2xSCjBmHAewY/IRdr/0ugFhgTgx8XNW7iCbkJsh6QnMSU80Hes
         hU621LFeBaESpgxd+AOHTNk+ctd0SIcyvqQDBVElSCS33SWP9imOa/y8n+gM2Npcut
         H9t2VAOpnbDyboarm5dwSoPcsK3ApnOa6RBCi9FLqeaJaSnLjjPRdcrGgpZgZ3EebL
         GELHS2XQgThDWNxqhTSMS3bmv99xi6PRaZpe7Poxu1LIOBDXpro5RF/b2FEN/Ib3/V
         F0lID51u17YsKAfEiSkHZerKlrn4RZgek0OL1rAVyfUxTfvwkRajxAkTdkG3wSWh9c
         3lpKplKSJxd3g==
Date:   Fri, 25 Aug 2023 16:05:13 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        airat.gl@gmail.com
Subject: Re: [PATCH net] dt-bindings: net: dsa: marvell: fix wrong model in
 compatibility list
Message-ID: <20230825-outdated-supply-90d9c2d92d63@spud>
References: <20230825082027.18773-1-alexis.lothore@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/Vq4s2c2AbFormVj"
Content-Disposition: inline
In-Reply-To: <20230825082027.18773-1-alexis.lothore@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/Vq4s2c2AbFormVj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 10:20:27AM +0200, Alexis Lothor=E9 wrote:
> From: Alexis Lothor=E9 <alexis.lothore@bootlin.com>
>=20
> Fix wrong switch name in compatibility list. 88E6163 switch does not exist
> and is in fact 88E6361
>=20
> Fixes: 9229a9483d80 ("dt-bindings: net: dsa: marvell: add MV88E6361 switc=
h to compatibility list")
> Signed-off-by: Alexis Lothor=E9 <alexis.lothore@bootlin.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--/Vq4s2c2AbFormVj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOjDKQAKCRB4tDGHoIJi
0gIqAP0Q5WIzR/1kPHTO3wHb+0pQ98OlKLPip/G372M2Y8RQ7gD/S6K8ItQlYSvo
wnlgU/1kqwSHxsGL07Vj+LuMIaItMQw=
=0QUe
-----END PGP SIGNATURE-----

--/Vq4s2c2AbFormVj--
