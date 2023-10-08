Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789DB7BD04D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 23:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344615AbjJHVac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 17:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjJHVab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 17:30:31 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886479D;
        Sun,  8 Oct 2023 14:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696800628;
        bh=W/nAms1eWqFJNo8yBOswbCywQCz8noJSGKfLvwE4z/E=;
        h=Date:From:To:Cc:Subject:From;
        b=qxyGw2/kEcPh1UEJEvLY7Ev9wt8qZ1hmduU5snrtY+uomk4qt+NzTxxdBU/HNNjO7
         hLqFwk0O3gKBgUOySPT7Pe3BHj7Npr4BNDYnQ20J670isytHzptZ3vklD83kF1DbV9
         km9lKE5NF6ilFxGD9H4O/ybyXPjvYl+cRMl6UN7GGVB739Oxl/DVtMVVVDX7eq4IGV
         mS0+Ez31qxJtPy6BI/Rf5mlcvm8/APNKDA67zxTvpKDiu50QrkHh59FdlP40EqTfVo
         2R5H+faZCC72Mbyx76gyzorryjK1y6zmXnfqAA3wUPz6IqjVRGcXCyUIwRrHIP85sj
         6COs7VjHUOKnw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S3b1J5WzHz4xPY;
        Mon,  9 Oct 2023 08:30:28 +1100 (AEDT)
Date:   Mon, 9 Oct 2023 08:30:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the drm-msm-lumag
 tree
Message-ID: <20231009083027.6af62f8a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5m0yHotUFJATn=Nb_YVcOXV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5m0yHotUFJATn=Nb_YVcOXV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  55bbcadccdec ("dt-bindings: display: msm: Make "additionalProperties: tru=
e" explicit")
  08bf97ab16f3 ("dt-bindings: display: msm: Add missing unevaluatedProperti=
es on child node schemas")
  e117fd68f973 ("drm/msm/dp: Remove error message when downstream port not =
connected")
  fb48250ca919 ("drm/msm/dp: Inline dp_display_is_sink_count_zero()")
  22e96e73182c ("drm/msm/dp: skip validity check for DP CTS EDID checksum")
  b41c5ca70684 ("drm/msm/dp: Remove dp_display_is_ds_bridge()")
  d89ce4cdb7a6 ("drm/msm/dp: Inline dp_link_parse_sink_count()")
  a9905b469931 ("drm/msm/dp: Simplify with drm_dp_{max_link_rate, max_lane_=
count}()")
  62ebb19fb32d ("drm/msm/dp: Remove aux_cfg_update_done and related code")
  8bddc2d12e9c ("drm/msm/dp: Remove dead code related to downstream cap inf=
o")
  284a245d8bdc ("drm/msm/dp: Use drm_dp_read_sink_count() helper")
  f906b95755f7 ("drm/msm/dp: Replace open-coded drm_dp_read_dpcd_caps()")
  4b90679c6864 ("drm/msm/dsi: Enable widebus for DSI")
  5467774e55fb ("drm/msm/dsi: Add DATABUS_WIDEN MDP_CTRL2 bit")
  c9b7bae463bb ("drm/msm/dpu: Enable widebus for DSI INTF")
  97aab03bb3fa ("drm/msm/dpu: Move setting of dpu_enc::wide_bus_en to atomi=
c enable()")
  92a48b6ed510 ("drm/msm: Remove unnecessary NULL values")

are missing a Signed-off-by from their authors.

--=20
Cheers,
Stephen Rothwell

--Sig_/5m0yHotUFJATn=Nb_YVcOXV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUjH3MACgkQAVBC80lX
0GwlXgf8DdTBNNANXXxn4keoQmDQfqwP7nj5YFW+pT4nWSt9gpRESv9ypPqNVeTC
ievhuVKllJxat9LC7pG8/S/JZlKlnG0rNTmTFVZyOsINQw7i2wuxyJmX9K7Yj8aS
6OA+IjdvuuN9sDXc/ZEQVFcRCuSp7vy8z5+4IR7cPZ0eOt3m98t3Qi2eoKzqEkyL
PvnlBUVYzbakkklefNHLin1D9Yzl0wgrP87UyUbQGpFdNBeb3zm7omyuLKfkCPlw
1YW3Y4Uy9xiHqhARLLGMm3kpCuSOEnPktSleOm5KibyJd1vPqWYMbRRIEbn2CPB9
Vi1WhVZ7GNwlj5UyRQFCCJKLSUG35Q==
=sZT5
-----END PGP SIGNATURE-----

--Sig_/5m0yHotUFJATn=Nb_YVcOXV--
