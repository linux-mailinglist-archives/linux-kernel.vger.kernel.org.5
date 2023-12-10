Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9363380BD86
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 23:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjLJWJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 17:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJWJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 17:09:22 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6BCCF;
        Sun, 10 Dec 2023 14:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702246168;
        bh=OROGTPtbJutOQnBMNLV3FocVvjzRnNq1pdem+YbzpjQ=;
        h=Date:From:To:Cc:Subject:From;
        b=IUXkpbzmZ3U3/BcrEuL0hppS9JGRHxfHRD9cXR5ubgfQAFywjJGO557J63KcVGI20
         WssSHY2EcrG2zcCFasy7DnPAZG8Lq1fAzOBh10ywJh0xzqNUUDC0II8uGzRUc0oTHn
         AFU6vR7uHiMHp8+j+8+5KZ9SKMkGmETM2hR/zRZ2vBgRj+vWhds9WzTtqMqu2VMZ2G
         HU3EKjXSL2uESk8Q1EaEqoaRXiSi8+4buyWrDPcgHYIRGRtwH3vGEftM7YMRszSNUN
         lP/4Ju5q++mALGaVW7Bzjifc77DO0ShK2oPde2g2DMLdEHfrqA6irxmB6uVYNRGBkl
         F/LxKl1Iuu/hQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SpJvC5mCQz4xNH;
        Mon, 11 Dec 2023 09:09:27 +1100 (AEDT)
Date:   Mon, 11 Dec 2023 09:09:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Networking <netdev@vger.kernel.org>
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the net tree
Message-ID: <20231211090925.7fd8f13e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d_7Zd95mnAuihsd3lX4NG=W";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d_7Zd95mnAuihsd3lX4NG=W
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  762a55a54eec ("net/mlx5e: Disable IPsec offload support if not FW steerin=
g")
  4e25b661f484 ("net/mlx5e: Check the number of elements before walk TC rha=
shtable")
  baac8351f74c ("net/mlx5e: Reduce eswitch mode_lock protection context")
  c2bf84f1d1a1 ("net/mlx5e: Tidy up IPsec NAT-T SA discovery")
  dddb49b63d86 ("net/mlx5e: Add IPsec and ASO syndromes check in HW")
  5ad00dee43b9 ("net/mlx5e: Remove exposure of IPsec RX flow steering struc=
t")
  94af50c0a9bb ("net/mlx5e: Unify esw and normal IPsec status table creatio=
n/destruction")
  3d42c8cc67a8 ("net/mlx5e: Ensure that IPsec sequence packet number starts=
 from 1")
  a5e400a985df ("net/mlx5e: Honor user choice of IPsec replay window size")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/d_7Zd95mnAuihsd3lX4NG=W
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV2NxUACgkQAVBC80lX
0GzzRwf/ewfEc9Fzn2p4QT9ZS4aW734CBHhh8ZQSDRrH5X9Z3CLByM7uK93znOFn
MzYcurhbOmIzQsFrvYPLK/gY56moh8ZEGtgj5Xj49u+YlS1j/F3fpJH04mA65l5T
ni3ZyHy2sHipALotVKrijtROiZRAxp3VZXijOnlewOCYUyuNbxTLOI3wlDJWqN1t
T2rnJQgpNKhrRFo4M7M86gLq+xCy7tZet37SlLbb+Qamnp5pPEKjRm0OirvMCMBy
mkjjGJnoshGUbBMI2IZ+wlBNV/QNBz6tMsNfKGGB3Q68PD0l9rfGkXLlmkv6B9ZG
J02jXucSbzAAf4W+TTJb4JJn1VT4yA==
=JYZc
-----END PGP SIGNATURE-----

--Sig_/d_7Zd95mnAuihsd3lX4NG=W--
