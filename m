Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1E4774467
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbjHHSSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbjHHSRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:17:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9D7196A9;
        Tue,  8 Aug 2023 10:25:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F8D262428;
        Tue,  8 Aug 2023 07:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BBAC433C7;
        Tue,  8 Aug 2023 07:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691480996;
        bh=x1L13VddAI4iND15BaelnnmmeBPHY/Ut6c6CffPYejo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tV3hmWG/B0VINsfhJbi/OUjzXjGcKtG+i/5D8B04z3sfEmpOS/chk6SPInE+KOrf5
         43c6v4OEPDA4EDB31bnTmMioFmC26aAP065HMEpce9lcV/vzbrjfywRWMjdOHWiFjD
         a7moskD64pT3hF2VK/WxHFf344tQ6Xxi2V6qiSQ478BLNebYjY4j2zvvDzoHRKQcZc
         IN2NVA9QEFDNy6hH3bVhZVhuwb/m+zDCMMO/uz3k/6r7eaiAhYhmhzfjxZRevsvYV9
         DHnJ60gOoex7zvaM0smXDXfvuggoiWPqMyATXtIHUg++a/wkxntKcJqppP0ec9gW+g
         smw5NYwFhcviQ==
Date:   Tue, 8 Aug 2023 08:49:49 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.de
Subject: Re: [PATCH v4 3/8] dt-bindings: clock: Add Marvell PXA1908 clock
 bindings
Message-ID: <20230808-equator-professor-fcc4564b4ef5@spud>
References: <20230807-pxa1908-lkml-v4-0-cb387d73b452@skole.hr>
 <20230807-pxa1908-lkml-v4-3-cb387d73b452@skole.hr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DKM1rJC+2OjonCQb"
Content-Disposition: inline
In-Reply-To: <20230807-pxa1908-lkml-v4-3-cb387d73b452@skole.hr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DKM1rJC+2OjonCQb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2023 at 05:42:37PM +0200, Duje Mihanovi=C4=87 wrote:
> diff --git a/include/dt-bindings/clock/marvell,pxa1908.h b/include/dt-bin=
dings/clock/marvell,pxa1908.h
> new file mode 100644
> index 000000000000..0c1f328bf534
> --- /dev/null
> +++ b/include/dt-bindings/clock/marvell,pxa1908.h
> +#define PXA1908_CLK_PLL4VCODIV3		38
> +#define PXA1908_MPMU_NR_CLKS		38

> +#define PXA1908_CLK_TWSI3		18
> +#define PXA1908_APBC_NR_CLKS		50

> +#define PXA1908_CLK_AICER		3
> +#define PXA1908_APBCP_NR_CLKS		50

> +#define PXA1908_CLK_DVC_DFC_DEBUG	16
> +#define PXA1908_APMU_NR_CLKS		50

How are these "NR_CLKS" things helpful to the binding?

--DKM1rJC+2OjonCQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNHznQAKCRB4tDGHoIJi
0tB0AP9WB00bkGFDXnoTipCneTMFFJkNGIcCMim70YGs/PIdNwEAgsNY8BDOP/Mj
dOmMDYrhdbMiafUMA6dZgar9DVSQfww=
=Oy5S
-----END PGP SIGNATURE-----

--DKM1rJC+2OjonCQb--
