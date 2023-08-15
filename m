Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD3177C839
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbjHOG7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbjHOG67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:58:59 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DD0E45;
        Mon, 14 Aug 2023 23:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692082737;
        bh=tRD9V3SZZ/ZdRZnXIe4M5/31IA4xtgNRtQavwRuaq9g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cj7D6z2eiwcOaG8wAqSvM41Kmr1fNtqJ1zseMYuk9wbv+HKUHAFl3eHgnF+uyA6fF
         IYpX1yUym1AmpSyiqz1MoYgPJWG0w8l7PPmUIMwGSTKj3HfaVVYGu/1WSxFvX0YdFb
         u4rQGSwaZlPM/ZeXg5r2F9uw1Go2FAF15IRkM4kfVGd1qRrdOoBvKh1HyQT/ST6DGB
         DqezbH1kSH/XrB7jfm2RA9fAQRBXNx8fcjSZ3wJP21Gs2r3F+9R6ip8yklWvWnuz2a
         +0mre9uIOJdhva+qJYMUnhUTehrVOxbbACRtjfCFyKzpWiNG1n79EIU0FKvFkglVA3
         Ben1f8D2wHPkg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RQ2Dd1WVDz4wbP;
        Tue, 15 Aug 2023 16:58:57 +1000 (AEST)
Date:   Tue, 15 Aug 2023 16:58:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Henning Schild <henning.schild@siemens.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the drivers-x86 tree
Message-ID: <20230815165856.051fb20f@canb.auug.org.au>
In-Reply-To: <20230815165725.30a01fe9@canb.auug.org.au>
References: <20230815165725.30a01fe9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vM9okV9eVpnsW5WUw8RmpCh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vM9okV9eVpnsW5WUw8RmpCh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Tue, 15 Aug 2023 16:57:25 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Hi all,
>=20
> The following commit is also in the watchdog tree as a different commit
> (but the same patch):
>=20
>   3fce06406c59 ("watchdog: make Siemens Simatic watchdog driver default o=
n platform")
>=20
> This is commit
>=20
>   926df9ae133d ("watchdog: make Siemens Simatic watchdog driver default o=
n platform")

in the watchdog tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/vM9okV9eVpnsW5WUw8RmpCh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTbIjAACgkQAVBC80lX
0GxMDAf/UN9T/RUR1QdmngnG1ieHcdCYFKJW50MrcsiZsbY3WWbfSX0C/myQkoKh
PXM2cM1rzBnLyy7Y9aVOtC0HW5dqqL4HEFj8p/4sTRmbk0s3jxPblIWsAUqQPZLI
b+xivDhq3PNCzsBOaW5jegjYoJdFd/8s+1trOGdCnACB5jmce7SYPc6HApXmbIHk
vRN/UlPURQb6J8sk07U7wFx2YSFEV9njrouzlngujvkGZL9D7k16eYN0Vcl7wgSE
6hrPG9E7kr6PkZSm37K49M1nO9yb961SU1hQzEZET7xIFD/xi0t+S7tf4CfDLgYn
S21x7qgKEN3XVbdy7AZ0slp61eJP2Q==
=H1cx
-----END PGP SIGNATURE-----

--Sig_/vM9okV9eVpnsW5WUw8RmpCh--
