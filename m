Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC547C7963
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 00:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443011AbjJLWSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 18:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443008AbjJLWSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 18:18:42 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14687DE;
        Thu, 12 Oct 2023 15:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697149113;
        bh=hKiRwglK7a6PIKIQCMGEa0tPqTrX3Rt73NFqJr4X/S0=;
        h=Date:From:To:Cc:Subject:From;
        b=BwHJ0nvZesRHaaV++2YWJP0Hhb31JJsJbpsCev57iLj7ebXJzDgyOy9DaWkQ07D8U
         Qk+RxdT88dg0ieNg8NX/Jheq7BHPB5QKlTSTTJNF1aEn1sUXcYSecVzq+mDNlqM7e3
         cgfHt1eMfHmlHFrubGqK1+XYc+8j6N79N0vpCGVySNJwD7AJlpJxV+nuOBAPz7uF4x
         M4Gla2K/nwytQlmX5kripiRTrITA44DVGjwWbt3BnSwy5Pou05ivfyIDWRK5fUagGF
         fTyT5yJ4pOYCd2S6P6uibhCsso27fqmgmqNzfGBbznJrYEMB5Gs/9/w8iF4pKkJ+Ko
         5DgyfqR6HnRpw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S63tx039wz4xVM;
        Fri, 13 Oct 2023 09:18:31 +1100 (AEDT)
Date:   Fri, 13 Oct 2023 09:18:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Ralph Siemsen <ralph.siemsen@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the pinctrl tree
Message-ID: <20231013091831.60a032c2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2NysfGV5an=jBmk7qZOLhC=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2NysfGV5an=jBmk7qZOLhC=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  73394a1b2194 ("pinctrl: renesas: rzn1: Enable missing PINMUX")

This is commit

  f055ff23c331 ("pinctrl: renesas: rzn1: Enable missing PINMUX")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/2NysfGV5an=jBmk7qZOLhC=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUocLcACgkQAVBC80lX
0GxGgQf/ZVzAsk+SuK4KsB2TE+ky8tjqop2WchGyUNQklitkb5T+i55z2oicJ5x0
La5YMCyeC7qi1n/4OB1CAeH3btdj6OBiOgat1XbWa32TjQHZ/5N1AqlTagaPYCTB
5EjFhWCtOAc7u9NE9DfmfHCMkVlydjRvL9O/gS/T6LUdU/QgODBiYbAn+AZXoBw7
FjBDkiOb/DDNGfNmVcRWh7/yU25KMqYRvehuI7lRABdO4N6tJMkdFXbdEXVhFr8E
hHYDHge8FUHWx0YFRdMMzrp7SnLLAbwZ7PPYO3B4m+yuDMLLvfZzjJ1bA4Spx1bN
buHJXZqSXOfWEii75MPlB1u+OjQ1QQ==
=tfGU
-----END PGP SIGNATURE-----

--Sig_/2NysfGV5an=jBmk7qZOLhC=--
