Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741DF768AEE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 07:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjGaFGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 01:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGaFGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 01:06:18 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F6C1BF;
        Sun, 30 Jul 2023 22:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690779976;
        bh=yPZ6dP4Xy15N9xPoJn4VRzv1cl1zTMxnvqiGvghoDKI=;
        h=Date:From:To:Cc:Subject:From;
        b=W8mh4RoLaPQt/UcqcRV8khLRZQAkY9pervZyzKK/L6Ae8Rl4EbmBpuvKiVPIt1jVa
         L9870rFG3vUai1JtromKghQ/1MmSA3M6tR0uiD/PHWp8hT+UCY21LU/xRP5juWr/rS
         WrNZRkRY1TgUQmJGe05RylXa7xQommLJpFR2P8Ihm9sEZIYB1XD2AhvJh9de5R4lXr
         9czzSDck/PiN6YEn6J7b4gi4NeRdBT1L6F8iV5m4E1G50Oj7//BgnJdcYODln0miOM
         5Q68PnR0q5eYHhPxfIyZFiJ6kPo1eymT7Gkh8wCfPMWn6LRnvdudI+GOK2Cife6ZFo
         g85zxg/kX6YFQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RDmRW1HWMz4wqW;
        Mon, 31 Jul 2023 15:06:15 +1000 (AEST)
Date:   Mon, 31 Jul 2023 15:06:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Nicolas Ferre <nicolas.ferre@atmel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the at91 tree
Message-ID: <20230731150612.42ecf692@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j+j_t6v+REjhPqTUXp2Ubg3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j+j_t6v+REjhPqTUXp2Ubg3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  67a58c383a1c ("ARM: dts: at91-vinco: Fix "status" values")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/j+j_t6v+REjhPqTUXp2Ubg3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTHQUUACgkQAVBC80lX
0GzK3wgAgQss2MLOOfyZpqb/Q48Nc692Zmi0lF0EtfOlET+ZO0VOPQN353ESuyue
sNtT1GbUDjOTfSpVaNAAkrtWebFhqCtEKQ8znoieQPm0sc4TB58eIKPqJCBCjAyj
OA84HSc8+elZF8xkMAZN5OtBnUq0FWhl299D1ghGEpJImpU/TQwrx1hQBRxnc1pQ
gCdlDVKNqaoqSERT4Gc6ht0QHGa8PY0SdhigrkUICN4ojVNwPcHs12TwtI3PcUm3
5mPz0nca2zZOzXE8kuQyypX5eFQZ7nBlJdtz4jh+EKRWMl0Zql6PskVY9Yh1a7XU
CsJ24tqMTUDtarTiKJxzDYL6DwOAGA==
=mnhj
-----END PGP SIGNATURE-----

--Sig_/j+j_t6v+REjhPqTUXp2Ubg3--
