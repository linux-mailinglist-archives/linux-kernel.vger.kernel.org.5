Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7E27E92B7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 21:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjKLUiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 15:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjKLUiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 15:38:10 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCC7B9;
        Sun, 12 Nov 2023 12:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1699821482;
        bh=LQ59e3qPsDrAD/NcQux9AwOGSLXPZOjPSWGpDGNMfwk=;
        h=Date:From:To:Cc:Subject:From;
        b=AnU/slJDAYKazYDm+Eu3NLL7svsOj8EZHFZiswQS/ol3jGTJpQisHFIpSH7g5PwbE
         saEy3e3MoHyuO1YFhTDeS87Tv0zy3E+ciCeS+7wZRmHYxBzqsCcAj/0SDE3NdZ/37f
         evGuWA+kTBnKsObgTNQoKWLWROSJzIfo9S3v2ogWKY/70XhSHep62d3nTU6P6Tznfw
         r2vb9qGLx1JmeOolr9KeyFrISxH+kBOZb9CRbOScwW7oktRD9a0i8f46FHz6nyH/ko
         MhGj6rVUiuyifZ0bACxOsMhclG8X4NXEgwZ6PAj/IDAlgW23l8Msekef6l3Sd7gGGO
         WhId6gfApqq7A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4ST4Bf1xPhz4wnv;
        Mon, 13 Nov 2023 07:38:02 +1100 (AEDT)
Date:   Mon, 13 Nov 2023 07:37:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the spi-fixes tree
Message-ID: <20231113073729.7679610a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YcdPbJfNv85FLhwMsGGzG5D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YcdPbJfNv85FLhwMsGGzG5D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  4f646616d11c ("spi: Fix null dereference on suspend")

This is commit

  bef4a48f4ef7 ("spi: Fix null dereference on suspend")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/YcdPbJfNv85FLhwMsGGzG5D
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVRN4kACgkQAVBC80lX
0GwbwAf6AiQ/XOe13Iphe+NowlutMcBnB6ZsCvkRlkMFwmmsv3B1y0gOZ/NLORvA
KBXnkFO4trtdtz9QdiHNZYkz9Bz+lNev9wRsg4feXtNRAML/PVuCQrY0FXj0QeZ/
vToltluoj53bLa5LtukjWeOXUBedlA56pjQEYPIyoPBImYyFJdoAwwIRrTSYiduh
nQayYspP2OSesWATwinaWCpGkWWB/ANQzXSWrhpJmNKl8crEaNV4KFcisvcL5j1X
T+JOs1v4UlnSc04Ir9ba7edDBnCRD+Eix4dDBFjQQCmXV+i/b+JZucYAdidKq3ot
qqbTh1/GEMm3Jr8vPaH/ZCmug+IClw==
=UWFp
-----END PGP SIGNATURE-----

--Sig_/YcdPbJfNv85FLhwMsGGzG5D--
