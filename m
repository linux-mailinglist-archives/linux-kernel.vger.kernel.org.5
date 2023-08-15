Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E1E77CE2C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237664AbjHOOej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237671AbjHOOeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:34:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB9219A5;
        Tue, 15 Aug 2023 07:34:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6148265A9F;
        Tue, 15 Aug 2023 14:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384A6C433C9;
        Tue, 15 Aug 2023 14:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692110052;
        bh=W9vo2PdKtXrSJIynEYiJzeZB5KJmlvAg65mlSKyR8NQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bpAl/ltP69x0JYk2CLb8u4kszn41M6v8AebQP96E/u4Bgp26yBxFvU2B72djZ0b1K
         vjv/cWivTCberHkE2SAvHll6MLaQi7UJI5hl+x4AzNhvWmGdW/3v3G+FFJPjW7Oqcu
         ZPR0EwuFonDpNWbX6ILBrF5d40HSh5gaKsz9BS4yelQM+NNvF3pt9mu7xxUSNS+S+9
         4wdMN+L94sPEMCMyxhGqCekpn7mbQzcWFiP3cadeu9J//qHgOSZbiH8J+z29DgIV88
         hJyH1wQVqxmQLC1tXWVvqPV5nLNxrVRERRB7k80AWHUQ6VjhyFM7BW/Q2Qx5CdKZYT
         +qTla5IFnGyXw==
Date:   Tue, 15 Aug 2023 15:34:07 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_saipraka@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: qcom-wdt: document IPQ5018
Message-ID: <20230815-lake-unleveled-6715563761c1@spud>
References: <20230815141908.1084893-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xtPWfmG6Uqc0nMuT"
Content-Disposition: inline
In-Reply-To: <20230815141908.1084893-1-robimarko@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xtPWfmG6Uqc0nMuT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 04:17:50PM +0200, Robert Marko wrote:
> Document the IPQ5018 watchdog compatible.
>=20
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--xtPWfmG6Uqc0nMuT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNuM3wAKCRB4tDGHoIJi
0rHHAQDFnuSRyD1jZw9+1zcpM7FpByA+AkEzvv3ZTJBGOE4rUAEAzpRA90db0ME8
GnyAUzQjdt5aDfS5BTFOFUakj7ggSgA=
=1WeS
-----END PGP SIGNATURE-----

--xtPWfmG6Uqc0nMuT--
