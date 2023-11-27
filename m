Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A247F96EE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 01:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjK0A5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 19:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjK0A5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 19:57:19 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F6710F;
        Sun, 26 Nov 2023 16:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701046640;
        bh=II8fvvTebl5wXTs9nSR8kOFZ05zYuS72F34TwSUPL8E=;
        h=Date:From:To:Cc:Subject:From;
        b=lUHZ3bBDN9SyBT9RxrRmmb5xKgA5u3W/HxOjN7dV3h5gKREjzFw7FV5CcAAmi5mL6
         oBEJ+ExvTmjv8trXTlZ62ktp7lk7+geue9gK1AD8MtHuj1jwoVEyI8BMDKYH9q0+kn
         dYO2VVD3zKem4/1EBz/RbPf3r37N3a7SeqBKsLACBV4NF9oOqk9D3uK+20KANh6NlY
         KjPuvOzLD1/qiSRDGRbnu0xRWf5tfSR+SSkm3FH/S2Eg8EWBpXdh1torwUDyJlWKO7
         yiEFdXBwf0FOXSIBuAskyTUTY8sx+1rsgfSNWvUBlZUSsTxAENWDcRt6c243QtqdN+
         J+2YjIe/b1w5A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SdnHM6p67z4wcJ;
        Mon, 27 Nov 2023 11:57:19 +1100 (AEDT)
Date:   Mon, 27 Nov 2023 11:57:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the tty tree
Message-ID: <20231127115718.7ad1701c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oQAv.DhzXwzFCqvxo+6.wSk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oQAv.DhzXwzFCqvxo+6.wSk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the powerpc tree as a different commit
(but the same patch):

  aa46b225ebbf ("tty: hvc: hvc_opal: Convert to platform remove callback re=
turning void")

This is commit

  f99c0e0d0859 ("tty: hvc: hvc_opal: Convert to platform remove callback re=
turning void")

in the powerpc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/oQAv.DhzXwzFCqvxo+6.wSk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVj6W4ACgkQAVBC80lX
0Gy1/wf/ULmxrjVr+fgWd9sVztutaB0Ip1E1fEfjkOmSIrkxpttpKAzRlgE52fPj
lDZH50AEXW1NyH62UgTNZ2qa4nXvDopQqPvmC9Bne7yo6tcabdDZ9bk67W6bnrH3
92w0gea8whfiDiivrnxAd+wQ7YMDuIA870f7DS0AIax6/lj8JLaJTPGBNgyUtDIy
tyPGNo4auCrIiynAjiRqT3l7MYjLkjT3goAsgnJwNbMqTv7mCirAutum2DVHUHDG
ZRvUR06zoZUXs/Q1isAhgZU/Ltv/BFTXSnZOlC2MX6/MorbY/Lt954tGoTZJpXZJ
+Y1jyZuRLwIisfPrt8qmyIVfaxqVLw==
=5e0j
-----END PGP SIGNATURE-----

--Sig_/oQAv.DhzXwzFCqvxo+6.wSk--
