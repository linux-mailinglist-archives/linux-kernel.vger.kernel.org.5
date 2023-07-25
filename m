Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067CF76111E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbjGYKoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjGYKoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:44:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9CC10DC;
        Tue, 25 Jul 2023 03:43:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6334A6164D;
        Tue, 25 Jul 2023 10:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F32C433C8;
        Tue, 25 Jul 2023 10:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690281838;
        bh=6si+E7iWgAYbVYwLil6gkAsWSrpRer72I+VMHgo8Tvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hk7sG53LT8l9NDqsfW18+PwZDJyMRfbBFt8nD+eNck+iHgV2bE90EyQbpx24rOCII
         eRRuh0wKiO6x0C1tMmN1slPz+Vgw6EOQZjOGNbOnLkKBbO5SAXQ19jIPksTKrHdIuj
         G308liOPNiQwJ9xPoyU2//uUv4Mrgex/P/8Pyl79IQdLJtjMjqfrayiddVw3vvsa4R
         zEwuGPDYQC+CIA43t+ps1WfevVvov1KJQHPkHkYzVzbLVdbylntO32rtnIG23o6KZy
         Dv8L6/EITHvch4tfqOGXXdCMQCNlWTxdXI237l2XA1kWE7a40WaTwG/FzX3KPJibrQ
         Esafoi9Pdha1Q==
Date:   Tue, 25 Jul 2023 11:43:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Eric Jeong <eric.jeong.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] regulator: dt-bindings: dlg,slg51000: Convert to DT
 schema
Message-ID: <d33e5dbc-ca38-4702-903a-b36f9a824391@sirena.org.uk>
References: <20230725063132.42132-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TbEUfeD9RVtTU6w7"
Content-Disposition: inline
In-Reply-To: <20230725063132.42132-1-krzysztof.kozlowski@linaro.org>
X-Cookie: Happiness is the greatest good.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TbEUfeD9RVtTU6w7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 25, 2023 at 08:31:32AM +0200, Krzysztof Kozlowski wrote:

> 1. Mention that supplies are required, if the regulator is enabled.

This is just adding an OS specific note in the description, it's not
actually marking the properties as required.

--TbEUfeD9RVtTU6w7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS/p2kACgkQJNaLcl1U
h9DjkAf+Lt/GH7XoOVIAbsiHLWp1D29yZFjgBWhF1lt6DmXv4i4wfw2XZUH9UJIH
CLxWm0IU/C5IRcnP4PqaMrfkS8Lnk36TfCghbkk+D+hUNfMJiN+EH5tNjmBvhdCY
49V83pJnktYO7SSWNj/fu/Fk3TlPvw1aoQQNMDV2lvGp7nfBvuSJ1lLNXv4m7Zoz
/qbyzM/9YYwAQ0nNHqDKZhfMRR7GkfA7XGAmcjTUrZc3n3jdG1YLgKm1G8q0Bkvy
+5jV4P7p04aB1xhTEGqiL4eFZw72t0PPG9E0t/9aswt6Gc3bGOFhxM757lo96hKD
b0zasFMslOL1cCK70+M5s+EAjO2csA==
=ZITr
-----END PGP SIGNATURE-----

--TbEUfeD9RVtTU6w7--
