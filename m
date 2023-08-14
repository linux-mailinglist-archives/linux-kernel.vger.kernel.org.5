Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457D177BD56
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjHNPnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjHNPn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:43:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE4710E3;
        Mon, 14 Aug 2023 08:43:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 659CD64406;
        Mon, 14 Aug 2023 15:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4DFC433C8;
        Mon, 14 Aug 2023 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692027806;
        bh=4M4QSrCs/4eFD+3ggQCLqZfClvZElawWXoDFuEO/OYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ab+QiJnd9e3G8SiFdFoOEP/XbNKL8qJQqAW4Yeiadho7J2rqandOYUldSHXC/vwH2
         PxX5OH21fJurFxXKLwyYX2xXzKGtRn9SyKvN/SR/diwrKmgv9bHc9U7XP3s0iqBf/c
         0OVvPbUQ19bQ1aN/lWaGUY8q377xFS7R3FulDxkUDcijo9P4+FBPfOUuNa0UsNaXFl
         QY1VhaxDWCzMFK/lt4B+mmd0a1696x3DJIzH//VntHLkq8JgsQtjZqrITKxm25+1B4
         L8Q0igwV9WqrTCSsv7yqrUOpeKl6i6tVOI9Rzpw/9J3y+OTCpnxnZg8pGtxPXylqbC
         nBeFzBuBAa4iw==
Date:   Mon, 14 Aug 2023 16:43:20 +0100
From:   Conor Dooley <conor@kernel.org>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, nm@ti.com, srk@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/5] Introduce IEP driver and packet timestamping
 support
Message-ID: <20230814-quarters-cahoots-1fbd583baad9@spud>
References: <20230814100847.3531480-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sO9y4wGyKLEBtlMT"
Content-Disposition: inline
In-Reply-To: <20230814100847.3531480-1-danishanwar@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sO9y4wGyKLEBtlMT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 14, 2023 at 03:38:42PM +0530, MD Danish Anwar wrote:

> MD Danish Anwar (2):
>   dt-bindings: net: Add ICSS IEP
>   dt-bindings: net: Add IEP property in ICSSG DT binding

For these two,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--sO9y4wGyKLEBtlMT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNpLmAAKCRB4tDGHoIJi
0u1xAP9M5o6AwHsPfJpPcLSWCn9wBcTEpc3Zj86fHWMLdbZPEgEAjh9E4Pq/sFfU
6Ps4YLG/mOYxU1csU9sn9aa8hj6t0gc=
=EJFy
-----END PGP SIGNATURE-----

--sO9y4wGyKLEBtlMT--
