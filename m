Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3254877C529
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbjHOBiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbjHOBi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:38:28 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B66E7;
        Mon, 14 Aug 2023 18:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692063506;
        bh=qnAqj+hZNykQINdaeXLzToO0u0U7pLzKlnIW5MitiKo=;
        h=Date:From:To:Cc:Subject:From;
        b=NjdaXPTVUU4GeyWpyH7ZU0U5IxnMsPYQP4pzd4m6sfMZ/nc5xsrvzgXopvt7BcJBv
         j/L2wooQ8FA2ooHujfP0B5dfd1ndEvfWUwiMBdbioOD5OmY2+qJfSHY9jeq1EmPSm0
         QzIFsD6BjDtagEN3GhP/NZTqTnXMZ83uyuxPI/527BTBNwh/fhBJ4qVbT8wLWNzpLC
         G2PXNKWJeXC1owLKwachOoz6qoJknYrN042gDg3lX8noG0jH/EwiI74wB0RB+ZYRgX
         RTSEIgP0lIbDdpRL3tCM8QdTPCCpA1pJ4AbqlP5LLoNw9RtFTcK98Sri7R+CiYWr+p
         2XleV7+mXzdBw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPv6m5YcWz4wZx;
        Tue, 15 Aug 2023 11:38:23 +1000 (AEST)
Date:   Tue, 15 Aug 2023 11:38:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the amlogic tree
Message-ID: <20230815113822.613b514b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Gh=HB_3CQEeRgbdWsZMtk=p";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Gh=HB_3CQEeRgbdWsZMtk=p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the arm-soc tree as a different commit
(but the same patch):

  b18226ffd080 ("firmware: meson_sm: fix to avoid potential NULL pointer de=
reference")

This is commit

  f2ed165619c1 ("firmware: meson_sm: fix to avoid potential NULL pointer de=
reference")

in the arm-soc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Gh=HB_3CQEeRgbdWsZMtk=p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTa1w8ACgkQAVBC80lX
0GzwLAf/YF2gsl7cJv/qvY+tKwJFABCYn0rGAth4VfBgQe/vL4O9mOflaTOrJND+
LoVsVblvASkvXSoqXycycxTa1jmTkJXWIHeSq+2XQl4IVJ/Mr3ZTRRSyz8MRAyr1
Zly3QCiNagLaceWQqfanAKRlD4gx31JDudLd1FAozZC+Op4HQAm/PbnF5/l/NMZH
IqzAzI2GZTkLqexwDzh+dyQ3D6cU8sBNr3f4ZcIPeo65u1oBIwoXMfh6aVp9iCdy
QYAPyuwIBEcEt+Qn2ONkh+9vc36ZgysJ+I4ZemqornXUXii2MbiZfQRPxEP8Zqph
p4rf1BrC+WVeavkTngPRwlaLP0EK7A==
=vPrd
-----END PGP SIGNATURE-----

--Sig_/Gh=HB_3CQEeRgbdWsZMtk=p--
