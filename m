Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA7D788642
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243439AbjHYLqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243379AbjHYLqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:46:17 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81941FF7;
        Fri, 25 Aug 2023 04:46:06 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.97.125]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MEVmm-1qTTv01F8M-00FzdC; Fri, 25 Aug 2023 13:45:04 +0200
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id BB75D3F91C;
        Fri, 25 Aug 2023 13:45:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1692963901; bh=LUBlIR9uims4Ic+E1eg4RARNsFeFff9QgTvUJ80cX8g=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=v+at3+xXvzcMRK3YtjLTFxfGKHkgIN9SjSwtL3aCndUvJg6FCmjoGiEVo9mf1G3U1
         ePV8ilS9qxuvp/qw+eXm+nTceavdn1MPTbqFiSF7g2EK8NEURszwY1z/HTmN4I0BZl
         Nh9pTbPB6H6NXqIAzGQKC+AaZ+k6VI3XIO0enmFM=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 3A28C3949; Fri, 25 Aug 2023 13:44:57 +0200 (CEST)
Date:   Fri, 25 Aug 2023 13:44:57 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quic_pkondeti@quicinc.com, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/1] scripts: Add add-maintainer.py
Message-ID: <ZOiUOcMOeYvMzq58@bergen.fjasle.eu>
References: <cover.1691049436.git.quic_gurus@quicinc.com>
 <829b08342568735095bbd3f8c44f435f44688018.1691049436.git.quic_gurus@quicinc.com>
 <ZOYicEP8D7kNGFin@fjasle.eu>
 <20230824214436.GA22659@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jjpaJEitG6LbK2XV"
Content-Disposition: inline
In-Reply-To: <20230824214436.GA22659@quicinc.com>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:OpjvI+EpoKm6ZYkk+K9aTJlDjF7uHsQ+qFvZk8KggGXWPyGKsrW
 6pVfhXWPooQ/5gpWW6ITajiNCTK7ZIzjNtU0dnWsawLj+akjZfHGeerrS7e/Cmca6ev4vqY
 7/cwNYlX5c+d4AODzpxUEVPSiiNUMSONN9Z3WLURXIu7OCrvJgiOV369DWvgP6xgPCT9o+i
 m1kjau66iS3apeNEvEwBA==
UI-OutboundReport: notjunk:1;M01:P0:xRdCoaZs1A4=;zq/8sb2ZB3CAJJ3Yb3QlMyo2aNf
 /KqdfBUlF2LtwAb7FpfZMuzem3WzZUQ6WzrLIv0ndmQh/4dvFXyx//8fnAVjN9JEnEXzHHVHS
 H6X+moSHU8KWtcdVknmm5eeR3D0FmXoFprOapA4KIbwqhNBGeKoazaVOANDHctYERoaJheNDr
 i1mfjABNGWH23qu5YZCKEKYwQhoawv3P0YJxS9hKJMam+ELoxWv1EdYxNm0DL/oJeDXOat49L
 PiJREIa+XZ08EWEfuSkebBuRYmskr/sD374dFAvkBwfBKFzFtHaJ2Z046KWozu6TuRqreAry6
 TBARSy7XaR5mBGn/Po/VFHqsPvD/86vMd8xXwOZtBjVYivitbGSDM+P3uh6aas8rvrbvq6iyr
 rwC5c8qhM0tHwHi8FO5oc7Fpj0aZVKH6JRVsh7AgISM4g8Zjgyu9aMTXF9W0uCyzzRl2r8oII
 2ZPajGUB7fshjz+aeBbDQpH+eeUMmu4+NTZthZGqP/ygK/S+YBv3GqCqNxmwYfLsbDuOdroDr
 ArSPdj6YXXbLit6bpQDMguQD+R4OiuY7x6wlNmfWC8h1e58qHTDkT9OZjKZJGySRIFfx0G6z5
 snzrfR3lsZyqoji79GO3eaPYAVGVo3YXdB/WttsV/eNUrRcHLCM4zQWrMutWwZIPKkAjMb1AG
 KprKsXNo92RTxfEXf82V4HgYMUXS6PXDAWJ0SpriBpJQhiRe4BbS0oSl+Ca+Q0zYSoRLbU+OE
 ozlxt8ARFGMkZ8Js3CR7nXthvFWTjusd5oDE+9C1pLpXawe88FAotjXxYblitZvTcyXUZ2zpB
 KfbCVkHjf5qrQVe9BacOCvRIbiUItB/DE2wwGNhaP+UvsLGw1ln238z8MeggruXL+o0k6kTVH
 5GJqWZrUIUsVU3w==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jjpaJEitG6LbK2XV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 24 Aug 2023 14:44:36 GMT, Guru Das Srinagesh wrote:
[...]
> > > The script is quiet by default (only prints errors) and its verbosity
> > > can be adjusted via an optional parameter.
> >=20
> > IMO, it would be nice to see which addresses are effectively added, e.g.
> > comparable to the output of git send-email.  Perhaps somehing like:
> >=20
> >   $ scripts/add-maintainer.py *.patch
> >   0001-fixup-scripts-Add-add-maintainer.py.patch: Adding 'To: Guru Das =
Srinagesh <quic_gurus@quicinc.com>' (maintainer)
> >   0001-fixup-scripts-Add-add-maintainer.py.patch: Adding 'Cc: linux-ker=
nel@vger.kernel.org' (list)
> >=20
> > Perhaps verbosity should then be configurable.
>=20
> Yes, this is already implemented - you just need to pass "--verbosity deb=
ug" to
> the script. Example based on commit 8648aeb5d7b7 ("power: supply: add Qua=
lcomm
> PMI8998 SMB2 Charger driver") converted to a patch:
>=20
>     $ ./scripts/add-maintainer.py --verbosity debug $u/upstream/patches/t=
est2/0001-power-supply-add-Qualcomm-PMI8998-SMB2-Charger-drive.patch
>     INFO: GET: Patch: 0001-power-supply-add-Qualcomm-PMI8998-SMB2-Charger=
-drive.patch
>     DEBUG:
>     Sebastian Reichel <sre@kernel.org> (maintainer:POWER SUPPLY CLASS/SUB=
SYSTEM and DRIVERS)
>     Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
>     Bjorn Andersson <andersson@kernel.org> (maintainer:ARM/QUALCOMM SUPPO=
RT)
>     Konrad Dybcio <konrad.dybcio@linaro.org> (maintainer:ARM/QUALCOMM SUP=
PORT)
>     Nathan Chancellor <nathan@kernel.org> (supporter:CLANG/LLVM BUILD SUP=
PORT)
>     Nick Desaulniers <ndesaulniers@google.com> (supporter:CLANG/LLVM BUIL=
D SUPPORT)
>     Tom Rix <trix@redhat.com> (reviewer:CLANG/LLVM BUILD SUPPORT)
>     linux-kernel@vger.kernel.org (open list)
>     linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and =
DRIVERS)
>     linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
>     llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT)
>    =20
>     INFO: ADD: Patch: 0001-power-supply-add-Qualcomm-PMI8998-SMB2-Charger=
-drive.patch
>     DEBUG: Cc Lists:
>     Cc: linux-arm-msm@vger.kernel.org
>     Cc: llvm@lists.linux.dev
>     Cc: linux-pm@vger.kernel.org
>     Cc: linux-kernel@vger.kernel.org
>     DEBUG: Cc Others:
>     Cc: Tom Rix <trix@redhat.com>
>     Cc: Nick Desaulniers <ndesaulniers@google.com>
>     Cc: Nathan Chancellor <nathan@kernel.org>
>     DEBUG: Cc Maintainers:
>     None
>     DEBUG: To Maintainers:
>     To: Sebastian Reichel <sre@kernel.org>
>     To: Andy Gross <agross@kernel.org>
>     To: Bjorn Andersson <andersson@kernel.org>
>     To: Konrad Dybcio <konrad.dybcio@linaro.org>
>    =20
>     INFO: Maintainers added to all patch files successfully
>=20
> The first "GET:" output prints the output of `get_maintainer.pl` verbatim=
, and
> the "ADD:" output shows what exactly is getting added to that patch. Hope=
 this
> is what you were expecting. Please let me know if you'd prefer any other
> modifications to this debug output.

ups.  I tested with --verbosity=3Dinfo but not with =3Ddebug, therefore I=
=20
missed it.  Sorry for the noise.


[...]
> > While testing, I thought that adding addresses without filtering-out du=
plicates
> > was odd; but as git-send-email does the unique filtering, it doesn't ma=
tter.
>=20
> Since I'm using `set()` in this script, the uniqueness is guaranteed here=
 as
> well - there won't be any duplicates.

I thought about patch files that already have 'To/Cc' headers (e.g. =20
'git format-patch --to=3D... --cc=3D...' or by running add-maintainer.py=20
multiple times for updating the lists of recipients.  The result is a=20
patch file with possible duplicated lines; but as written: it does=20
matter, effectively.

Kind regards,
Nicolas

--jjpaJEitG6LbK2XV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmTolDgACgkQB1IKcBYm
EmkaMhAAkHXsFKcEogjsqkNaOcKrHgDBA9BLV6YXgTPR/BhMl7qgIbgDwKRdK5kG
RZalx5oXxNTiGLTUxEZE+hBy/edkHXwuH9VQRRx+x7TuFijPP1vrU2UHQe/Cp3zP
+8TueB4h+1m/4QryDXX8gKDMUA8gBym9r48A0K2Vow2/KbKbnEw9fngx04csW9oU
Kv/SPio3lT1xq4YaaHgVsyLwlQFRQqKKdLwn08U4D0RTQVuNwlv3Ozu/QnMhAtSf
SPFJO+xU2SbXoQxRnKBlno1rHwsfGM7MmMpbViOzOl/r0pXAr29KEVx3t/ZwBRzn
g+J0hzJ6uh1TRO2m0wX2tg1SeW+kCAHzEXrnh8LM3Z80AOEFQvRV47LwAT+86X56
CxdPq7ug6B5XTJvGUxJ3asP3AGURIX8SriWScRv+r+WE12xg7FhvcV/Oy7m6ZUhi
4B54Nob7OmaDTO93ZBW0RxKItz4mgZ0OGNqDhcey7bpmROimFArZESZQ+kKB9fes
z6oHsDY+3TpMCSkDIXd9neZXAkU9krOG/uihmYOiyz39WENXcAsOYkh1UZd+u2+b
hRLyeKIl9Oy8+r4wg9It0hyj2wOXshtigbU9tXt/4X3IVFFv43MplR0hetiMt5wx
xwuWnk+MohuUCK2XU5TplUY4lURbBqgGEPecu+w3Ac51Ejltb1Q=
=Ofrj
-----END PGP SIGNATURE-----

--jjpaJEitG6LbK2XV--
