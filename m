Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53206764FEE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjG0JhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbjG0Jgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:36:55 -0400
Received: from wp534.webpack.hosteurope.de (wp534.webpack.hosteurope.de [80.237.130.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2D98A53;
        Thu, 27 Jul 2023 02:30:41 -0700 (PDT)
Received: from [2001:a61:6209:7f40:c80a:ff:fe00:4098] (helo=cs-office3.lan.local); authenticated
        by wp534.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qOxKO-0008EJ-J1; Thu, 27 Jul 2023 11:30:36 +0200
Date:   Thu, 27 Jul 2023 11:30:20 +0200
From:   Carsten =?UTF-8?B?U3BpZcOf?= <mail@carsten-spiess.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: add renesas,isl28022
Message-ID: <20230727113020.7585b8d3.mail@carsten-spiess.de>
In-Reply-To: <d5e3aa31-1aaa-0f8a-12d2-20dc6ee94f1a@linaro.org>
References: <20230726152235.249569-1-mail@carsten-spiess.de>
        <20230726152235.249569-3-mail@carsten-spiess.de>
        <f8fdc8d7-6ac5-5e20-10ef-7417d79c1b91@roeck-us.net>
        <20230727093528.594ce3a7.mail@carsten-spiess.de>
        <d5e3aa31-1aaa-0f8a-12d2-20dc6ee94f1a@linaro.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2uN/tKVapAYpdBG_3fMLM5/";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-bounce-key: webpack.hosteurope.de;mail@carsten-spiess.de;1690450241;ceed5529;
X-HE-SMSGID: 1qOxKO-0008EJ-J1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2uN/tKVapAYpdBG_3fMLM5/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


On 7/27/23 10:25, Krzysztof Kozlowski wrote: =20

> > replaced with
> >   renesas,shunt-range-milli-volts: =20
>=20
> That's not correct unit in DT, so again please use -microvolt:
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pr=
operty-units.yaml
a bit unhandy but o.k., applied to [Patch v2]

> >     description: |
> >       maximal shunt voltage range of 40mV, 80mV, 160mV or 320mV
> >     $ref: /schemas/types.yaml#/definitions/uint32-array =20
>
> And then drop this line.
Applied.

Regards, Carsten

--Sig_/2uN/tKVapAYpdBG_3fMLM5/
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEWM+MlUpz/bWsZllTM1JQzV9LKSwFAmTCOSwACgkQM1JQzV9L
KSzqJA/7BZ6wJ2110367UjO757d3CgtgwlPCAXRYCMsysJvuM43n+TFRrSDJwui7
SefdpW4iRWZhYrCukuWcSR+Lb9z5swTd+Pno+kljLZ9KOZc9/DItcLV8TQ/LZFCT
noUJ4xrM8vEuQbKREKZOgFhPkpprEbB3xokb37RapEWiiHoeCl7UyP5rvR/lE2XU
AGxvHuHuW88UXeJ/odRZw1l6zkyKgsTqxJwMderxRbEm7Mzr/I5bhhgPfBz+sp5M
jnJpdTF1ni631b9NcNSLtMXJSU58/kgfFz6ZQc/zVqcgiHaHN9/fFL5mGRTOewpc
zGu60UfFBXqBW0kdThNY0QFgHCY1rwkpE0o8GsxbHOdg7hrS6YOUzxByE5Gp47ky
U8AypbySk9fe8UKxEW+lYiDqfiJT6tr8XcSYFv1FSPz251me19m0BS3aoP5J1jgP
jvYqV9nUV4f57sgAw4aHEtK2IuR7NFxxWsOdNNeNy+zu4EwkvKJs/Lxzlsq08OXL
j1pEvCZMYAeYJrwgp6srAe3ZhfGqxULa7RZEloOehp5I6Wms0UfVP+r+TnXFFfeI
SjnPyoU3DTj3iVXfGnOkSHH8VzQUKT8ig7n5sbN47C4RNOQx2i/Kw4RQCt4Wu+Zs
lL9/30yh32a+nhmh5Nm8u0Zkm9p2kVNvxqIKX1dB4ThsQKtHFZA=
=LaRm
-----END PGP SIGNATURE-----

--Sig_/2uN/tKVapAYpdBG_3fMLM5/--
