Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BA37D5F1E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 02:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjJYAiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 20:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjJYAiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 20:38:08 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C60B10E3;
        Tue, 24 Oct 2023 17:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698194279;
        bh=rQ2n3vaXvoxlfkwkAH5WFbjgcSuMcTxbu+XtzHZZmho=;
        h=Date:From:To:Cc:Subject:From;
        b=LbztQwO3SbPIUtHt8p3udHIuESMeiOkdEWZrUeKmA2PuhbqG9ejh6pL7i5nA2AETO
         EU39yRLFnWEXWdjp8Rab+SvdGSLW8vssHA5OdY5iKkEoBp6zEHfCdIT3bIBNQGh/Tc
         aZod+szJMZBXtNIpQ3rVOf3MPk+GTUb0DMPVxEwb7lgkivOhL/rg9hvZpy9J/UXePv
         +uR9YJpt2mhcwhV8/PJRcZ4zDSwo2qWA6z1AzA57GIHlGcLbGEo6MF2P5x7sABuxeP
         kyNdNq03EdP+TtCcCFXj2vNX1cmzVZcwK0pMmkWgl54CNHiFTp9wY9Rn361bV8GmKH
         lz4Jznpy9WTlg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SFVQG2vh1z4wd4;
        Wed, 25 Oct 2023 11:37:58 +1100 (AEDT)
Date:   Wed, 25 Oct 2023 11:37:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Greg KH <greg@kroah.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the fpga-fixes tree
Message-ID: <20231025113757.61688e0d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mnSsjN3oTgLkcDI_PksycAq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mnSsjN3oTgLkcDI_PksycAq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the cha-misc.current tree as different
commits (but the same patches):

  03d4bf9ff34a ("fpga: Fix memory leak for fpga_region_test_class_find()")
  9221d5ecebf0 ("fpga: m10bmc-sec: Change contact for secure update driver")

These are commits

  28926daf731f ("fpga: Fix memory leak for fpga_region_test_class_find()")
  1e55c5200dc7 ("fpga: m10bmc-sec: Change contact for secure update driver")

in the char-misc.current tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/mnSsjN3oTgLkcDI_PksycAq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU4Y2UACgkQAVBC80lX
0GyLbgf+PhR+iVDVeTDNYqTUD27WSXDMJTKm1kMy+zC/tdOJx5OPw/JY+ujWJXdn
dODaI/7sGefHRtLTCldaJAwtOy4MZMC3xPy9nNaFtZrG5dR+5ziy1Wo7UCr6Ng0k
7WAyPO8kB+0KOBp/hvNmO8Z48a9lTU7v8wXa4edF2gGjnWtnWBtP69Kwj8X1Xnk9
Em3MyVyY/RaQQMDooESyGkXZLJtVpBEBoahEsxnYzwQGJ346zUSo7qnv7tP9SpxH
K8RlDKw84mU6ldFWHCqgTllU5POGO7uDVdAucGRBOJJkrno178icbkVvBs34Cy5n
z/dHt4oBYkyQJ1vwVYrC4vbFM4SVRA==
=OpJ3
-----END PGP SIGNATURE-----

--Sig_/mnSsjN3oTgLkcDI_PksycAq--
