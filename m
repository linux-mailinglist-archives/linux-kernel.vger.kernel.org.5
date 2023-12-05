Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D29180553F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345338AbjLEMyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345280AbjLEMyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:54:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AF2A0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:54:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFD2C433C8;
        Tue,  5 Dec 2023 12:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701780886;
        bh=ZUW3bH9lap1pU6oOrX+4c8gMumKtpzivKK6//PJcYqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GgGW1yM9YXS/WiNNYTXZKDgkj7n9w1mLPN97qO1RFh0Vx4yoatSrKesNDfPCmvbt9
         LA4r4bFcNZdR5xZf5al+YtiWSnjBBB0R+UUMTpyv3Ph/qWPLRAa2gOTY7IsjbnEdMT
         VUr+hfIRvmRxXtFxbh1WOHujfMNwuGDvKRjdAzzFVUJ76KWW8k+gm6CR4X5CDJt23K
         KlboCpApFnO5V6cmnf1ovndVjJ6UvADQePX0+tKl7/U60sOYBUVQT3ZL3ykR8jpNAk
         8JxcI3G3sw4zapNzLRjd/lcCF3xizXWu7cfkQiBp1LJMWkopYIc5XzW4Vf7uyXJ/mp
         0uAp97mONI7Pw==
Date:   Tue, 5 Dec 2023 12:54:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Kory Maincent <kory.maincent@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        Dent Project <dentproject@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH net-next v2 7/8] dt-bindings: net: pse-pd: Add bindings
 for PD692x0 PSE controller
Message-ID: <e08052bf-0301-4417-9e79-c48d41866ffc@sirena.org.uk>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
 <20231201-feature_poe-v2-7-56d8cac607fa@bootlin.com>
 <20231204230845.GH981228@pengutronix.de>
 <20231205063606.GI981228@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cO95tLspe5Bb81aI"
Content-Disposition: inline
In-Reply-To: <20231205063606.GI981228@pengutronix.de>
X-Cookie: I've Been Moved!
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cO95tLspe5Bb81aI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 07:36:06AM +0100, Oleksij Rempel wrote:

> CC regulator devs here. PSE is a regulator for network devices :)=20

Is there some question related to regulators here?  I couldn't spot one.

--cO95tLspe5Bb81aI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVvHY0ACgkQJNaLcl1U
h9Cj7Af+JOnCNtO3ZAgvtMkuUfdU5lVliJZyThUXZHQxXqKRM0SJvxmaaalLJvuM
Z/imYTaQ8ULqmVdxUcEFa+VJ4XVKQUs9ejFgn3qc5ENCBDSJs6m+m7xedbk0RqWd
6XZlZ31+WHcc8If6BcF+Gpy9kr7WtozWJKUr0wDytNmk0b/zpTEnwKQhqpCTCLyF
kaAHlcgnjM8OumpA9sGAHrKAw2h+tPcSQl69iCjAxX0RDOxDRnt9GgxN8+uc+UdK
8CcXaLI3V2hPapUH06DhCqPhw9CFo88tOqInMnm/yxhzljNibpx2U+lycydKRV2j
SbeWy5OVcgj+XCurxZ2jrt0S4Cs0RA==
=0rK9
-----END PGP SIGNATURE-----

--cO95tLspe5Bb81aI--
