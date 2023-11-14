Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7C37EA935
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 04:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjKNDpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 22:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNDpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 22:45:16 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15C3D42;
        Mon, 13 Nov 2023 19:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1699933512;
        bh=XIw5E3P3t2yLzlvGyA8lzacW3IabO9mJ0GsOxrwMCRg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I9xGW1iB2zsBmyv98fqpd78W1XE+T3x6+8dNiefqoLEgQAOhwpRoB6TlZPX16eJeI
         jyAI4WOlTylYzYHXe59EkwEYM7Gz3v50TrOSO8ct4OVbaB4MEiAgHjb3g/rRqKy3FI
         +rC3iifd5wfUaSDU4Cc486UlcLVVnGyaFCEsoO7n1OCyGtEr7oWWlGCamBBOfBCSgW
         3SrtwaoUSOqDvabpMqKvUn616yPHI8VWME049+rdM5MhyKm4kLcgqqKCWsBPrCaliq
         BiDhkdAnT7hxThr21etiT9370+wv1eYQ4p3CEuR0KdwWWgz7COqZHwNGWvQDhvqMbM
         dK9uKsvo9P/og==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4STsd34smjz4wbr;
        Tue, 14 Nov 2023 14:45:10 +1100 (AEDT)
Date:   Tue, 14 Nov 2023 14:45:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>
Subject: Re: linux-next: the fetch of the tomoyo tree failed
Message-ID: <20231114144510.49fd3688@canb.auug.org.au>
In-Reply-To: <20231017163242.62af10b3@canb.auug.org.au>
References: <20231017163242.62af10b3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4jnyz5B/=fSu586N0oHCO+4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4jnyz5B/=fSu586N0oHCO+4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 17 Oct 2023 16:32:42 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> It failed like this:
>=20
> fatal: unable to access 'https://scm.osdn.net/gitroot/tomoyo/tomoyo-test1=
.git/': SSL certificate problem: certificate has expired
>=20
> and indeed it expired at 2023-10-16 23:59:59 UTC.

I am still getting this failure (an so am unable to fetch the tomoya
tree).

--=20
Cheers,
Stephen Rothwell

--Sig_/4jnyz5B/=fSu586N0oHCO+4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVS7UYACgkQAVBC80lX
0GxixAgAo80j4i+/zREmbLZnRrTT39i0gamcnN2026csPLPfgneZoDespKQAyQr2
ZbTbaTxFPyEQdQAvlb995wp6upmZPRuMkLEE0MJN7fkjPRaIjZ4aGQz5N0H3B2ZI
GWGaKWBgfqqYSUpwog9Wbwlht6B+qcGY82QWCidbbUz2zlt73gJtZ4fGtVpGW8AK
n10cANy3uudV/3KV0sHe/D7wAvv12rrXX27gPJ2BSbZeOrYkj4cZJUvw/7QrwH7T
Jf4XcTe2PmeZUdf2nUhaqzdVFsCvQYz4ARSDvLw643/N4Jjt3C8PFSeDo6zGOuTY
kBkyL4Qpdo+M1balO5sQY3MEVzbDLQ==
=fcKW
-----END PGP SIGNATURE-----

--Sig_/4jnyz5B/=fSu586N0oHCO+4--
