Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D187D801137
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378265AbjLAQqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjLAQqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:46:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC6E1B2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:46:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D10C433C9;
        Fri,  1 Dec 2023 16:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701449177;
        bh=LFxpOweV7KVhHEesZpu+S1zzkJsuWf07I3KrLAutqs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GqkLVWvE/Dk4oW6RsREi2JzmNu2WivSa24e+YqDv01BLNe8eoLZDQjCrMDPRHBHF1
         Jii8aN5YItrcg7bA7JLNwLNT7B1F36xrV1lTG++opE+eW2yQz0IyV/kxTjtdWe6uKl
         spmKDScf9fbukaDmt3BQXmuhsOjrOhRu939AKtI7l1vl8bfYQ2yvW+0bPj/v7Atvl6
         mZYCT5WpQ8iPjNeX7ENlYjz4S0rZFGhnuh2gEr71DfpSJQM1af1s0gfv+waNnG47Fh
         j8kC4t5PbGm8QvtaKSw1vqZJFw5O0UDXbjxPl1iufsqn7y5vQOykysZWCpLftzWpma
         68wXM0zVIan1Q==
Date:   Fri, 1 Dec 2023 16:46:09 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Andrew Davis <afd@ti.com>,
        Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3] docs: dt-bindings: add DTS Coding Style document
Message-ID: <20231201-thrive-gully-5260ab07b352@spud>
References: <20231125184422.12315-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MfDi0fzK8bz3SQxU"
Content-Disposition: inline
In-Reply-To: <20231125184422.12315-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MfDi0fzK8bz3SQxU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 07:44:22PM +0100, Krzysztof Kozlowski wrote:
> +Indentation
> +-----------
> +
> +1. Use indentation according to :ref:`codingstyle`.

One thing Jonathan mentioned before to me was to drop this :ref: stuff.
| > +:ref:`devicetree-abi` more information on the ABI.
|=20
| ...can just be written as "Please see
| Documentation/devicetree/bindings/ABI.rst".  The cross-reference link
| will be generated as expected, and readers of the plain-text docs don't
| have to go grepping to find the reference.
https://lore.kernel.org/all/87bki23rbx.fsf@meer.lwn.net/

Apparently the doc generation scripting can automagically do the right
thing here:
https://docs.kernel.org/process/maintainer-soc.html#devicetree-abi-stability

Cheers,
Conor.

--MfDi0fzK8bz3SQxU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWoN0QAKCRB4tDGHoIJi
0j9wAQDnyvYZgmaO0R7WxLXB+G3r+OjlxJNGnsVe1AuYO3IFJAD7BhbA4vqCT0nw
+WHXQA71Ia5T1lkozqxKhBUILq7PPAw=
=V0a1
-----END PGP SIGNATURE-----

--MfDi0fzK8bz3SQxU--
