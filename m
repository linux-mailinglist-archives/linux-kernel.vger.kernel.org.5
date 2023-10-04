Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26B37B8373
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243214AbjJDPWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243150AbjJDPWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:22:50 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B10BD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=k1; bh=XFLz
        WXR0pVL/9dAk59B8Npa6QplhByjB3k/1luQS1MU=; b=fBUO4wPH5pr7p7R2CoX3
        2aoSKD/B8oRrTKngDejjILlGCB6JPCRLzoYjcoNY9f6uVRnQGvdLG6Mh3UwGIMyy
        t4mw28garH1DbkxgMzFZmcPehShYzmhKefwqlgh6Qz5TZkSZC7P9rbB3Ak+WYl6x
        ELAHcqPxIjT2fNJH+sNp8xQn1YpsA8fWoddFKxAmhwUtdWmnZDWINaiG5muR7+Bw
        ++46F7VZeR3mv5JQ/W3yymGhT1uePkEu2STyiA8+2Neml+habZGI5/hJCed9zBS+
        KT4KBHR0udhYxyrbKpBXUcHVpfxXcG1Kz1JfUp/1oAb/NeE1ejtiTSTTAq1ZEFA+
        wg==
Received: (qmail 1219859 invoked from network); 4 Oct 2023 17:22:42 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Oct 2023 17:22:42 +0200
X-UD-Smtp-Session: l3s3148p1@39sWlOUGzKQgAwDPXyiQAAMTeDf2RifG
Date:   Wed, 4 Oct 2023 17:22:41 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: renesas: r8a77990: document Ebisu-4D support
Message-ID: <ZR2DQYvwTbADM0zX@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231002165957.11388-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdU+1ox_6e65YQ0bCQMbqtWkYzsE2S88-En7OnYvomfJ2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qdqhh/ku/ePaYN9f"
Content-Disposition: inline
In-Reply-To: <CAMuHMdU+1ox_6e65YQ0bCQMbqtWkYzsE2S88-En7OnYvomfJ2Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qdqhh/ku/ePaYN9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Geert,

> Ebisu-4D has a different part number: RTP0RC77990SEB0020S.

Oh, then the elinux wiki entry is at least vague [1]. I checked against
it and it says "This is the Wiki for the Renesas Ebisu (Ebisu-4D,
RTP0RC77990SEB0010S) board," which I read that the the 4D is 10S.

But I'll fix according to your information.

Thanks!

   Wolfram

[1] https://elinux.org/R-Car/Boards/Ebisu


--Qdqhh/ku/ePaYN9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmUdgz4ACgkQFA3kzBSg
KbYjGA/+LPAnNDlxTZ2r6qLTlFCtTs0M98cvWYySHYMPTNZ/HTMJvvZv1jOWbvKe
UQ8huOexKieMeSSoLxPmeztg2fYlY1Vg/HxMAGSoGWWxrO5mfqm0zhfFGBP/lmWG
rPf8LpA4/DTyqiMfwDloybSMiTNJYVmlTDbTk5CZ+RGOmrrJ7Oh4zbKrgBiGWhbF
xBmGr0/aZDzA852a5YwSCgAUiw6vPnA4U6uPgeeBiB72On9YAL/sZkr7j/235GOO
FhFsvXzFM45sX+uZod62h69Dh6Wch7+ZN0FzBKPoDPkK+L4kqO0tQa7/Q59rwebS
ydozbFtJOuvcxbEKCvHu+NHzmZjtDUSZ9Xpt0EWrwooa5ikiID4aenNqzrxW40Mg
wbNUqEV2N7MF0+jz8nBN0waZc95mSYljyYqfA0Dhj8bXlozau2ClFuJFRc76UfXi
29MbFcP0V8s0UqkNVb1jEL1I/T6bRJyGjbEi5KGeL7/cWFKejzn3V4aQ+HWpJdVu
ifiUgWb/69E1zAuuwYdR0KG9m0SMJnyroQbb1ZOfpoY5g0XdAgKYQuQqhihqxaIr
vY0brJ7gL0XwKmK6NsW/ferZ/qkIiUpSYdTawx+Ha6l7veJ8Gm2HG+86rYDeC6cW
ufa4NtPIqkiXYFX737sdK35Y+2oNapRNgcXgjwpq7ZgSLqcuHyc=
=+VnB
-----END PGP SIGNATURE-----

--Qdqhh/ku/ePaYN9f--
