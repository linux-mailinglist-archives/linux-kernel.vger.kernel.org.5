Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A1B77C5C5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbjHOCUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjHOCTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:19:34 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660EBE65;
        Mon, 14 Aug 2023 19:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692065972;
        bh=XU3yJ962BZ7f2vYOGU+dieM6eFjIStVQ3KDEtM07nEg=;
        h=Date:From:To:Cc:Subject:From;
        b=pp936LWRewVHq/mUj94447DFwfO4lwILrPoQb5cWfLI6A5wx5mGijOjBX6s1nfUrf
         6CwqagN1VoVfeRvVVQwB9VKx/PbCRqDqgu0Ahqkz+AlL0R0qwrNqIK/bf6gmBjy6ga
         VkFRYXb5WrzMwl/fDpOUc6mDQtFIxJH3gIZ1KhwUIWzG7Q0aqLblAL6jOEXHbFU/IO
         7yEseLhjP15N2U71R7JBW9+C/+g8Ny9ff+j0Xf2ulpZy2UWT6skLyerCVTYmYlDAFn
         ZGZ5lb3uP4lnkIfug5GfOYkXPGknEj5PRUsp9S+b94HBToVitrrq+MEQ9mdDQ9r4eZ
         CQo70cZBH+YKw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPw2C70Wrz4wb5;
        Tue, 15 Aug 2023 12:19:31 +1000 (AEST)
Date:   Tue, 15 Aug 2023 12:19:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the jc_docs tree
Message-ID: <20230815121930.6174e047@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FmI90SYtlb1z1h6LVIVHeX9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FmI90SYtlb1z1h6LVIVHeX9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the arm-soc tree tree as different
commits (but the same patches):

  f92682a736be ("MAINTAINER: samsung: document dtbs_check requirement for S=
amsung")
  e12cf84634f1 ("Documentation/process: maintainer-soc: add clean platforms=
 profile")
  1b46ecf119d8 ("MAINTAINERS: soc: reference maintainer profile")

--=20
Cheers,
Stephen Rothwell

--Sig_/FmI90SYtlb1z1h6LVIVHeX9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTa4LMACgkQAVBC80lX
0GzVGgf/VIBOuWu7X2iC4GOPc79Yw3DR6hKm4mZRyYCNLlIjcCaDYDeSkEjqTyc3
kPhh73CEjZc8te3L+SEvq1SPs3ppPIJl2hXGCE5qFP6ER64PC4Jm0pGMBHcGXPEB
fiDnSW+NfmPyBUg3kj5ULA3dVDti8FX6XUz5s666ioFI7vroiaFuAhcfGov89uu2
bNxflaP3PL2QCw6SsXDvXIBLFq7QmfIRzeDGtu8Rqu7TrS+7BcjUZ8aLpXhlQwtH
R7xtDB7pUaWejgLYGhqTMHhlsUTl5yUy9LOHlXSA/Qqpkp2HQze2pGOpajyAJ+5q
QdQwER/kD274Du7uj+GvO+0+RSYk2w==
=awBm
-----END PGP SIGNATURE-----

--Sig_/FmI90SYtlb1z1h6LVIVHeX9--
