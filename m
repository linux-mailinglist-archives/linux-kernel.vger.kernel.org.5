Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF3375A064
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 23:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjGSVOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 17:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGSVOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 17:14:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4FE1FC0;
        Wed, 19 Jul 2023 14:14:37 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 22D196607078;
        Wed, 19 Jul 2023 22:14:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689801276;
        bh=JMyQEP3od9PZOBsKRjkFxXdi2lvzCZLQhxvRz72H9to=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HE5y3hiXQcOixAs3n0zNF4bMBfYzm7JL+CW6REiwSEjXA+TCJYdY556/PjXwAjAas
         dvqagZ/hG87rcrHH2CryR7DO7T61NpsGvAPqRlfWuvgR92WNgxXYMYY6w9y71bfPOp
         U/D+0uADFNZeyBNgwSXmFJNZwlTBxipeZFPqJHNZNTBpBFf6FxWzydIvTpJ7j5O3r4
         ds8nnJjcfLTOGMJH99pQ3WDJF+RMUr3Mr5CVjdfmHQVXTaTvn7oLVTqU46dNNtLnUL
         vNvyl3IMgXcE54P3Q7tBdfG7KFOd5DnqvCdECk9Q5zZX4wewX8SGTz53ngt6y8sX3U
         mRucVyYZLXEjA==
Received: by mercury (Postfix, from userid 1000)
        id 655DC1061639; Wed, 19 Jul 2023 23:14:33 +0200 (CEST)
Date:   Wed, 19 Jul 2023 23:14:33 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Colin Ian King <colin.i.king@gmail.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] power: supply: bd99954: make read-only array
 sub_status_reg
Message-ID: <20230719211433.cfqz3c5pki4xi6rl@mercury.elektranox.org>
References: <20230627121707.722021-1-colin.i.king@gmail.com>
 <94dca2c3-e5fc-c4bc-a945-31ebb728e353@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ihp5cv6merpfazba"
Content-Disposition: inline
In-Reply-To: <94dca2c3-e5fc-c4bc-a945-31ebb728e353@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ihp5cv6merpfazba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 27, 2023 at 03:38:35PM +0300, Matti Vaittinen wrote:
> On 6/27/23 15:17, Colin Ian King wrote:
> > Don't populate the read-only array on the stack, instead make it
> > static const.
> >=20
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>=20
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Thanks, queued.

-- Sebastian

--ihp5cv6merpfazba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmS4UjMACgkQ2O7X88g7
+ppYgg//dORO/aqPrYARCr7Yl2RBHeIbi5cvuQTT86ZWSiB2tTe4pxHibBXRXh5h
rynWngtMqxgQUGGPawi6HiM/esBkp2Pvz6lwAhxCi2e6ZoXe7MO9+fcDRNZRrsKD
LENS2c5yH+N8jgNg1ek8GJv17tjRW0z9X9SH2eCAG7fSikmmzbkm0Xrzu4kdtfNL
ubUrb3GPOms1TJPxTbQO+EmzIEcUC7p2kU5U2T2IBy4SNcLY1Ts/TZ7gtQFMX3Ea
Pj4MUUxRGnTFgfArqviaPNtSJ7hMmQBB0VTgcHRvBWY83tZuazi5a/DhaTZLwuYn
HR9IwfUtHBlxwdc4aWaL9yEV5HONXMBkln59Z9l8v7StPRBjKUtZxQMtVnkwA872
cF9i9TZMRfD6Q2ujY9nA7OWODLammkJYs2aAMcsI5oqGl9QxPNkea8YUOwHgpFEw
9MR5oUqvqgA7HK0EgE6zvf7oW5OFCGQy5LflL44nl8JFHkgLChpFibOCvL6rZslg
2xAvlsFT/YzKtTv+cNgXnfkZwrOeHjq6ue+JYD9ltwfbmljKEBPHyEVMsDtF6tps
KJj096/+EmzvcI4bK6DaWqEg8KmHTcygYd6dCP77xHLKG9MQhyzbcCtOwPmJUfhe
q7AP2asYFVIalrm3oAK1NZ8xtnZdv5ff8ocXFWfvrgTiBd35JeA=
=f2XX
-----END PGP SIGNATURE-----

--ihp5cv6merpfazba--
