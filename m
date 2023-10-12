Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98767C7958
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 00:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442981AbjJLWO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 18:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbjJLWO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 18:14:56 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFC0B8;
        Thu, 12 Oct 2023 15:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697148892;
        bh=z73q4XsPP0Fb/rW+Z5lgMemzUiR3czHGybVDO5Jscjo=;
        h=Date:From:To:Cc:Subject:From;
        b=uak7dekD9mY89KjkqejKWp3l7e+tM3IIJ8XwvICpA9FeCEvl+jIQlz6WdU8A9c52i
         8SyQto/xo74mMEcqaRN7nEBChawBUYCjmRQr29DJ9lN7Vdhv4BNSlYheFmaik4hGyf
         mZstzTwkPtZBD04WXTKAgMYVLRsJW2H/jfV9Y5hVLYlwvVQD6cNwKD4uU7mU1X5JM8
         tLseJlKGu0xP7ZI70gAkdWHFwWjyW2QJfgIo1X0cJEdKpKBE440QiASTHa3VY5bC6P
         n+XjU6SQYSDp+RnhyIYfdWPAKrhdtIq6DHlV5Ok+XBGvCATum8V8zt3A8rOS1nXbN7
         L8Tw0cK4eegtw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S63ph3PQqz4xKl;
        Fri, 13 Oct 2023 09:14:52 +1100 (AEDT)
Date:   Fri, 13 Oct 2023 09:14:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the pwm tree
Message-ID: <20231013091451.170e4cb1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oE5eifIhvoMmOVFJKByV0HL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oE5eifIhvoMmOVFJKByV0HL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  e83d065df879 ("pwm: cros-ec: Simplify using devm_pwmchip_add() and dev_er=
r_probe()")
  6bbb289ba9ef ("pwm: samsung: Consistently use the same name for driver da=
ta")
  bca2b683e56b ("pwm: vt8500: Simplify using devm functions")
  256d6ee2ad36 ("pwm: sprd: Simplify using devm_pwmchip_add() and dev_err_p=
robe()")
  4abf54cf7ecb ("pwm: sprd: Provide a helper to cast a chip to driver data")
  aa60ddb3c334 ("pwm: spear: Simplify using devm functions")
  4f9cbaf4a379 ("pwm: mtk-disp: Simplify using devm_pwmchip_add()")
  41910bbd07a3 ("pwm: imx-tpm: Simplify using devm functions")
  3097af23a2e5 ("pwm: brcmstb: Simplify using devm functions")
  d5e2fc3956c3 ("pwm: bcm2835: Simplify using devm functions")
  47ecc5a0f7a4 ("pwm: bcm-iproc: Simplify using devm functions")
  a5e989881bfd ("pwm: Adapt sysfs API documentation to reality")
  9caee567a7b1 ("pwm: dwc: add PWM bit unset in get_state call")
  25c75f249c5e ("pwm: dwc: make timer clock configurable")
  68ee440e9bbd ("pwm: dwc: split pci out of core driver")
  e2218bde48d8 ("pwm: berlin: Simplify using devm functions")
  a0754f8e01a0 ("pwm: Drop pwm_[sg]et_chip_data()")
  04de4d9108c2 ("pwm: cros-ec: Put per-channel data into driver data")
  8905e7d09c9f ("pwm: sti: Reduce number of allocations and drop usage of c=
hip_data")
  8a4aa42059be ("pwm: renesas: Drop usage of pwm_[gs]et_chip_data()")
  bfddd0080786 ("pwm: lp3943: Drop usage of pwm_[gs]et_chip_data()")
  23d557785a11 ("pwm: jz4740: Put per-channel clk into driver data")
  4c9548d24c0d ("pwm: samsung: Put per-channel data into driver data")
  9db718b90b6c ("pwm: berlin: Put per-channel config into driver data")
  4b672114771a ("pwm: crc: Allow compilation as module and with COMPILE_TES=
T")
  4d7c6cfafb9d ("pwm: Manage owner assignment implicitly for drivers")
  10cb8ce5af85 ("pwm: jz4740: Consistently name driver data "jz"")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/oE5eifIhvoMmOVFJKByV0HL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUob9sACgkQAVBC80lX
0Gwf6Qf/Y2xOeOh920PoGPT/okqFGsmef4b+58EOLab24h4Hai/Q4o3/aJg7tQld
RCbbwCsjm+JPIxGBxlHW2YtQBlz9MLm1w1EzBztnYWoP780tqcrVbOCIRjSt4IEL
7A3w7FNgj2Ef6ho52GtVyMneZCqBNRyDyx2SJHwm3O+JFhlF6JUu1QqTSWDwfaVE
JrpIVefLIwXk4hKlQHBJPAK7yadK8MCwMr2X21kVBxBX50ubCD1N9ZMstZDmyEDs
hN4TcBGGkdchfo49VABezipAC5z4ochI8Go1QJVQ0t+ZAzpcALswGL4UHbIrhMzt
Z+4BrKkRtXoDTOmJ/P/32YHP16LHsw==
=sjog
-----END PGP SIGNATURE-----

--Sig_/oE5eifIhvoMmOVFJKByV0HL--
