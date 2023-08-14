Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A3177C3C3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 01:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbjHNXG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 19:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbjHNXGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 19:06:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD40C5;
        Mon, 14 Aug 2023 16:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692054405;
        bh=GsBbQZ8SIGJQowmFExFSw7KkrFDNXJATxWpeeLKCiJ4=;
        h=Date:From:To:Cc:Subject:From;
        b=ijDvRXuCv53nq1Q1OYhYZ07rb+NKCxnZ3GMxdKZWKY3TUJ+yiusq7lSDLbuzkZp3t
         4YXiVpcOqez+AyCu9V1jPJDvugUr08yzRhX7O4jPoNPJlqZ+BIaWIfrkcz/ZvY+0To
         sebOy6C7RERC+Y+YmqZ57++A7DyA57uKZGmbsHntk2eRXeXYUIeqGFf0aW87y9Kfch
         D/WqstGoqXkc0bOy0iej3SvOGsYq4WlS8NciPjLjtymTbnFqvVN49EVTJZu68l6wYl
         GmZhZwsls+MaAA1N0QJu+g64tC7q35DROysoG15Q+b6bRXWy/PZtnVNkIVoBOZ237Q
         riXyaAO/rilzg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPqln5pv6z4wb8;
        Tue, 15 Aug 2023 09:06:45 +1000 (AEST)
Date:   Tue, 15 Aug 2023 09:06:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the v4l-dvb tree
Message-ID: <20230815090645.11e1033f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5TwvrpitQBAuWK2D9tosMyX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5TwvrpitQBAuWK2D9tosMyX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  6308759ec679 ("media: imx: imx7-media-csi: Fix frame sizes enumeration")
  c2c0abbe86a0 ("MAINTAINERS: correct file entry in MEDIA DRIVERS FOR FREES=
CALE
 IMX7/8")
  12cc6da36af1 ("media: nxp: imx8-isi: Add ISI support for i.MX93")
  f48498ad0a41 ("media: nxp: imx8-isi: Move i.MX8 gasket configuration to a=
n op
s structure")
  0ac186e36d84 ("media: dt-bindings: nxp,imx8-isi: Add i.MX93 ISI compatibl=
e st
ring")
  4b60db99baba ("media: nxp: Fix wrong return pointer check in mxc_isi_cros=
sbar
_init()")
  0ca2fbab99b1 ("arm64: defconfig: Drop CONFIG_VIDEO_IMX_MEDIA")
  483fe862488f ("staging: media: imx: Merge VIDEO_IMX_CSI into VIDEO_IMX_ME=
DIA"
)
  093d69ad556d ("media: i2c: ds90ub960: Rename RXPORT_MODE_CSI2_ASYNC to RX=
PORT
_MODE_CSI2_NONSYNC")
  618aba51c294 ("media: i2c: ds90ub953: Support non-sync mode")
  d7d7a9ab7a77 ("media: i2c: ds90ub953: Restructure clkout management")
  05428f66fc40 ("media: i2c: ds90ub960: Allow FPD-Link async mode")
  c7a52ae0b1e8 ("media: i2c: ds90ub953: Handle V4L2_MBUS_CSI2_NONCONTINUOUS=
_CLO
CK")
  be1e71b1db57 ("media: i2c: ds90ub913: Use v4l2_fwnode_endpoint_parse()")
  255b959be97f ("media: i2c: ds90ub953: Use v4l2_fwnode_endpoint_parse()")
  b57a5fd2ccf2 ("media: i2c: ds90ub960: Configure CSI-2 continuous clock")
  905f88ccebb1 ("media: i2c: ds90ub9x3: Fix sub-device matching")
  59353d7051d6 ("media: firewire: firedtv-avc.c: replace BUG with proper, e=
rror
 return")
  935ae6f8ba00 ("media: usb: pvrusb2: fix inconsistent indenting")
  74a5a66fb422 ("media: tegra_cec: fix the return value handle for platform=
_get
_irq()")
  b134b30f7f06 ("media: cx23885: debug cosmetics")
  06a67a1a193a ("media: nxp: Remove redundant dev_err()")
  c84db0f23029 ("media: rcar_jpu: Remove redundant dev_err()")
  f7692d1d0af9 ("media: jpeg-core: Remove redundant dev_err()")
  9578de86555b ("dt-bindings: media: amphion,vpu: correct node name")
  63be999861e2 ("media: dt-bindings: drop unneeded status from examples")
  7b7a3c014ed6 ("media: dvb: mb86a16: check the return value of mb86a16_rea=
d()"
)
  992ba89d0300 ("media: doc: dev-encoder: Fixup type for ENUM_FRAMEINTERVAL=
S")
  525011d84a3f ("media: stm32: dcmi: only call s_stream on the source subde=
v")
  7d0e95eb820b ("media: i2c: st_mipid02: cascade s_stream call to the sourc=
e su
bdev")
  1073f4414184 ("media: doc: codec: Rename "Return fields" to "Returned fie=
lds"
 for consistency")
  1526ae0fd815 ("media: doc: dev-encoder: Fixup whitespace before bold aste=
risk
s")
  3c76db565fd2 ("media: venus: Fix firmware path for sm8250")
  32136e283a06 ("media: venus: firmware: Use of_reserved_mem_lookup()")
  dca24b633c82 ("media: venus: core: Set up secure memory ranges for SC7180=
")
  d5a8d2d3ec32 ("media: venus: hfi_venus: Restrict writing SCIACMDARG3 to V=
enus
 V1/V2")
  41d41b03289a ("media: venus: Use newly-introduced hfi_buffer_requirements=
 acc
essors")
  bbfc89e6f67c ("media: venus: Introduce accessors for remapped hfi_buffer_=
reqs
 members")
  04e3a07275a0 ("media: venus: vdec: Sanitize vdec_set_work_route() per-VPU=
-ver
sion")
  adeb071bb4cb ("media: venus: hfi_platform: Check vpu_version instead of d=
evic
e compatible")
  c38610f8981e ("media: venus: firmware: Sanitize per-VPU-version")
  365b4824ebea ("media: venus: hfi_venus: Sanitize venus_cpu_idle_and_pc_re=
ady(
) per-VPU-version")
  3b96e82d54a8 ("media: venus: hfi_venus: Sanitize venus_cpu_and_video_core=
_idl
e() per-VPU-version")
  03811969f9f7 ("media: venus: hfi_venus: Sanitize venus_isr() per-VPU-vers=
ion"
)
  5516263fa0ba ("media: venus: hfi_venus: Sanitize venus_halt_axi() per-VPU=
-ver
sion")
  6513d80e085d ("media: venus: core: Assign registers based on VPU version")
  ff877873a0d4 ("media: venus: hfi_venus: Sanitize venus_boot_core() per-VP=
U-ve
rsion")
  375b48f40fd0 ("media: venus: firmware: Leave a clue about obtaining CP VA=
Rs")
  9ac60db2bb4b ("media: venus: Add vpu_version to most SoCs")
  ed939821c873 ("media: venus: Introduce VPU version distinction")
  d74e48160980 ("media: venus: hfi_venus: Write to VIDC_CTRL_INIT after unm=
aski
ng interrupts")
  6283e4834c69 ("media: venus: hfi_venus: Only consider sys_idle_indicator =
on V
1")
  1972e32431ed ("media: mediatek: vcodec: Fix possible invalid memory acces=
s fo
r encoder")
  655b86e52eac ("media: mediatek: vcodec: Fix possible invalid memory acces=
s fo
r decoder")
  9d86be9bda6c ("media: mediatek: vcodec: Add driver to support 10bit")
  1dff2beb60d3 ("media: mediatek: vcodec: Add capture format to support 10b=
it r
aster mode")
  6afcc2b0aebf ("media: mediatek: vcodec: Add capture format to support 10b=
it t
ile mode")
  0934d3759615 ("media: mediatek: vcodec: separate decoder and encoder")
  183b0b4bd1ff ("media: mediatek: vcodec: remove unused include header")
  63b71f310ade ("media: mediatek: vcodec: fix unreasonable parameter defini=
tion
 and style")
  31272a398447 ("media: mediatek: vcodec: separate struct mtk_vcodec_dev")
  01abf5fbb081 ("media: mediatek: vcodec: separate struct 'mtk_vcodec_ctx'")
  41f03c673cb7 ("media: mediatek: vcodec: replace pr_* with dev_* for v4l2 =
debu
g message")
  0db2fc4eec23 ("media: mediatek: vcodec: remove the dependency of vcodec d=
ebug
 log")
  17834e0a4db5 ("media: mediatek: vcodec: Removing useless debug log")
  32986215be7a ("media: mediatek: vcodec: Removing struct 'mtk_vcodec_ctx/d=
ev'
for shared interface")
  2e9eadccf754 ("media: mediatek: vcodec: align fw interface")
  94f214f4b6b4 ("media: mediatek: vcodec: remove unused parameter")
  9d7531be3085 ("media: pci: ipu3-cio2: Initialise timing struct to avoid a=
 com
piler warning")
  697bef6c70e9 ("media: ccs-pll: Initialise best_div to avoid a compiler wa=
rnin
g")
  9e2a90d75662 ("media: atomisp: Fix me->stages error checking in sh_css_sp=
_ini
t_pipeline()")
  7b4846b65154 ("media: atomisp: Fix smatch warnings caused by atomisp cust=
om a
ssert() usage")
  a2c770324657 ("media: atomisp: Remove bogus asd =3D=3D NULL checks")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/5TwvrpitQBAuWK2D9tosMyX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTas4UACgkQAVBC80lX
0Gz1pQf/Qm4AkQUPIAPl9QkVxG9IOk71Aj3XEWSP0M6FFt0gA9lm3AeEXwH6a4Og
I5pfiucdQN367JTAyhZxPyZrxrpnmSYE9/Cdi+Os0TaXw/BiV8NY9GbfT+pLFoys
SmFY0RsFH9tF1TTv5wTO3IlFmeXKK/scTZIMubJur/84gdUKNFv1aChsBqCzV5YA
tAcZYCazUQtcqrREQh5VrgQw7PPX2t10y3IM72NhFihThb5K+f7USTK54UGL3bR3
epsbjOxlUETe6OAsawvTSnbLlEyKV9y1mrVsCW5w8eAmVK+TbXPYe+jTIRCfzgGt
LS+4Z3izlh7RKW1sFc16KyEjYClydw==
=1bh2
-----END PGP SIGNATURE-----

--Sig_/5TwvrpitQBAuWK2D9tosMyX--
