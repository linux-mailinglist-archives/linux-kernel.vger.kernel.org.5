Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395047873A0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241998AbjHXPH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242092AbjHXPHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:07:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C4E19AC;
        Thu, 24 Aug 2023 08:07:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDE2C6108C;
        Thu, 24 Aug 2023 15:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267CCC433C7;
        Thu, 24 Aug 2023 15:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692889654;
        bh=uPRW448ygskzoQJKpbz5l5EdoVqXpDqJxdDyLkZhpCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IeMBWOETb/l/BuGEJczqQ4MoKEVpXhnDkyjTmMzxhQCTr53OqHc+zduN/RbQN2vb3
         JbGZIVvmGzak3sA9MHy7Ly9bmxcJh0u79uGol5BRaUToTs0zNx0L1LU6c6q8gPlMkA
         xwlDs5Wk5kzvfZSgGRU3lWD07PT7Ex5EbEw0j2SpCeJuq5VKld4XjtIHDTsI+25MAA
         0hmlj3lDqn0sPRZphsz364Dx4oLPbMTAgIYoJ30QlUfASpkTvHEH47GkgOD4lAA37v
         xMnOndfo8HkrmiojzeQZvuuvwg+jMxiSJcTcIXkgu1ECReV2jaqnhFyoCiMVOCjuP3
         uUeSetW9wNOGg==
Date:   Thu, 24 Aug 2023 16:07:29 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH V2 4/6] dt-bindings: power: add Amlogic T7 power domains
Message-ID: <20230824-easiest-donated-6c0fed4e88f0@spud>
References: <20230824055930.2576849-1-xianwei.zhao@amlogic.com>
 <20230824055930.2576849-5-xianwei.zhao@amlogic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6nFLsB7ZwbeEzcob"
Content-Disposition: inline
In-Reply-To: <20230824055930.2576849-5-xianwei.zhao@amlogic.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6nFLsB7ZwbeEzcob
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 01:59:28PM +0800, Xianwei Zhao wrote:
> From: "xianwei.zhao" <xianwei.zhao@amlogic.com>
>=20
> Add devicetree binding document and related header file for
> Amlogic T7 secure power domains.
>=20
> Signed-off-by: xianwei.zhao <xianwei.zhao@amlogic.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--6nFLsB7ZwbeEzcob
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOdyMQAKCRB4tDGHoIJi
0ug0AQDBHP2c21Zxixx7md1Wp11gomoHV6tufjv3WeA+dhJMBAD/YIdfAOxjTDzH
nAxyf7peyDyRmmFRrChJsBNihgC+NAU=
=ClxV
-----END PGP SIGNATURE-----

--6nFLsB7ZwbeEzcob--
