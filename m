Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB12786A6B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbjHXIoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240689AbjHXIoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:44:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09366E5A;
        Thu, 24 Aug 2023 01:43:40 -0700 (PDT)
From:   Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692866618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p2Knh8SVU8RYkA/hSrzSozKIKfbuGwYgQL9wulce4/A=;
        b=VwL3Fk0me0rTepMgx43ZBsPiwpe+8DEVtlrCPrLzChq5iOpFEtr96hFU4aK7NuHlOIg7Fz
        YmP2Rb0Ptw0uNOVbbimvUTnXPymus4DpeVwo2dNy4iQP/f7O02zElnXABPREMsPJXLmOQu
        EktYqFszN3v+8x2xAs8637cG8Fo+oMrMUxgq91A1yCt9ljx6jQGy0ySJb4XLXGuIjNZTJv
        6DKvvwmlEPZciQGvW+n6Mw636LjxghulivEvGXmQjLAQRlQUJhXoSYiEjbXBpfAAugQ36V
        +ZNobZbJWmpAVtIUJtmJrDUorDAtTRqB2f0kNR2uRxbYX4roc0V4DGWTC6tjEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692866618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p2Knh8SVU8RYkA/hSrzSozKIKfbuGwYgQL9wulce4/A=;
        b=7yjx3G7LjZBGcElxjLcMZneWitMCWSlLSe9djXxYXN80tM1jfeYgKv8uK6bVQibTtOI2wt
        xq1da47ZVwklH+DA==
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH net-next] net: dsa: use capital "OR" for multiple
 licenses in SPDX
In-Reply-To: <3506906f-7a89-c90c-c753-c330fd33d68c@linaro.org>
References: <20230823085632.116725-1-krzysztof.kozlowski@linaro.org>
 <87h6oq9k9d.fsf@kurt> <601f8735-39ea-7579-0047-3d3358851339@linaro.org>
 <87edju9ggi.fsf@kurt> <3506906f-7a89-c90c-c753-c330fd33d68c@linaro.org>
Date:   Thu, 24 Aug 2023 10:43:36 +0200
Message-ID: <87zg2g4ypz.fsf@kurt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed Aug 23 2023, Krzysztof Kozlowski wrote:
> On 23/08/2023 12:54, Kurt Kanzenbach wrote:
>> On Wed Aug 23 2023, Krzysztof Kozlowski wrote:
>>> On 23/08/2023 11:32, Kurt Kanzenbach wrote:
>>>> On Wed Aug 23 2023, Krzysztof Kozlowski wrote:
>>>>> Documentation/process/license-rules.rst and checkpatch expect the SPDX
>>>>> identifier syntax for multiple licenses to use capital "OR".  Correct=
 it
>>>>> to keep consistent format and avoid copy-paste issues.
>>>>>
>>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>
>>>> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
>>>>
>>>> Side note: The SPDX spec in section D.2 says: "License expression
>>>> operators (AND, OR and WITH) should be matched in a case-sensitive
>>>> manner.". Should is not must. So I assume checkpatch and spdxcheck
>>>> should handle both cases. Especially because:
>>>>
>>>> |linux (git)-[master] % git grep 'SPDX' | grep ' or ' | wc -l
>>>> |370
>>>>
>>>
>>> But "should" denotes preferred rule:
>>=20
>> Yes, of course :).
>>=20
>> You mentioned checkpatch. But checkpatch doesn't warn about it. Or does
>> it?=20
>>=20
>> |linux (git)-[master] % ./scripts/checkpatch.pl -- drivers/net/dsa/hirsc=
hmann/hellcreek.h
>> |total: 0 errors, 0 warnings, 0 checks, 321 lines checked
>> |
>> |drivers/net/dsa/hirschmann/hellcreek.h has no obvious style problems and
>> |is ready for submission.
>
> Checkpatch checks licenses of only some files

AFAICT it checks the license of all files. It calls spdxcheck on the
SPDX identifier. It has some special rules for DT bindings etc.

> so maybe I should change description here (it's you know,
> copy-paste...).

Sure.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmTnGDgTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgp7PD/9/HSNfQ9wK9pke9IvZEQSDi6A/VV9e
SjfsKiHUtrxeT65vJTK3LH1XsKlCvhAWpzhm7VDMqqumPzXg+3RyviK4TzKO3nIA
sO9yauHSHxekTEUfsOhtyj6X7ZvHWu6q+vws41imQCoxvpAlz2U5x615d+GNXfq7
/nRiBcwY4Le0/BgDG3Ev3w6RN0LtaBB2RqMaHpt2ipcLVuRiiGNuPsMi1lUy+QcB
Bn/HV7Y839T59JVEYdkcbl3j2EXXG2FyhTLfN54F1c46+fd04I5lDHtxg4B0o1NP
HDVABHFbjRTCRX3kWn6AcHRMk+XLMCrSf3JbJxaGUy4l6BO3/5jxN6JKhmKAlkpi
oZ6+oVrHbAv8RcqpNhw25eXGy+q+NmXG2ulvSyHlPMOuMjVDwh7Vr7JmmWbJyA4W
4417DKiJ7sOXKGL5yfs8K+iJwHCcV3oZY6akmD3WD+S33tpXKk/F0mS/H0YLoDCa
X4d7Uxe5gvy0vovYBDCzhYYZb09xBOgemuI5N9pyBpAwvwNU5v9aBuiiyKmXHdNv
EGQ5YNgutJSPITJqVC+fPN1vTLQr6Mwi6vBf3YLfVPrXRmhFG9Zdy2wRLCxE/pAt
IEUFrnbbaIIHDqXWyI8OWoK7jLJ6DolnAGykZyH/8p1rYrvJl2AMmJFPpvIRDFnd
8Gz91/KlGf9FkA==
=zt8z
-----END PGP SIGNATURE-----
--=-=-=--
