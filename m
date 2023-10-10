Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE70E7C4214
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjJJVLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjJJVLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:11:21 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54F991;
        Tue, 10 Oct 2023 14:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696972275;
        bh=TOLAHcDsB9A0TSWPF5YbG778XT2SV4PsMJQ0Bw6LOzE=;
        h=Date:From:To:Cc:Subject:From;
        b=I1w1BJTJcUzDsMbzaid08vSxrCcqXYlgj1R5KeksGe45Z8hIRW4zgL6usm0BJzo9H
         3VVXFoiVE0QH4aA6y/7X25OrjCT5qXwTdmtyEG6XVoWt3PALKS8ovyrddhq7KcgavV
         CyyUV27ZOMg+gBJMv6C+KE9tSbuOcu4/RIjsuy8dA3bJOhV1qWtAroWxtnK7yrlqR6
         FsIGwocOJQG7IvQwCcX7CqO+XsezTTaQmVV+5S6N13KlPOfqSB6yu8ZDah5/O+4z/u
         oWzEHbUhyNKptzL3tEUjUtnkEGDRMHzkZlQlasA8xhGAoNuJKxezjPZ+S81w0K9LE7
         HKE5sUWTaFEaQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S4pVC1bc7z4xPY;
        Wed, 11 Oct 2023 08:11:14 +1100 (AEDT)
Date:   Wed, 11 Oct 2023 08:11:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the iio tree
Message-ID: <20231011081114.2f4d36e4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xjXftEDy7HSiR_BsbbENCdr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xjXftEDy7HSiR_BsbbENCdr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  25a0741b55b1 ("dt-bindings: trivial-devices: Fix MEMSIC MXC4005 compatibl=
e string")

This is commit

  19007c629c63 ("dt-bindings: trivial-devices: Fix MEMSIC MXC4005 compatibl=
e string")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/xjXftEDy7HSiR_BsbbENCdr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUlvfIACgkQAVBC80lX
0GxrwQf/YzVrLJzBfQiUt4HMR7Mhyia+WYYk/P+rCszFSVtTxpL3tpjjAcMuTw9e
gJTRWFAvEyZ7JsMuXJ1+08k3211lMgQQaG3FoGwbp6UJAvRl8LCjbHJ4pOm9yIwa
GsKaCuIEXnOMavufuf7dE/99OxfBQsy/Y6kvzGJP/wYTvCiSNjrKLeK4lr8UJYg1
63ykZXn79ia4I0ADMrYPie/x7fLGpklxa1Y4VJOZ2rC2sdwIrQKJXU4gKCgx0+e5
6/yqt0RDsDwf6cw4JxLW2ZnrEx0xis1Sit5e1PJQGncRuc5qJPsSBoZvc9LYz4S5
6sU4Y8XRn7Pwmm/ffocK9EzIeQ/xpQ==
=eY7j
-----END PGP SIGNATURE-----

--Sig_/xjXftEDy7HSiR_BsbbENCdr--
