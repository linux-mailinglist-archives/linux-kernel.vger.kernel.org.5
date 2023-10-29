Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEA27DAE55
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 21:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjJ2Uwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 16:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJ2Uwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 16:52:54 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71741C0;
        Sun, 29 Oct 2023 13:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698612765;
        bh=6He0/+af7Qh1VNBvQxG1D9Q7mzmKRnr1/5WGX1UYgpA=;
        h=Date:From:To:Cc:Subject:From;
        b=gHUeU31emEALkVkqkPXB1KjI1eyrVVbarnt/GlqDjiyLLMrt4VWJJD7FxwVIsvC/B
         b4EDKtkVvDcP5ma5IKRJtL3H6wz44xFT5jG2QDDhfAqAfwCms+F7oLd2YnnH6t01IP
         dcSLFWCLg2YnYh/noea6ViJP99T0GsX7wu6j9lBnSCVA7FX9Z6ZLJHPB9WwbWs8rGu
         oe53JD2tCMe0CHDXTZB+iNXVZ3/IFcKKRcqMPPZObTyxFgyiFS646GwdbyvJbC7Otz
         qZtQKepYWVQspGaowVyv3d4ey8St3zJwMEwjy8WUFamJb/qx5LGieycPSJ33wR842Y
         d0ZcF5mdO/4Rw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SJTB43JPlz4wnt;
        Mon, 30 Oct 2023 07:52:44 +1100 (AEDT)
Date:   Mon, 30 Oct 2023 07:52:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>
Cc:     Jinjie Ruan <ruanjinjie@huawei.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Pagani <marpagan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the fpga-fixes tree
Message-ID: <20231030075242.15a4af0b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Q_OrNXO_QPZq+=amhG9d_4M";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Q_OrNXO_QPZq+=amhG9d_4M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  03d4bf9ff34a ("fpga: Fix memory leak for fpga_region_test_class_find()")
  9221d5ecebf0 ("fpga: m10bmc-sec: Change contact for secure update driver")
  ee8abd6ce1da ("fpga: disable KUnit test suites when module support is ena=
bled")

These are commits

  28926daf731f ("fpga: Fix memory leak for fpga_region_test_class_find()")
  1e55c5200dc7 ("fpga: m10bmc-sec: Change contact for secure update driver")
  a3fad2e92c76 ("fpga: disable KUnit test suites when module support is ena=
bled")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Q_OrNXO_QPZq+=amhG9d_4M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU+xhoACgkQAVBC80lX
0GwyBAgAjGvDznuYEbAlqVHQ76Vv0lf9bSJdEUPKUYm+bvAbz2DmbUtM1zIicofd
HKXKm0c2O7eCT6TyJITnRZL5BC03xI3Fbg2/oKMwMDxO0vzrLVjp9YSYPxhRNuyW
Loihqz5OuB//asEy1HEwdi5kBJBTYSF/ZHrShrvE8est5MYTqzWbr2Az0rq6Woj7
QkOyuJQw8CfR3k0czj+HQR8A0BonGzZX0L35jqMK790rLn45MkiJ6/p3VIbe9G/1
rdYKU+LCiMYovhBKOnC3DbtdEOVwKd31PePOLdoQQG1kz14EKuYKNHHyR+2AriDn
84UHoJ5/rSNKGC/kmCEJE+cyuphgkA==
=SQQm
-----END PGP SIGNATURE-----

--Sig_/Q_OrNXO_QPZq+=amhG9d_4M--
