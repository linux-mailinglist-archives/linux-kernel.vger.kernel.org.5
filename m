Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A867ACC16
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 23:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjIXVuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 17:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjIXVuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 17:50:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65758FB;
        Sun, 24 Sep 2023 14:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695592238;
        bh=1j6AlGE2BnNgmWqvmla1RjyclDuH6rXMMRFD8unJtBc=;
        h=Date:From:To:Cc:Subject:From;
        b=SpEu5nGtofGon3trH2y1QhUpuoZgaKzDYnq9pauUGE9urbPJUbVb9/vSxfsoyWXeQ
         emX26/yIIQn/VvTW+0YS6QbtG+mA1v4xDSt0hXfHKW1xJUOyMR5FukW6Etx9+MX9/F
         448Dt/2oUyBiCPKYF3/qPKYXChbXXg4jHQtf7GKtCMcZbzByz5b+VZI9eEdc+pab+1
         euYTqvxrdViLJ/QZ1Krh8mV8PKOl3rdZLIzY5CRGMkqk8w1bF/Q1V1sDl29BAOxs9S
         au1tMsAdh6HY7rsYyqFcdPQORIbeU4y9xenRQs1jurM5Y/s3InamChNMM5sWVa16do
         e1PZTgV/Z9b+Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rv07218LQz4x3k;
        Mon, 25 Sep 2023 07:50:38 +1000 (AEST)
Date:   Mon, 25 Sep 2023 07:50:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-bys missing for commit in the mm-hotfixes
 tree
Message-ID: <20230925075026.2a6b4e65@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GWpMkRG9mCYzjess9OgXnm=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GWpMkRG9mCYzjess9OgXnm=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  48248e468270 ("mm: hugetlb: add huge page size param to set_huge_pte_at()=
")

is missing Signed-off-bys from its author and committer.

It looks like the commit message has been truncated.

--=20
Cheers,
Stephen Rothwell

--Sig_/GWpMkRG9mCYzjess9OgXnm=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUQryMACgkQAVBC80lX
0Gy3TAf/YuYi4H5j5e51Yav+ooqOFbANXaV0HJ6/zFbDwjhesjN74vgNZAFmVpvS
VtH451NGIkC2nTlQv4OW4G/dV6BaboZI6vlOia/DLUfkc33M1F2EMMmuxqmkSpbq
SVFdrzRfs40+X7YG3N7UsVQ2DTVM3+O6UIWXfonLe2ss7GiNLt9XlqyfkP++sUKA
TLRISa+xYCmv8sylQSLtUh8HQrS2+tPjZaJMDeFuca+fQm/tNE98ga1Jdnem23CY
cPlTY2rPLcwrcZ55bcXXkrC7kPrrd622lUz3Bq72BV+y3DRFtWTRi1tCyZD75SDI
34ufI1DMSkP7e4dA9y/Gq9M25UkLBw==
=ysXl
-----END PGP SIGNATURE-----

--Sig_/GWpMkRG9mCYzjess9OgXnm=--
