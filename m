Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B63E7BD042
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 23:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343590AbjJHV0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 17:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjJHV0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 17:26:12 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D9AB3;
        Sun,  8 Oct 2023 14:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696800365;
        bh=OZn3QG3ArfthFEcVdPbJoynEGCNky/mZuF+AjQdYVWs=;
        h=Date:From:To:Cc:Subject:From;
        b=gj00X4VqY1YHkRUzqOM7tQGzMqHclZP3xYgKHe1rlJtSl/jWcE9XSx4MrSsK2UMbe
         L1mwIQFjmGTumLFApYV9B/+ypwFVZ0f6/hu1+2ViYANrXHWviK1INZ5KbohfKKFGYN
         DUB+GJSgzME20FJrsEUcCfMXlNnqYjj+WyvDqiKB1frsFi1bbEmykmjAUyjoQi4p49
         Yo1w/effO/fk+vuzj+rg5IfNJUfzSacEsjryb3EVfosUkbD/K+ZSccTaQ9cD5b1Bt8
         029TMh+STWt9VlGpPZqz3WVbMxZ3cLxitpudJ0WCFDn3qwdcSJrKfaAQyhlEp8JrYp
         3Vk1lETDuW2uw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S3ZwF1D8mz4x5m;
        Mon,  9 Oct 2023 08:26:05 +1100 (AEDT)
Date:   Mon, 9 Oct 2023 08:26:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the v4l-dvb-next
 tree
Message-ID: <20231009082604.42686ef2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/k5J8Pgbao_LOV1rW8e5Um=G";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/k5J8Pgbao_LOV1rW8e5Um=G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  854dd87cd511 ("media: atomisp: Drop atomisp-ov5693 sensor driver")
  b529c3c4eee9 ("media: atomisp: Disable VCM for OV5693 for now")
  f7a8b46b7e61 ("media: atomisp: gc0310: Stop setting v4l2_subdev.fwnode to=
 the endpoint fwnode")
  c154618b7a95 ("media: atomisp: Drop VIDEO_ATOMISP_ISP2401 Kconfig option")
  ab17dc50170f ("media: atomisp: Drop ia_css_debug_dump_debug_info() and fu=
nctions only used by it")
  b2740e3fdf92 ("media: atomisp: Simplify some if (IS_ISP2401...) statement=
s")
  56b3c81493f8 ("media: atomisp: atomisp_v4l2: Removed unnecessary code")
  fd32a7f23375 ("media: atomisp: sh_css: Removed #ifdef ISP2401 to make the=
 driver generic")
  efb478661b14 ("media: atomisp: sh_css: Removed #ifdef ISP2401 to make cod=
e generic")
  b3afac839e2e ("media: atomisp: sh_css: Renamed sh_css_config_input_networ=
k()")
  74e7ec2c7f62 ("media: atomisp: sh_css: Removed #ifdef ISP2401 to make dri=
ver generic")
  ea0f4d2e67f7 ("media: atomisp: sh_css_sp: Remove #ifdef ISP2401 to make d=
river generic")
  3916493b92f8 ("media: atomisp: sh_css: Removed #ifdef ISP2401 to make the=
 driver generic")
  28b8f4c86351 ("media: atomisp: sh_css_mipi: Removed unused code ia_css_mi=
pi_frame_enable_check_on_size()")
  cfdd05590693 ("media: atomisp: atomisp_compat_css20: Removed #ifdef ISP24=
01 to make driver generic")
  039bb46fbc08 ("media: atomisp: hive_isp_css_include: Removed #ifdef ISP24=
01 to make driver generic")
  88e3390ed25e ("media: atomisp: binary: Removed #ifdef ISP2401 to make dri=
ver generic")
  df971033fac2 ("media: atomisp: ia_css_raw.host: Remove #ifdef ISP2401 to =
make the driver generic")
  0b1fc1b12393 ("media: atomisp: Mark ia_css_isys_240?_init() static")
  02e9eeec18da ("media: atomisp: Remove aliases for MIPI_FORMAT_2400_CUSTOM=
0")
  93bc853183af ("media: atomisp: Remove empty isys_public.h")
  75c80ec9d771 ("media: atomisp: isys_init: Initiate atomisp in a generic m=
anner")
  631d166598d7 ("media: atomisp: rx: Removed #if defined(ISP2401) to make d=
river generic")
  060a3193b9c8 ("media: atomisp: Compile the object codes for a generic dri=
ver")
  a81163d5dcee ("media: atomisp: ifmtr: Removed #if defined(ISP2401) to mak=
e driver generic")
  a3af16862768 ("media: atomisp: pipeline: Removed #if defined(ISP2401) to =
make driver generic")
  f292caaeb4d2 ("media: atomisp: hive_isp_css_common: Removed #if defined(I=
SP2401) to make driver generic")
  95387bd0863a ("media: atomisp: isys: Removed #if defined(ISP2401) to make=
 driver generic")
  772471047769 ("media: atomisp: css_2401_system: Remove #ifdef ISP2401 to =
make the driver generic")
  f240e30e3736 ("media: atomisp: Included both input system headers")
  1370da977f30 ("media: atomisp: Make two individual enum to define the MIP=
I format")
  7aa7aa46aa6f ("media: atomisp: ia_css_debug: Removed debug codes for dump=
ing status")
  cc26d3654ef7 ("media: atomisp: Remove v4l2_ctrl_s_ctrl(asd->run_mode) cal=
ls from atomisp_open()")
  a583e0efd3fd ("media: atomisp: Remove support for custom run-mode v4l2-ct=
rl on sensors")
  c5e0d1df8e55 ("media: atomisp: Add some higher resolutions to atomisp_enu=
m_framesizes()")
  5cfbe44773f7 ("media: atomisp: Change atomisp_enum_framesizes() too small=
 cut off from 2/3th to 5/8th")
  3068c8c4e7cb ("media: atomisp: Clamp width to max 1920 pixels when in ATO=
MISP_RUN_MODE_PREVIEW")
  480293b781bf ("media: atomisp: Fix missing v4l2_fh_release() in atomisp_o=
pen() error exit")
  f8fe8b85e067 ("media: atomisp: sh_css_internal: sh_css_params: Unifying s=
h_css_sp_group data structure")
  90e9e32a0738 ("media: atomisp: Removed unused HAS_WATCHDOG_SP_THREAD_DEBU=
G debug")
  42887db60c58 ("media: atomisp: ia_css_debug: Removed unused codes for deb=
ug")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/k5J8Pgbao_LOV1rW8e5Um=G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUjHmwACgkQAVBC80lX
0GzTzgf/Wv00q4/AxpcRhfzBGgkkfjhWwHe3wpRGJs8Qn6jIYqYO91K99HbE/+ky
4PakrpOAgXVPOT1o8DcajyokRSPmFeAn29PxsHboSBWvkff+x0npIF75DffhSaVg
+YVt5vY5VHvqNt9eDn1fs/XWnVJVdwCGFTrB8Ur+tk0FxFS/0l/5n1dduqlBlLy9
VDJvdzedVn2SiZSywRjQmJqtdesL7aymXuMTBTcyIgEr1wc9QtkL11AZaLsYSrZQ
RkGnb79MheGHlCOcc8PXcGXP3JdGYvvEeDkVn6Q6IZIOWbrKEishgSFV2SLDCGro
7cpBvF8cfWnXF5TjEx0CFEsynL+Jtg==
=KYrL
-----END PGP SIGNATURE-----

--Sig_/k5J8Pgbao_LOV1rW8e5Um=G--
