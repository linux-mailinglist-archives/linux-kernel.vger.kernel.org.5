Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5D678B895
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjH1Tlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbjH1TlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:41:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123D6BD;
        Mon, 28 Aug 2023 12:41:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BA58646DC;
        Mon, 28 Aug 2023 19:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71876C433C8;
        Mon, 28 Aug 2023 19:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693251682;
        bh=5fcdEJYr0tuaLwmg8LrJDpk5WjyT7tChNwaLtJl0EjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oUGKFwThSSgaRGElIYnOuDUUMA5z60TZfL+K6nMPId0ngzpt1zVG8M54zAjS2boe7
         6/aZbfm1q5E1Ln++O8oVSIcnLE/UQJuyQIAJH8cdKpFdtWze+Wvj0Eu3IeHYGMc1Fz
         WNO9MMS+4YV6h2ectkU42s4rzr/h9/kzmwGPTQtN6Q9/UpGgufcm+fWtcSz1k31mc3
         xWEAk6SeLpB6mkyV3RLgu/4WglWGwUVyDD9El+sA1vZHx8LpuyUDlBxtFZBTHBRBbc
         nSe1h82YfUw+/KNnfsvnMJPTHD2qWxKP2KIeQ85cM7quvobqHliltSgrKlIa5HnX7D
         O9gl4IrXh/Owg==
Date:   Mon, 28 Aug 2023 20:41:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quic_pkondeti@quicinc.com, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, workflows@vger.kernel.org,
        tools@linux.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/1] scripts: Add add-maintainer.py
Message-ID: <ZOz4XtX3DFRQpvQY@finisterre.sirena.org.uk>
References: <cover.1693037031.git.quic_gurus@quicinc.com>
 <141b9fcab2208ace3001df4fc10e3dfd42b9f5d9.1693037031.git.quic_gurus@quicinc.com>
 <2efba6b3-2399-9deb-d0ce-78f7b5e12f30@linaro.org>
 <20230828175629.GC23466@quicinc.com>
 <78aa33f9-ead8-b128-2a7a-40530a1a3ed0@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hRZyai99SdOpZcQJ"
Content-Disposition: inline
In-Reply-To: <78aa33f9-ead8-b128-2a7a-40530a1a3ed0@linaro.org>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hRZyai99SdOpZcQJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 28, 2023 at 07:59:54PM +0200, Krzysztof Kozlowski wrote:
> On 28/08/2023 19:56, Guru Das Srinagesh wrote:

> > Your function adds mailing lists also in "To:" which is not ideal, in my view.
> > You've mentioned before that To or Cc doesn't matter [1] which I disagree
> > with: it doesn't matter, why does Cc exist as a concept at all?

> To/Cc does not matter when sending new patch, because maintainers know
> they are maintainers of which parts. I know what I handle.

That might be true for you (and also is for me) but I know there are
people who pay attention to if they're in the To: for various reasons, I
gather it's mostly about triaging their emails and is especially likely
in cases where trees have overlaps in the code they cover.

--hRZyai99SdOpZcQJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTs+F0ACgkQJNaLcl1U
h9CeTQf/e9/5RbNg+te42f6gn239bsr10S3eOcOyxTwWayhAg4zAexwks3p016ip
ZnpfeGr64L9nun8+geqVq6KRC51zTmJPuFST7WbKFxSmYlpH8U8ZtQsC7DCWadLC
5TfZCHGWyTKvAyrG8q02Z2Pv6kb9Pc19v/1SIfLc/LHBN7s3DIp575SmtCGvT2pe
uaH3Gor59lyaohr6CPGAhywhJG99zsROT0HXAnPnzmGL2h4hfGOvh4cbrGjfy/Z9
2Kst0IWghvAAT8AETR9ZNAhSIssP89fa/O7p6uo6TvXQN3YcMDg8iqaYdi03gu6w
gqn0TzRZXrL/jOLMYvHKGg0uDIfCnQ==
=8k7s
-----END PGP SIGNATURE-----

--hRZyai99SdOpZcQJ--
