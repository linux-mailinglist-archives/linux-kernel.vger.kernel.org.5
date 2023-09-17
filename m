Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF077A3E11
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 23:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbjIQV6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 17:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239543AbjIQV5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 17:57:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9EE127;
        Sun, 17 Sep 2023 14:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694987868;
        bh=y3MAnx7rsHT3dzwBAeafaGFGL39ILgsvphgeCDmV0Xg=;
        h=Date:From:To:Cc:Subject:From;
        b=uKJX6jrkoKYa+p/yUYXW5OK7/ujSr5L+OTih7TFjC8IXykzkp8rCh9cf/l9nyKHCq
         /abul/dkBqI5FkuFvaQrvKl5Xv9fg/cUjMpzjW+UUQYqglXypxO+6dMkIRl9WGpVmj
         soHC5OVZn8uvCqB2+JpdqqRBbguy7mhJTiWwJ4zakzv2wHoG0fNcwguwWmMCDIKrDI
         h6sYSJJvSTZGEoEFoDe0BM3B18Ht4TI9NbkT9T0+v9p41pxTDEg4i37ZD5lDAFhH1z
         MQ8pYzlOrmQCnm8ay/6pTv+4NEteC78pxB2uMBrUQiPrPkk1nafllHH2irv9eNxAhG
         HdozK0M0gCkww==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RphcX2vndz4x5m;
        Mon, 18 Sep 2023 07:57:48 +1000 (AEST)
Date:   Mon, 18 Sep 2023 07:57:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the pci tree
Message-ID: <20230918075747.145bb329@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/T=melbAQkp3S.nF3QyAi.ES";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/T=melbAQkp3S.nF3QyAi.ES
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  3731355b37a3 ("PCI: endpoint: Use IS_ERR_OR_NULL() helper function")
  951545a8fd06 ("PCI: vmd: Fix inconsistent indentation in vmd_resume()")
  77e50a40c63e ("PCI: cadence: Drop unused member from struct cdns_plat_pci=
e")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/T=melbAQkp3S.nF3QyAi.ES
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUHdlsACgkQAVBC80lX
0GwtYwf/X9GzBkp9rkQ7bEGfVWwMQDvN16TonZPKifTixtyYMHBAhAnElgGNgDsZ
eAEmTkV0qZUAkX2SX9EiOBsBPVY6VtwsD3CqekwAUIeBs6LfMsNtFzBjz1Cnkz8B
kzPj1X2DMy0YzA56aPJO2o0K7c1I5YzDstflO+Hve4YmvvqKL7ix4hVYsedfxHLF
ieSxBMA9QsVM0iDAkIPob675OSmYVWJtyAmBrEHnKhfO4vZMen6xKBiwgup4Cu+J
iIoe61c6D3f/r4Zv5Ou2lg5HHLIc+WwfFMegMI/PyZDx0qC3iYd0xHu02SmK/1mp
H+riXxmCVumwWuDFIT5CIv8v9NO6dw==
=YzVu
-----END PGP SIGNATURE-----

--Sig_/T=melbAQkp3S.nF3QyAi.ES--
