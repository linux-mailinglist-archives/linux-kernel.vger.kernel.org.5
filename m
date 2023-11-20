Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C787F0CDC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 08:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjKTHbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 02:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjKTHba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 02:31:30 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D229B4;
        Sun, 19 Nov 2023 23:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1700465485;
        bh=N7mageIEHccjGi1MeKZ4ja2Yf9ISbivpe+O6P55N7oo=;
        h=Date:From:To:Cc:Subject:From;
        b=DIdFba3y2UtBFrRn9sN32Fm5rpGP0KFZZPqujEX2+N7wVsl8JzltMRxDjUU8T20ZG
         gRqcnI78kMfGJ3k8b2UhPgkQXrYOAd9USJcRf6t12LT7A9iQhSXqVg0w4610VhQ/70
         utWoACEdo+juIzlOwz97GoaRMkKaLp6jFeXWQfIOYolCuVOZmRA5m5qE98YGMacrm+
         9YFAHDnBayH/+hQnD21JeFscO33Wnk+R93EFXNjeMMSU/2Gq0Sz6Bf27sIHA4H86Zx
         BA7aWJ4w1eB/pl2jvKaFuoAmnE6LE1VLw7hrElpfIn0CshkMlZVtc7igusCOKW14ZO
         2AGtZpv7Iku0Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SYfMJ60jwz4wdF;
        Mon, 20 Nov 2023 18:31:24 +1100 (AEDT)
Date:   Mon, 20 Nov 2023 18:30:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Daniel Hill <daniel@gluo.nz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the bcachefs tree
Message-ID: <20231120183058.13e383a9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4.EoM/s3xFs=mTA1/rk9KIR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4.EoM/s3xFs=mTA1/rk9KIR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  700b6aa33cac ("bcachefs: add a quieter bch2_read_super")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/4.EoM/s3xFs=mTA1/rk9KIR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVbCzIACgkQAVBC80lX
0GxWUQf8DE8geyjmdvV1L8mi/0RQsUAcnScHXQ/rABMDsp0uv/prl9lafJ/vtCOl
IGn/NFperimExRPGYID76eNZhfgoy9fD9Lko2LTgJtN6VNVWehkpn3dlzVI7HIVJ
0mcbD8xeg7yGWyDcJn+IIXcmYKPAZbXB6UJvc3Tf9BKPmNYZWf7Mzdj8w2p4ylvH
hbQo5fc8YIep21Q/cn0U5Rq0Qxy++CoUq2gQX2L/qkrtMctfzSBP332FcpXjSQLT
p1tK0KcoW0blaSlHvxV2fakO9A/YC1cq4b8Sp1wIjMSBfzv4OWB6FoNEsGACh2Dt
IWusOOuigiHcaeQ0vVSDcoH/1vSlIQ==
=gmNi
-----END PGP SIGNATURE-----

--Sig_/4.EoM/s3xFs=mTA1/rk9KIR--
