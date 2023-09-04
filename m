Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FA4791F1F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 23:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239138AbjIDVyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 17:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIDVyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 17:54:24 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40791B9;
        Mon,  4 Sep 2023 14:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693864458;
        bh=cQGh4SdLvkUHO9wJ2tGjFSAdQ04C6B8ncFQ9mPpsFCw=;
        h=Date:From:To:Cc:Subject:From;
        b=cQ5S0rtvo2gRTCsC+w497orr5xdnr1N7uavM2IPPhy2nNFNCuSfsgii83rEFyCPoE
         Nf333dsik52UGkNChjeQmeE5/8e+5m4wDV2BxPaUFE+CQp5Wc9dAJe62seUAHsUEJ+
         2/Uy2G4GVJ4BCPhaE6HRFOzdHXNzZzVhHY/664IQZW83kaQfFgnNSE9H+jCC56jhIN
         YehSRzP6II0+FwQK5FDSdWVVv6qlVh5Arkhfn8Vq8H0Dl0qwBUM6X3ONQ1Z0oKOIwg
         G4mBPHjRn2UMhoQZu1tOO5I+QZ+2yjgykD3hpA781oi2/FxofFMM7dkw2KG32qoeBj
         Yx4XMyW9IUBPg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rfj8V5f2Mz4wxN;
        Tue,  5 Sep 2023 07:54:18 +1000 (AEST)
Date:   Tue, 5 Sep 2023 07:54:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the fastrpc tree
Message-ID: <20230905075417.6de58e76@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4WGiLoZC_xKWqNpIWfwwhyd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4WGiLoZC_xKWqNpIWfwwhyd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  64227235abd9 ("misc: fastrpc: Pass proper scm arguments for static proces=
s init")
  3042d44f7e49 ("misc: fastrpc: Fix incorrect DMA mapping unmap request")
  098316374fea ("misc: fastrpc: Fix remote heap allocation request")

These are commits

  fe6518d547fc ("misc: fastrpc: Pass proper scm arguments for static proces=
s init")
  a2cb9cd6a394 ("misc: fastrpc: Fix incorrect DMA mapping unmap request")
  ada6c2d99aed ("misc: fastrpc: Fix remote heap allocation request")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/4WGiLoZC_xKWqNpIWfwwhyd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmT2UgoACgkQAVBC80lX
0GzSyggAhlV7js4kgaXsCYxNOuojdWG9ZhwhwJK64HpBXo6vrblfvSv+VHyyVFhI
XlqVhpMN0MOIOXVgbgpReyki6M1gYzjP8E8dRpALvUdZcsJgWo1mVTH8SnNOOyl3
MTm07UeT7TAqU8N6gz3GnIRYViwmv89pfijWyYcaLJ4X0uJS5Fp+OBCgz5D5oGUe
dlaBtVum29NB2OwFR0uNk0FW4+fjpVZVaTXWYn3gMKJ53gaLrqV98A4hD8blYL/t
NeEcYrr5QcsYOV+rwFRGdCv9cARRwbdFFPP/BxafNDxU4QF91aEYKIaq/c9rw408
cPFNx5eJK0VhfA1xh/1KzhKs6Zur9w==
=hMs5
-----END PGP SIGNATURE-----

--Sig_/4WGiLoZC_xKWqNpIWfwwhyd--
