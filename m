Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA5578BE5E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjH2GYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjH2GYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:24:32 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EDC18F;
        Mon, 28 Aug 2023 23:24:19 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.30]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MHoVE-1qVyDm38PW-00Eqhu; Tue, 29 Aug 2023 08:16:56 +0200
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 7DC8F3E75F;
        Tue, 29 Aug 2023 08:16:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1693289813; bh=Tee/zKgIxi0MjayamYCOiUTorl30qi/G3fi5jQxu9uo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i77dORvdD3FaDs5i6DL8ZDK8Unesg1yl+uxIVHscPJOTiKMcP2VspJD2G9iOvGdwt
         g66IuuMz7ZWJ6u7k5WjE1Y4BlJcxwiuINQexDhpLTiMQ0wsn0nnwKtN8vhCBKG0iZ5
         ZvRHgNWgIPsQ0q0qgSPI44uFj8TAzGUWkgXHMIw8=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id A94463949; Tue, 29 Aug 2023 08:16:52 +0200 (CEST)
Date:   Tue, 29 Aug 2023 08:16:52 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/2] kbuild: Show Kconfig fragments in "help"
Message-ID: <ZO2NVLipjlzIh0YS@bergen.fjasle.eu>
References: <20230825194329.gonna.911-kees@kernel.org>
 <CAK7LNATcTw+btQVri7SBA8gFbDNMYz7D2gMQaoZp9sQGFjCw8Q@mail.gmail.com>
 <87ttsjlmho.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JaIvwu+DOSVoCCpT"
Content-Disposition: inline
In-Reply-To: <87ttsjlmho.fsf@mail.lhotse>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:OBnWK3wK1nt78UyoQFBURm442v+SvSoVVT7mPovCe98T1OcdBRW
 545IdFbHubnZv1c8kyxGda2FhHOhq6S+JNQcmvQsPh86El8Z2oDObUTGZNkSYi3rBEhtPpe
 iFj+PMJcKoRUGTqyvPJRbQqi8muo/oIxULf5nsWJp9ECrUUtbCOcliu478mDcsJIYXLPwgG
 aRaGMaOKjgoTFmVfIQeAg==
UI-OutboundReport: notjunk:1;M01:P0:6P1zPygrMg0=;IpUXK5xv9kMp0SW08XHoxH64TrM
 eOiuNqzge622ysvCqOch2zOQMyANgRq5V7iZDY+HHyIfMT7WgAaxy9fiLlMcj7q/8S3oi7bIu
 q6fnbnO5tBoc7CnZa/PDhtHctjm0+74rkKxEm3wPTj9rJipLs+lzrdKBV59KM1FzhJvb0N1v7
 AJN5U3DUj8wNSXw04eTTbd0s6xoy8pNv7SNJ/U4UF8K9zGqiQGZcP6QZEfFol4UcAGA6g6YKA
 uBtb4uVgpmUcmChfX3lNUhkGuVRNSs+0TrmuCtp+Q9MbNNsmT4QJtI+DPuuDv7pcX7DzdnQFj
 Ebyvzq73wqbPKXX+F2LBLI/NhWgHZ34Iq9SHFhuiQaf5vH5993WezLJqa0+xPEoyuQj+ZNmA9
 Q2fWJ818nIJe/z35AglIHMM/T3JHtadz3oDri2y7PVtAYMWfx2EyKWDfLRI9iXcBOwFV0mgGQ
 KwEo2RQrfnnTddzISisWfsMLEOQCBQwt7vtntJroZDoonBa5zOB25uoyNpC9fPmBNqMfXUzP4
 MUDUrXgGsNhdttWCj9Ri38z1QBXA9X1vDvjVvxPCSbSVTNAybi4O5xt8gAMCLJJPnqmTVzVQI
 +ynCTczgTrQk3ZT3lJ5TVziNy04WIjIw8xP57Vc5PDCOSt9wB0rsp+GbR+wgaq1knsXQrnn0u
 GzMHfsBuYQTiChcVbueaTBz36ZGS7CsYMhlvamYGF4vTsGyNaw7UDgNn/tAq+l99eD3LxBN49
 5v52XLH9XR/A+Qq80fPB2aiai5Y+q1w8G5XURAJfXYSj/Y7YU8zInJo4/4jzi+m92apyb17Uy
 2QLZvLlCOeEPEetO92T0fg4giJb6fkBjj6aHquGfoViXtyZ5El1oxLpNCeTwoGnCO1FwtCn3u
 xq6im4E4gT/3YSg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JaIvwu+DOSVoCCpT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 28 Aug 2023 16:17:07 GMT, Michael Ellerman wrote:
> Masahiro Yamada <masahiroy@kernel.org> writes:
> > On Sat, Aug 26, 2023 at 4:55=E2=80=AFAM Kees Cook <keescook@chromium.or=
g> wrote:
> >>
> >> Hi,
> >>
> >> This is my series to show *.config targets in the "help" target so the=
se
> >> various topics can be more easily discoverd.
> >>
> >> v2:
> >>  - split .fragment from .config to hide "internal" fragments
> >
> > Please do not do this churn.
>=20
> That was my idea :}
>=20
> > Like Randy, I did not get "why" part quiet well,
> > but if you are eager about this,
> > you can show help message only when the following
> > ("# Help:" prefix for example) is found in the first line.
> >
> > # Help: blah blah
> > # other comment
>=20
> I did think of that, but wasn't sure how to do it in make.

Something like this should do it:

	@grep -Hnm1 -e '^# Help:' $(foreach f, $(sort $(notdir $(call configfiles,=
*.config))), $(firstword $(call configfiles,$(f)))) | \
	 while read loc dummy helptext; do \
		tmp=3D"$${loc%:#}"; file=3D"$${tmp%:*}"; line=3D"$${tmp##*:}"; \
		[ "$${line}" =3D "1" ] && \
		  printf "  %-25s - %s\\n" "$${file##*/}" "$${helptext}"; \
	 done

but this neither beautiful nor elegant it likes to be improved.

Kind regards,
Nicolas

--JaIvwu+DOSVoCCpT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmTtjVQACgkQB1IKcBYm
Emnu6hAAiTYwlEcuArYqUntbY96On0jGhH2Ro38eVcbugkgaGXZdG2o6LDj7+Jv1
diCScvmsCCd0LT80ZjU8liNtsde+lqrL5XMAnELCaOMFDQPrLSp8HQ1NoPGkR3G7
He4w0psuLoXtKYlfc5txGbe7xiXqouA0UO0p+t/LX+roPbGFNsB6801KbXfHdvQu
NeQM/chgqVRFESOgQ15prGDNjfvhCkmPL0tnsLTWbhmvH0JPhgkwbJDyJfoTiynV
+RSgVhYh2IF2pN9NHcWfKspTNX0oBQJQ0OZMuFUNJz0+wOebpslo4jGbKHE85XD+
eEAJ93mWyDzA1eAoCfEb/mJqag7FWYTou+lIxSnPwdvhp21OS6wcYxp0jSjHCYGS
bIyN/i4AGB3nGufPwyouWbu7N1ObEuT6M80sDJOla2tRCC8JpmXkMfyP6My/TZRl
h5NPK9cirqd8HYUnayL7FUYX5jgfSgm+4G37gGHmzdPor2Ugr3QEDCUIssTyw22j
v3EuoqJHuGTQWo80W8h07CFNgMxtW/zrq5ArTI9/N6vqtFQm6pec1WTAKC1/1pOU
IaMdv/ZrebiU5u9QPGGL2qi4AVe8EWKMMzsaUvfVFfh19pW0KxMW4y7afFy7t+6v
ICmnB7nhu0MM51uchAm+GjkTVLIEwVLbuq+hv8WWjpV4bfexyw8=
=Puw/
-----END PGP SIGNATURE-----

--JaIvwu+DOSVoCCpT--
