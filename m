Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468427FA849
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjK0Rsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0Rsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:48:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192FD111
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:48:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770C3C433C7;
        Mon, 27 Nov 2023 17:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701107318;
        bh=UHxgCDDpAo/TxqcZDLyIiJF5h1XhVDW7jP9JPkLTBt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RN1SxPcISU2nHhglBq6qAmJ+oN3vU4+IcHatPGKa53DrpVh2LUopXY3+SEBIw5s52
         IO94PmRohQknBtqgQQuLHO6Ib0wkxbIuO5npalmjI1hfDdWpD26dbbb6LytYkrZpzp
         8Re/mS0uzKBFhkWLJNaA4He7grhgcrl5IE2FWijVcENnh4D1rwvBHen5m6SFP0BWKM
         OxqcHVokM+3RmuTobceMcY4es7HktXPtC+A77P6yLeBMLa3ve7u/AGtW9kN4w6GKdV
         boxWQLP4OumtkEr+WxkuExOKi0enfTSA2Y+cvD76rFzFaknU1QZitdUUjvPjNkpiBw
         nRy8iYXQqujHg==
Date:   Mon, 27 Nov 2023 17:48:34 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Ana-Maria Cusco <anamaria.cuscoo@gmail.com>,
        Ana-Maria Cusco <ana-maria.cusco@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: hmc425a: add entry for ADRF5740
 Attenuator
Message-ID: <20231127-mothball-straw-6bb5b4f7cfba@spud>
References: <20231113102535.51074-1-anamaria.cuscoo@gmail.com>
 <20231113102535.51074-3-anamaria.cuscoo@gmail.com>
 <20231113-discourse-sushi-e8fea2450a44@squawk>
 <20231113-left-patchwork-09a1f88b0fa2@squawk>
 <20231126163922.74505322@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gWy9DPXI/ieLWrLw"
Content-Disposition: inline
In-Reply-To: <20231126163922.74505322@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gWy9DPXI/ieLWrLw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 26, 2023 at 04:39:22PM +0000, Jonathan Cameron wrote:

> Trivial thing but Ana-Maria, I'd prefer a cover letter even on a short series
> like this. It provides a place for general comments / discussion / tags to be
> applied and it gives it a pretty name in patchwork.

It also helps patchwork detect when things are a later revision and mark
the old ones as superseded, which is rather nice :)

--gWy9DPXI/ieLWrLw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWTWcQAKCRB4tDGHoIJi
0kl3AQD2InbgMa+Bs8tamaz6fpZwTHOtM7oAaIsxd5gmoHI86wEAjyHlrHoH2AQf
jfQwFWRp6C1rwfFNxrnhItnr0B7+OwA=
=6kNv
-----END PGP SIGNATURE-----

--gWy9DPXI/ieLWrLw--
