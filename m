Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01405806183
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346424AbjLEWOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjLEWOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:14:34 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0C0181;
        Tue,  5 Dec 2023 14:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701814476;
        bh=uOaBs+kWO/sOLE9amZDuORxsp2qLOuH+HgrCM6jvykA=;
        h=Date:From:To:Cc:Subject:From;
        b=ZXI4V/6FYLZ1QPRybqm0qBmm8wDQ+CGfpkFS07XtoenTVunoPDTKNQ3NC3jr/BUiK
         +00SCZ7kr11uOwqKXqQYAwNxN5hw6syiwLwNzsRFxDQXlQkx/lkdUEyGjnRhsIRI9O
         OJglRvWap9uTkBPTOobks047/TVXBVvIQquBA4rtRmKIClE4NFeVwfb/8tMzciA6wc
         z7b9MP3spFRgJsxrOzZkNUv8mrWNS4C/XkiOiouWwe6jGEL7dMyW7envZhd+Uqv0mK
         H6xFBTvK5hujhYedRURWgu56ftxgtXSkZHuI/W57C4l7Jcjbb6u/MBsp2rvLim+0uF
         U+dBwjId3MkNA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SlFFR6yTGz4wc8;
        Wed,  6 Dec 2023 09:14:35 +1100 (AEDT)
Date:   Wed, 6 Dec 2023 09:14:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the perf tree
Message-ID: <20231206091433.68f59ba1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/J=HjMo4b4111kPLcIX.Ak._";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/J=HjMo4b4111kPLcIX.Ak._
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  08b953508560 ("perf evsel: Fallback to "task-clock" when not system wide")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/J=HjMo4b4111kPLcIX.Ak._
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVvoMkACgkQAVBC80lX
0Gz0gwf5AZwiWwR7Xnldg3RPTJ61m3GLX4cLj7XZgW1LrVtSU4DcfmWGd3Jlv1GM
mridS5ksdTKPFfnsYk05D1qviRiz2dUmH+ilsX7bo0MoWWWjO2qix0hSbQBHzhcT
GABTnNwSAo0XNkIzBUu+5reYzEEKT3BexgFmyEy4oMCH6FTG5wBnnWZ49w/7pqd4
CYunVMOszPbDxFUKyj+ZGdA8M2ZLb8PFHYTDVHrCFYeMwKhOvWfZUSrsQIUWlo3P
l39Y/bqOiLMocK9Ndyhh4cRTL3W3McFLRpcm+g4HDrMk1ha9rPMTNCdri8mmr6O0
jfGHE2yL3fSSKX77c5r1pTfYA5wGWw==
=i0Q4
-----END PGP SIGNATURE-----

--Sig_/J=HjMo4b4111kPLcIX.Ak._--
