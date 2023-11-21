Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C997F2DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbjKUNET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbjKUNER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:04:17 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DB2198;
        Tue, 21 Nov 2023 05:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1700571853; x=1732107853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1njS1C34bEESwq6u9gdjSjWRen3a5LQ4SjPz74czID8=;
  b=T8W3wLrc7PaC9xq3gpTqTXaS0cwOietZgKNjdc11CWExMpFOaErtqpcB
   18BXjiZZb4FYj8qGdDwOVqBoF0JYt+3dpNRnVY3zPUME3Qn7Fk6s0+lgS
   7SnUwKESgO7z00UkBChu0F8Ohqw3675zLoyVjCz6gwEPmc445RPZ8ah4P
   HXUYsE88deBu/gDNOK4Aidv+9kB+41560JbpIysOnnjuGA60HJsMcSUrb
   T93PlzPOpZ2STf4kYJj9aERLJ4W5xZ72Rmatp/XxInDkJJxhDbnNcUquX
   MEXueHLJxZxFcA8ICRESaeOsY7R0ioo8GxwV6OKOgqODyNkNlWvpGzAXW
   g==;
X-CSE-ConnectionGUID: n5lORdHDSVi5fM04cW72JA==
X-CSE-MsgGUID: EyPvwLNWTTii/cztB81BiQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="asc'?scan'208";a="12315934"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2023 06:04:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Nov 2023 06:03:38 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 21 Nov 2023 06:03:35 -0700
Date:   Tue, 21 Nov 2023 13:03:07 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Inochi Amaoto <inochiama@outlook.com>
CC:     Conor Dooley <conor@kernel.org>, Guo Ren <guoren@kernel.org>,
        Chen Wang <unicorn_wang@outlook.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: timer: thead,c900-aclint-mtimer:
 separate mtime and mtimecmp regs
Message-ID: <20231121-vocation-clunky-17e2c77e64fa@wendy>
References: <20231120-banshee-traverse-554723cd9490@spud>
 <IA1PR20MB4953D36ABE26822B62415500BBBBA@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L2eP2FSieLwYKUqy"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953D36ABE26822B62415500BBBBA@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--L2eP2FSieLwYKUqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 09:12:12AM +0800, Inochi Amaoto wrote:
> >Yo,
> >
> >On Sat, Nov 18, 2023 at 03:10:26PM +0800, Inochi Amaoto wrote:
> >> The timer registers of aclint don't follow the clint layout and can
> >> be mapped on any different offset. As sg2042 uses separated timer
> >> and mswi for its clint, it should follow the aclint spec and have
> >> separated registers.
> >>
> >> The previous patch introduced a new type of T-HEAD aclint timer which
> >> has clint timer layout. Although it has the clint timer layout, it
> >> should follow the aclint spec and uses the separated mtime and mtimecmp
> >> regs. So a ABI change is needed to make the timer fit the aclint spec.
> >>
> >> To make T-HEAD aclint timer more closer to the aclint spec, use
> >> regs-names to represent the mtimecmp register, which can avoid hack
> >> for unsupport mtime register of T-HEAD aclint timer.
> >>
> >> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> >> Fixes: 4734449f7311 ("dt-bindings: timer: Add Sophgo sg2042 CLINT time=
r")
> >> Link: https://lists.infradead.org/pipermail/opensbi/2023-October/00569=
3.html
> >> Link: https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc
> >> ---
> >>  .../timer/thead,c900-aclint-mtimer.yaml       | 42 ++++++++++++++++++-
> >>  1 file changed, 41 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/timer/thead,c900-aclint=
-mtimer.yaml b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mt=
imer.yaml
> >> index fbd235650e52..053488fb1286 100644
> >> --- a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer=
=2Eyaml
> >> +++ b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer=
=2Eyaml
> >> @@ -17,7 +17,20 @@ properties:
> >>        - const: thead,c900-aclint-mtimer
> >>
> >>    reg:
> >> -    maxItems: 1
> >> +    oneOf:
> >> +      - items:
> >> +          - description: MTIME Registers
> >> +          - description: MTIMECMP Registers
> >> +      - items:
> >> +          - description: MTIMECMP Registers
> >> +
> >> +  reg-names:
> >> +    oneOf:
> >> +      - items:
> >> +          - const: mtime
> >> +          - const: mtimecmp
> >> +      - items:
> >> +          - const: mtimecmp
> >>
> >>    interrupts-extended:
> >>      minItems: 1
> >> @@ -28,8 +41,34 @@ additionalProperties: false
> >>  required:
> >>    - compatible
> >>    - reg
> >> +  - reg-names
> >>    - interrupts-extended
> >>
> >> +allOf:
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            const: thead,c900-aclint-mtimer
> >
> >Is this being the c900 compatible correct? You mention in your commit
> >message that this split is done on the sg2042, but the rule is applied
> >here for any c900 series "aclint". Do we know if this is a sophgo
> >specific thing (or even sg2042 specific), or if it applies generally?
> >
>=20
> This can be confirmed. The thead c900 series have no mtime support and
> there is no evidence that they will implement it. So I think it is OK
> to applied this restriction for the whole c900 series.

Okay, great.

> >> +    then:
> >> +      properties:
> >> +        reg:
> >> +          items:
> >> +            - description: MTIMECMP Registers
> >> +        reg-names:
> >> +          items:
> >> +            - const: mtimecmp
> >
> >> +    else:
> >> +      properties:
> >> +        reg:
> >> +          items:
> >> +            - description: MTIME Registers
> >> +            - description: MTIMECMP Registers
> >> +        reg-names:
> >> +          items:
> >> +            - const: mtime
> >> +            - const: mtimecmp
> >
> >If it applies generally, I would probably just delete this, but unless
> >someone can confirm this to be general, I'd probably leave the else
> >clause and swap for the specific sg2042 compatible above.
> >
>=20
> I suggest keeping this. By taking your advice, this binding has actually
> become the binding for aclint draft.

Right. It seemed to me from the reports (and the commit message) that this
was a configuration choice made by sophgo for the IP.

> So I think it is better to preserve
> this path, otherwise adding the mtime register seems meaningless.

Yeah, I mistakenly thought that there were cases where we actually had
systems with mtime and mtimecmp registers. I don't know if that was an
assumption I made due to previous commit messages or from reading the
opensbi threads, but clearly that is not the case.

> But if
> you think it is OK to add this when adding new compatible or converting it
> to a generic binding.

I'm a bit conflicted. Since this is c900 specific one part of me says
leave it with only one "reg" entry as that is what the only hardware
actually has & add "reg-names" to make lives easier when someone else
implements the unratified spec (or it gets ratified for some reason).

> Feel free to remove it.

I might've applied the other binding as it was in a series adding
initial support for the SoC, but usually these things go via the
subsystem maintainers with a DT maintainer ack/review.

--L2eP2FSieLwYKUqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVyqiwAKCRB4tDGHoIJi
0jluAP0fYsqgIge8uXa8G+bCn2bcUbFIsGX/HEtgQr05f7kUTgEA2P/xhfSpfcsh
bBx01cguP1duoKHmUMurx4Wbd/lfXAU=
=8YV4
-----END PGP SIGNATURE-----

--L2eP2FSieLwYKUqy--
