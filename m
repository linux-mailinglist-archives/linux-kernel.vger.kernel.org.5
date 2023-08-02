Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E2276C6D9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjHBHal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjHBHaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:30:39 -0400
Received: from wp534.webpack.hosteurope.de (wp534.webpack.hosteurope.de [80.237.130.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E625EA;
        Wed,  2 Aug 2023 00:30:34 -0700 (PDT)
Received: from [2001:a61:6218:1140:c80a:ff:fe00:4098] (helo=cs-office3.lan.local); authenticated
        by wp534.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1qR6JR-0002hE-O1; Wed, 02 Aug 2023 09:30:29 +0200
Date:   Wed, 2 Aug 2023 09:30:23 +0200
From:   Carsten =?UTF-8?B?U3BpZcOf?= <mail@carsten-spiess.de>
To:     Conor Dooley <conor@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: hwmon: add renesas,isl28022
Message-ID: <20230802093023.1a926c9f.mail@carsten-spiess.de>
In-Reply-To: <20230801-implicate-mullets-bd160bbda4b2@spud>
References: <20230801163546.3170-1-mail@carsten-spiess.de>
        <20230801163546.3170-3-mail@carsten-spiess.de>
        <20230801-implicate-mullets-bd160bbda4b2@spud>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BXJ0gOwyb3HW7efOE0ScJsd";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-bounce-key: webpack.hosteurope.de;mail@carsten-spiess.de;1690961434;2a388d4e;
X-HE-SMSGID: 1qR6JR-0002hE-O1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BXJ0gOwyb3HW7efOE0ScJsd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


On 8/1/23 22:52, Conor Dooley wrote:
> On Tue, Aug 01, 2023 at 06:35:46PM +0200, Carsten Spie=C3=9F wrote:
> > Add dt-bindings for Renesas ISL28022 power monitor.
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - renesas,isl28022 =20
>=20
> You've only got one compatible, why the enum? Will there be more similar
> devices that have an incompatible programming model?
Yes, there are isl28023 and isl28025 with different register addresses,
might be supported in future releases.

> > +  renesas,shunt-range-microvolt:
> > +    description: | =20
>=20
> You don't need these |s if you have no formatting to preserve in the
> text.
Will fix in v4.

> Otherwise, this does look good to me.
Thanks, regards
Carsten

--Sig_/BXJ0gOwyb3HW7efOE0ScJsd
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEWM+MlUpz/bWsZllTM1JQzV9LKSwFAmTKBg8ACgkQM1JQzV9L
KSy4vQ//dinrXdpL3D10oTIGl0kARpvszyxqIVr3F8i4Rgd/u6cbw+vYvZICDRQs
IMFVkkXAtG8elJ+903hfMcczi31ORuESpVU/5Ymww65QZICRBbSpxVdN5I+SVMHP
jz0y9Xnr3yLI/BIGmlnYjBGCMbqa3XPxtxHhIEwpEnxpvDzl+/ecxNn8lKPCSmjc
lfTRmDme9eWca0v4Ck61SH+wppNHID1tgnv2l/GL5fnEzjuhPDZxReESEsZELOn8
vSq4XYn1WGdS9fTzj6R2jqu04nOFtS0bxbcUs3cZfg9GjXcgZeAUn2Ig2wPmu7ie
MvzgkFzjhGRqiXXE92MrILC3ozgZCgnWSGmlN/sk/nGsr2Vb3L8frBRCGeQIshJV
EcIs7YsHFpGsuN61zDxETWE/hG/HdRBK82tK/sesBl1+uTW+wXJqyA+2SAkgfp1Z
sBWw/7LGxKDTiZpR3vFEOi+Umo6K6NLny/oy/diiTghZEozhL9dALRMbNy17mn6J
uGRS0G/Alphe2KOiaWMvI26rO1q3wiTIogCrbHrbnFFRgNwVtBKPuEzLJTLAWHWU
XxAyDaFykGXeXCt9Ltc4mrAq+KqXdIlP7igucLxo5B/mbakLMkuLl9PCObt5TQGL
+wIYqzXw5Xom2iZnoQJ4Kpv6rMpIDoYpZ0i/pJJ+E7E6uL/Kcis=
=2qU5
-----END PGP SIGNATURE-----

--Sig_/BXJ0gOwyb3HW7efOE0ScJsd--
