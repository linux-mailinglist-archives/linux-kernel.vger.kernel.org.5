Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0637ACC6E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 00:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjIXWHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 18:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjIXWHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 18:07:49 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF40FE;
        Sun, 24 Sep 2023 15:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695593261;
        bh=b4dw6rXLmROGB7OI7LDyTUSaj13ywAvZOJEKtskysQY=;
        h=Date:From:To:Cc:Subject:From;
        b=IRhUxJF4YaNZphGbFzC4wV8/6rmA//TUKlRuwdFAsENbUWDdZhDQ/12WG4DJDQk0u
         ZJm+QjtjUs0MD4smerumOMnVoj7E5TBDumDwRZ6p3skOsaPGWGJpA8/VQ+AX7116Y7
         atNWWh85I19lDWRvjoSMqdaTLnvLtruiKbYX75PoElWR9b+3g4Na34HiARJ73QT+ci
         gc5doHyY4iHHwfw/RI9LZnDA9MSZJ3JODIO4qZRDgp9H3pWBy8MMibSoh9r63ycOG7
         Racr0ozipN8hWv3soFKwz7sSk/Y4vhdiaB8jQFFYjIRRFWioWsOHAdNePqgLe5XGDZ
         KKUuHOPD1RfEw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rv0Vj0xtLz4x3k;
        Mon, 25 Sep 2023 08:07:41 +1000 (AEST)
Date:   Mon, 25 Sep 2023 08:07:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the imx-mxs tree
Message-ID: <20230925080739.2c60b6fd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vmCeyKREyhgAjOPKV/F4=7H";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vmCeyKREyhgAjOPKV/F4=7H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  0611afed24c5 ("arm64: dts: imx8-ss-img: Assign slot for imx jpeg encoder/=
decoder")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/vmCeyKREyhgAjOPKV/F4=7H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUQsysACgkQAVBC80lX
0GzEUggAns5nEdAOmqwGlQLum3AJTcHyw+AOGbqKN2hlSSh7cJpys6TZSYhnyttB
JhkeUThxagkLcUMGukjRL6g8OgX6u3u3tKts+asAPdGZxHZdgLAAnUmF/16P6WYu
eM47t8HAn829AbwNnEK6b+75DY7y3adZO2u382Hh4qs5cc2jwG2O6LtgjEL/6wKv
MSs41J6Jq3KT1aONdy2hewNs4T40MzLJTrYGZ+u2+JUjrddAHLUIsGIHdWdUrAqO
H+EmI8fxHO3U/adCWhYIQ91XLMtKNbAlhLJjjFMCP/8+FYh3iBsKV/60mzGE+QQV
878tbyGDlGgG0oM/eu+CpBKm0nTaCw==
=ASH2
-----END PGP SIGNATURE-----

--Sig_/vmCeyKREyhgAjOPKV/F4=7H--
