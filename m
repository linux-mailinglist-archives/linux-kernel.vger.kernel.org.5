Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E217B07CB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjI0PLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjI0PLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:11:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AB6192
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:11:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28366C433C7;
        Wed, 27 Sep 2023 15:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695827481;
        bh=3c17RM3lgss6ciS2nZym/NDvTUzWMd7ldR5Bhl0Pnn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UCtoaY5dOvUFWXEvXcQE6AzMVS/487g8GFk4HQIkU9T0cUOtw9japE08eYhcOs6iQ
         DC6UbfiX6bZsiN4LMODaY9SUWHR4hv5FkMo4q/cthzcUa5rlWTpvxWrvLR92pInpxJ
         7EMdR7Sbni79BA2fVza7VhFEikrQPf7aaQppeCMsbYnOIqw80RzNqxPsHpOXvoSLc9
         EgbHFHcTUhLwCom07jeccyq2d37/FImwHtj3hwi3ifEeduYpWhpYlk7iPmmnidwTgR
         VQlxTrqx4Wloa7ldTgYQGm07oEBd0V2lusHe1bZNVO+slmHooQd4wyo1YvrfIg57Q9
         X9fNB+BGRrl8A==
Date:   Wed, 27 Sep 2023 16:11:17 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm,psci: Add missing unevaluatedProperties
 on child node schemas
Message-ID: <20230927-dynasty-luckless-ca6fba85873e@spud>
References: <20230926164553.102914-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LEwIwqrbHBA5X0WB"
Content-Disposition: inline
In-Reply-To: <20230926164553.102914-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LEwIwqrbHBA5X0WB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--LEwIwqrbHBA5X0WB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRRGFQAKCRB4tDGHoIJi
0mWdAQDn6WnFg9Y3/EaZYDN8m/l8n6cxpfzQ2aPmody64MUMxAEA8HmmiDqgcX4o
lHhz9Xqx71N+nYeXvzHVQaM5r+pfrw0=
=/wis
-----END PGP SIGNATURE-----

--LEwIwqrbHBA5X0WB--
