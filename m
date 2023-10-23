Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631927D2AB9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjJWGwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjJWGwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:52:34 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC978DF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=k1; bh=MR3v
        QCrInNl4djLPNDkfP2m7kIw+dEH4Q6iQ/YqMC+o=; b=bBg2Zcjtxrv5GJiEN6eD
        XaubUPhFkqWWEhcCKoOYoc4pNd6b6LpPsHKw5fr5V891LAIcfZGYQbPu9jEaYh9L
        ERD61SluiaK3tP7/bCbGgQ1L5GNEROgflsCCtKCXhC1o59WSF/jb49rnDlxDIwb+
        o7r2RUr/MeXA9wN3Q0J7C58oRFFMdjvWHPOlfMtn3CsuXIrGzQKSWUzCFykukYQt
        B5AOzKOmVO/xluHUTKSTLMdhfkw+uA80mL0y+/ORjLf8O5Ga4u/CnMMPCdDlTw4e
        G+eozr72tJEEQoITSxnsALitZj77PXALyrGN9X+Q/k5ghW9PFf2J59Gfk52rEz8A
        Jg==
Received: (qmail 1845168 invoked from network); 23 Oct 2023 08:52:27 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Oct 2023 08:52:27 +0200
X-UD-Smtp-Session: l3s3148p1@JHJHqlwIvp4gAQnoAHZpAPyQUfJFEq1N
Date:   Mon, 23 Oct 2023 08:52:25 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: gnss: u-blox: add "reset-gpios"
 binding
Message-ID: <ZTYYKVTYEa6roCci@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Johan Hovold <johan@kernel.org>, linux-renesas-soc@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230921133202.5828-1-wsa+renesas@sang-engineering.com>
 <20230921133202.5828-3-wsa+renesas@sang-engineering.com>
 <ZS0-E_h4I_g7zVIm@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vVw7cNdK/5AY54tC"
Content-Disposition: inline
In-Reply-To: <ZS0-E_h4I_g7zVIm@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vVw7cNdK/5AY54tC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Johan,

> And what GNSS chip/module is this? This should also be included in the
> commit message.

Ok. UBlox Neo-M8.

> Do you have a link to a datasheet?

https://www.u-blox.com/sites/default/files/NEO-M8-FW3_DataSheet_UBX-15031086.pdf

> None of the u-blox modules I've seen have a reset line so I'd like to
> where this came from and how it is intended to be used.

I didn't know that old modules did not have the reset pin. I thought
they were simply not used, so far. This one has. Check pin8 in chapter
2.1 in the datasheet.

> The mediatek driver does not support managing a reset line, but the
> binding includes a description of this pin for completeness. Also you
> don't seem include any description of the property below (which is fine)
> so perhaps you can just drop this sentence.

Correct.

Kind regards,

   Wolfram


--vVw7cNdK/5AY54tC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmU2GCUACgkQFA3kzBSg
KbY53w/9Hf5kAqsmToLPqTbs/wvfi4A9QHxSgcS5kZJJ1jTjQC02CQSFo8ACukZI
VYdeQsQCht/2gFPDK1B51LfsKN+LkUu2+cVftMZBzT63rSk/Shhpku/OWkJNoWOs
oyjJ7aJmBxjfFUSVSNTQAtJc2M7Avv2rZPbq5XFfbMrrfe8kkJkaySuJTY64O/rV
byIcZ+jPBpzqH9BzaqXxfKtloXppBYM0b0i4IfcCEEWOQmRv/YkdhhbPeL5Rka+B
Sxke6eBkzaiWTwXDiytyrhWOqWVR5VxcgllnsoNebFNN+sycH8Y4QDGrj9aqSRTE
bXTnt+d/nOeMNB8OJ9PN+pc02wRSHiJQuYmCC3oRWRmiH3mvl9lDqZUHIxH3bIQp
7xolqR0XZ07P4AdOuQkAV8NTK6ER000btpTLa+5PeM3FYdJuDD/0HgasKcll/XQE
iEAEEJ5wkwcbScGwWvGZYN5cvwu15kn9JMyhw63EngkicQcg7cBi+LOvjoeOwhNH
OnWYIjM1ZvdqWEhtJGIcKJ1ITVWid7Py+BEYKI5aMxJ+y94kEZ4AyFvnWfOj1pd0
6W+Ho8ZeEXDZ1lZxWjCzcl2jKEeyB5aKCr0jWUgKOBqowBy0c4Kt8WWm7s77Iu41
RuXi9psFm/MgTcNa+eIojxYmLHftWNoza0Ma7C/z3L7tDcEaUIM=
=HkxE
-----END PGP SIGNATURE-----

--vVw7cNdK/5AY54tC--
