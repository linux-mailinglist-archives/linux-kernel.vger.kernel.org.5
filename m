Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D1376EEFC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbjHCQGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjHCQGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:06:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227BC2D54;
        Thu,  3 Aug 2023 09:06:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4EA861E26;
        Thu,  3 Aug 2023 16:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B8CC433C8;
        Thu,  3 Aug 2023 16:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691078781;
        bh=yfY2HhbzUm+eVGsxVz3j1t9wwouP1zYfDD/CdbcAEzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=soTl5UJdFwXfJN22lNxH+roRHiH/4rlPqDIg9GqROuVvdHORkjnqz5WPYEKnidZIM
         FfjaNVgWIXT0IGW+OdXCxniD9xpQc68CKAvtU85W1OBBIMpEUbp7C7Hj9yp2YlVyDN
         cftJZCPjzUtK2bO5cDcsOFlxBLtUG4ZetxTP30C7MCblxNY1fty9FoqUcoqEOxlJk4
         2cBU7fDt0MFleLdzVqgC2smkVfCfuFXeKROs30l/4HJKILlPkHLvWIlKNLVg4qKmR/
         pGhEbpGHNUf3UHvowfq3/BbylzLhG5ZYUaujeOM891JSTux3FSNFCh5O3JMufkaY0Q
         GKpu3ftgvfXbw==
Date:   Thu, 3 Aug 2023 17:06:16 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: irqchip: convert st,stih407-irq-syscfg to
 DT schema
Message-ID: <20230803-endurable-thirteen-a6ff7cce8e76@spud>
References: <20230801214651.27418-1-rgallaispou@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="neR+wAL8ec6JqfMA"
Content-Disposition: inline
In-Reply-To: <20230801214651.27418-1-rgallaispou@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--neR+wAL8ec6JqfMA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2023 at 11:46:51PM +0200, Raphael Gallais-Pou wrote:
> Convert deprecated format to DT schema format.
>=20
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>

This seems ok to me,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.


--neR+wAL8ec6JqfMA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMvQeAAKCRB4tDGHoIJi
0qxsAP4+nTXkPAhEHwMQl7zXoZgJlYEhmtSd9NnDwzXnR2VY8gD/epAg/mzluc4a
ciNfNQWZqbkSpvhA+K+T3z0hqBVz/wM=
=647j
-----END PGP SIGNATURE-----

--neR+wAL8ec6JqfMA--
