Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BAF79F49A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 00:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjIMWEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 18:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjIMWEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 18:04:49 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDFD173A;
        Wed, 13 Sep 2023 15:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694642678;
        bh=o5UOedjQ0eThaD+EoFINpueurA3AJmuhtUKUTG2QjzI=;
        h=Date:From:To:Cc:Subject:From;
        b=G62FAX7IioveCgH7PnnSQKwBhITumXMynU5DZ/zvr0c2IWgiBpqgPO0xrg/3WrxiZ
         IGxk8Jp8H8xInh2Lv8um45dsicm03p9vXFDy37ulESkmWDMYoIu09bxu9gfx9nLV0G
         omQ93X17x2+zqZiC3bMo9IkzNec0vfPUiMILnW2PcKV18e/4S46PWb4tr6+THmN93i
         tjc2/1JS0pKQaD/9SgZPxMLt34oGd01/uspJYTWQ3+uTczbnl75Tv4AgNEaIJG24oY
         oitQ8y/lReSYKB84a2DLt/YAHQYMzJWEafWf8IsC7kjQU8esaKaPNEViCJrYo6Y3D6
         KdoY7xspe6a7A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RmDyG4XSfz4wbj;
        Thu, 14 Sep 2023 08:04:38 +1000 (AEST)
Date:   Thu, 14 Sep 2023 08:04:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the v4l-dvb-next
 tree
Message-ID: <20230914080429.31008f8c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FUpps_TXheCfq+8REMeRn39";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FUpps_TXheCfq+8REMeRn39
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  99de9266e8ef ("media: uvcvideo: Fix OOB read")
  14f36ff244d8 ("media: via: Use correct dependency for camera sensor drive=
rs")
  a498bdab9b61 ("media: v4l: Use correct dependency for camera sensor drive=
rs")
  cb655c1231ca ("media: pci: ivsc: Select build dependencies")
  f4a868d4fa93 ("media: cx231xx: Add EP5_BUF_SIZE and EP5_TIMEOUT_MS macros=
")
  12594fb031bf ("media: cx231xx: Switch to use kmemdup() helper")
  91ec353f03cc ("media: videobuf2: fix typo: vb2_dbuf -> vb2_qbuf")
  ca8b68a315af ("media: gspca: cpia1: shift-out-of-bounds in set_flicker")
  ab13c53f86cf ("media: verisilicon: Do not enable G2 postproc downscale if=
 source is narrower than destination")
  20ab3a43a4d4 ("media: hantro: Check whether reset op is defined before us=
e")
  a3151c26be76 ("media: cobalt: Use list_for_each_entry() helper")
  9ad839e1226f ("media: imx-jpeg: initiate a drain of the capture queue in =
dynamic resolution change")
  932f47fcee79 ("media: c8sectpfe: Use the devm_clk_get_enabled() helper fu=
nction")
  af44b9fcfb6b ("media: usb: siano: Use kmemdup to simplify kmalloc and mem=
cpy logic")
  58388a29f2fb ("media: dvb-usb: gp8psk: Remove an unnecessary ternary oper=
ator")
  03f06466a839 ("media: radio-wl1273: Remove an unnecessary ternary operato=
r")
  5ced7579b14f ("media: dvb-frontends: drx39xyj: Remove unnecessary ternary=
 operators")
  040060e2cf33 ("media: platform: cros-ec: Add Boxy to the match table")
  7bd537181a9e ("media: cros-ec-cec: Add Constitution to the match table")
  1856eed9b6f1 ("media: cros-ec-cec: Add Dibbi to the match table")
  e4a11835ea04 ("media: cros-ec-cec: Get number of CEC ports from EC")
  f7d0d4c5d7f7 ("media: cros-ec-cec: Allow specifying multiple HDMI connect=
ors")
  295ce88b2082 ("media: cros-ec-cec: Support receiving messages from multip=
le ports")
  34868a5ab106 ("media: cros-ec-cec: Support multiple ports in MKBP cec_eve=
nts")
  0a7289495852 ("media: cros-ec-cec: Support multiple ports in write comman=
d")
  ab0eec439a90 ("media: cros-ec-cec: Support multiple ports in set/get host=
 commands")
  8103cacfe0b5 ("media: cros-ec-cec: Manage an array of ports")
  b99bdc411d12 ("media: cros-ec-cec: Use cros_ec_cmd to send host commands")
  44de4ef42941 ("media: qcom/camss: use 1X16 formats instead of 2X8")
  e2ef17c0b1fc ("dt-bindings: media: qcom,sdm845-venus-v2: Allow interconne=
ct properties")
  c474f66bf41d ("media: qcom: camss: Fix csid-gen2 for test pattern generat=
or")
  0359f60508d6 ("media: qcom: camss: Fix set CSI2_RX_CFG1_VC_MODE when VC i=
s greater than 3")
  caab1680cf45 ("media: qcom: camss: Fix invalid clock enable bit disjuncti=
on")
  ccb20696f699 ("media: qcom: camss: Fix missing vfe_lite clocks check")
  06f6bc968ebc ("media: qcom: camss: Fix VFE-480 vfe_disable_output()")
  5ecfd54e099c ("media: qcom: camss: Fix VFE-17x vfe_disable_output()")
  7e4a7f099cdf ("media: qcom: camss: Fix vfe_get() error jump")
  7d73971878f1 ("media: qcom: camss: Fix genpd cleanup")
  a0879d596273 ("media: qcom: camss: Fix V4L2 async notifier error path")
  2c1bae27df78 ("media: qcom: camss: Fix pm_domain_on sequence in probe")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/FUpps_TXheCfq+8REMeRn39
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUCMe0ACgkQAVBC80lX
0GxTKgf/SBKU1uWtR2Oh3KkY7hlGuRPEg8CMy4oAp4EKjd46+ZvzFSIhrIkV0z+x
btbWXW9O37G7eSDLPzj5mm1qT4hzZX3uaRtDBwFF7Idg5hBH4jy2RRsjmqQ7sqpi
NeUKVT65srApbO156feIkxmtIxifhmK2A3OOeLPP4majOqql3Fq4ZvfOyrxpehym
HsH367kxrklWrgJTRUX2LxbHbXVOkHiPqBdVMmc9llTBMxLFOe+SY5MQbhzZURS3
1rMjqlX9QQDjQWBOug6v8wBrJK8JPDHTpdPxL1MIZzcv7cTjlc6GfhtxISZC518V
+RlZZjXxLJdeRwTrF9JAQ/fvg3JCFQ==
=Qf5N
-----END PGP SIGNATURE-----

--Sig_/FUpps_TXheCfq+8REMeRn39--
