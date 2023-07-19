Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C91175A158
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjGSWGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjGSWGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:06:50 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40D71FF9;
        Wed, 19 Jul 2023 15:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689804361;
        bh=nRlwQIXljXHxNboC/DqNsDqEcGyiqwqlsLzbZfPQsiA=;
        h=Date:From:To:Cc:Subject:From;
        b=d/Ii54PQl0jBjRBplBs9DIviT95A5TnnKSuFex/5LfS61/XGXC9KoU3Ujs6NBDHwO
         x9OBJCquqKlKirMZYyz1yXnOYMSIZPPPtcc9FnDC4v3GQVK1n1pUxCeVxcDab9VsYS
         xFjaoq0eUFYJfsiiYLLmOlyUspNkYub3UEje+ap26VFRO0H2GVBYmYsgGqXFlFZwfO
         F+FBL0Azp/N0ShE1JqjeUwooHIU1aAYvVQj7Fi/bfZ9WL16GipEc92x1QbrpfcUWO0
         hxhqbmnD0/AkiCeZcitH5b+rNHiqq47QTjdSb1Tpalz/6Us4H1nljwg2ryF/R4fmT1
         KVT16ubsw0aGw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R5qdj4j55z4wxR;
        Thu, 20 Jul 2023 08:06:01 +1000 (AEST)
Date:   Thu, 20 Jul 2023 08:06:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the imx-mxs tree
Message-ID: <20230720080600.6a678664@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/J6wkWa.LnR_NXK0M2UHib4V";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/J6wkWa.LnR_NXK0M2UHib4V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  912133986ebb ("ARM: dts: nxp: add missing space before {")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/J6wkWa.LnR_NXK0M2UHib4V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS4XkgACgkQAVBC80lX
0GynUggAhYhx/T7eE4PY1x5fTYqT9T2jZDiXoNclla/lbh7rTSQlVKuQyZmb1t6s
OmFfPvXF7geLH7dPrCuWDVlqXxrmAiVqrokPkCmmkkPILqjJ90yXahPnHqqyQ7WC
85qFh14A3R3OFf4nyRGLfTDDMIkhd7PMdvo1j9ap9WxA4h26Ld2S0DqTQuSyF8hW
t/VBFcFaT81IZvcBb2bmS7RLVl4urArgSMYjsGK8D7VQQjoUBVrXs53pg9qhZGla
4Szc7/f0qkpzQZDBBENTNcV9Hn2cBC4IWeoPEOQQUkW+b1YGWJDD8JsIulkCSsl9
i0B85uDGpN4/9sV74GfLdBBmmPOizA==
=Dzc5
-----END PGP SIGNATURE-----

--Sig_/J6wkWa.LnR_NXK0M2UHib4V--
