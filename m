Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF7275B54D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjGTROb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjGTRO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:14:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A8411D;
        Thu, 20 Jul 2023 10:14:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4597B61B96;
        Thu, 20 Jul 2023 17:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0891BC433C8;
        Thu, 20 Jul 2023 17:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689873266;
        bh=/sCTDKu7Y/9YwOel3/H9ilGvBUrz9mL9LhZ3Oi3p9kg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uqd5sWm9GA6elmeRDpvOTG2iRqR0li5scbTMwn/+eIH8oNPYAm59qtWDx5nc/qa1w
         kM5zQ2LHosrqb+0qJYsBNrIyfmpjToRP/j/7Cch4kfkBqr8r33MV6F8nl1KQsWUfRF
         GMlnAXtYNaIvylNRx+FypmaLiKpta5hojlIxnOXhpLWlf+YnLq9YbxPsTvq8Vt4VFV
         nYaPm4MO7ygGHSxDGb/+YV0CkcTVbspT3x70pq0gQdAT9DlM6WtVeXvqSNCGPsoyQ+
         sdwiNpGm07nTdtEhwfJGOnYPTMqH47ZGrUBg+Uu2Tw0UsTh7anLvz20TZ0V6GyUTJn
         XMx+4eCC60GNA==
Date:   Thu, 20 Jul 2023 18:14:20 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v1 0/6] net: dsa: microchip: provide Wake on LAN
 support
Message-ID: <20230720-unmapped-frostbite-17534e2a0c70@spud>
References: <20230720132556.57562-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0C2AQsgm4evWVLHo"
Content-Disposition: inline
In-Reply-To: <20230720132556.57562-1-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0C2AQsgm4evWVLHo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 20, 2023 at 03:25:50PM +0200, Oleksij Rempel wrote:

>   dt-bindings: net: dsa: microchip: add wakeup-source property
>   dt-bindings: net: dsa: microchip: add local-mac-address property
>     support

For these two,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.


--0C2AQsgm4evWVLHo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLlrbAAKCRB4tDGHoIJi
0s88AQDK7+qrIHL1o7b28ssKUMhMLAGTdOzYQI0YxgptNtbk9AD8DDbx7UZo+K7M
FdYBjRr2VwN3BVPdOSAnGcB0hUomFgM=
=Kf5+
-----END PGP SIGNATURE-----

--0C2AQsgm4evWVLHo--
