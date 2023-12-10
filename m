Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F5280BD74
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 22:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjLJVwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 16:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLJVww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 16:52:52 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462C7CF;
        Sun, 10 Dec 2023 13:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702245177;
        bh=N6L+jss40rpJhCimyakhzVZzSqFKdaMB+fAnx6lIq/4=;
        h=Date:From:To:Cc:Subject:From;
        b=qj8r+SHSgh3oMHo7+UXSqIvXjxK0MUSNb+dRzUu8HV/aw9VwxcUr88Lk8VJQnOOQ/
         rmPuoU9Ku/n8jc7RJRhUw9LyeB4bw7QvZZ2+3L60ZWPDwC4e4ySQjkiD+YYpjZMXnZ
         KorHZeka5F1f1P1YGk3/a2RIGRuLRI53yOWGHVszbvzd/0MG7a8CK2XFnQ6+Uaizdp
         +VkJ4SZrOQczICvQ/lf69Ac7NVjXCJXUc+eSSQUGn1f3s9NIp5q3SzkNcxOU7kaGzV
         WV7y9SsyXa8PgssQDoMpVInpRePHr9iG7MTMxJ/iW5takfbTEFt1qNEIyyiwo+sTaK
         b3ww08J7Eio+w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SpJX80pw2z4wdD;
        Mon, 11 Dec 2023 08:52:56 +1100 (AEDT)
Date:   Mon, 11 Dec 2023 08:52:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Uwe =?UTF-8?B?S2xl?= =?UTF-8?B?aW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the pwm tree
Message-ID: <20231211085255.405d4654@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/H65QUyVnMFD4cdSQDFLXHxA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/H65QUyVnMFD4cdSQDFLXHxA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  1ea832ef9787 ("pwm: bcm2835: Fix NPD in suspend/resume")

This is commit

  4e7a8dbd2bc0 ("pwm: bcm2835: Fix NPD in suspend/resume")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/H65QUyVnMFD4cdSQDFLXHxA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV2MzcACgkQAVBC80lX
0GyQZAf+MsWqXao/LcgWlCtkEYgMasSg058DEkBaqfag70wAn8sBRBhX6Bva9o3L
+uuAEq0kgKRnBrJxRd3Bv3t3KRMreGmvQRxqsSBF9NXqNuS9tFKBJsbJtRBjTj02
BpQ8v9chEZrKmfHLUUkkirNWTi5UW39zhWK0ZmedMm07u00hCXQjh+tcyrfHrQd1
CEsTOV20XbCryw3q+Xn4z7+zrH3dVOV/OkwpaEu4kP+IWI0iMIJ2NnMmunIce3HH
fwhefHe44TlPWt1e+LLKDPPIZA81BwjYlv0NMKf97xQLy9WYo61t/E9CoVkkSYEa
5OxgjhUnNGxs53x3rMRyKstGdK7ZOA==
=dOus
-----END PGP SIGNATURE-----

--Sig_/H65QUyVnMFD4cdSQDFLXHxA--
