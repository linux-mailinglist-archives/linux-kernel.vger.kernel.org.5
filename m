Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE047572BC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 06:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjGREQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 00:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjGREQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 00:16:17 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ED71B9;
        Mon, 17 Jul 2023 21:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689653771;
        bh=h+IpXVo9F2SR0WhFVHSVq/IgUmMEiO2utaX7AbKzeek=;
        h=Date:From:To:Cc:Subject:From;
        b=SwKxvR5skZBXuA0PAu+HujogKk3GarveH304Vxl2pC8GUUls/PntT+KzgqBz1tVK9
         Ox9RG5cw9ePqqHiEVIaN+ooQ8bhHKwGNrdeNFICYFjJXEQg0K7W0qtP7JkEruOs6V3
         3AR9c/9Gph8WCyVkirI2DPEMNWputNh1XwOJfA/76kpilBR+7UX3mbNRotZPiIAeYi
         P4izgIEfaPTtv0g6qWwQkasxVE8VF6EM2zCO8NMNWxOCN+VjwoxXJTOOMRT0hPr/y2
         gXWx4UeB1me1ktk/tx5Ohd1w7kgjIeKzwlJ7XZLq64RxjJg2VpOMoknbPOCwQ9qiST
         Za2+7J226ZOKA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R4lxl29Hdz4wxP;
        Tue, 18 Jul 2023 14:16:11 +1000 (AEST)
Date:   Tue, 18 Jul 2023 14:16:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the imx-mxs tree
Message-ID: <20230718141609.5326563e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2spV_+iGvrou4JDhXYJfjdR";
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

--Sig_/2spV_+iGvrou4JDhXYJfjdR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  1c00bee721da ("ARM: dts: imx: Remove regulators from simple-bus")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/2spV_+iGvrou4JDhXYJfjdR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS2EgkACgkQAVBC80lX
0GyRLwf9HI1H3CQi5s2YAMm7RA+JBeXTVc09Xe4yocVKNlzvmKNM6VL3LTqImw/X
+005en6pp1ioIAqoci0mFJB1Tt28URqtffmjSD1//DwKJ3HT0mL7+JkIe0tBppKC
/5zOgcZG1BSr8jBUpGNr+KagIQzufXbmFPseyOB9/MldMI4+RYv/6MF2MOq8cIzr
E24ZVswt1VoPqqYvMvihRpdIFRdREz4nF37k36m0oaiklw+UBvwxRdOKg3sXPew2
xkF+nDjnnkmpl8/bbLgw6P6JpursFvfdS15suU/XNXB9Oc1e3jjOIL0GjYpAOy7Q
/2tzKP6zpv0k8YnBaSK+jjqfksglpw==
=7aWe
-----END PGP SIGNATURE-----

--Sig_/2spV_+iGvrou4JDhXYJfjdR--
