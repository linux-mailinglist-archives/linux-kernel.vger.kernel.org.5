Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82917C8842
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjJMPEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjJMPEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:04:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A59BB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:04:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71FDC433C8;
        Fri, 13 Oct 2023 15:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697209471;
        bh=FB2R70WBb+RX0qj+NMyIeD7qQ29uR6VXNPam77tDofY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vnu7aFC+LvPhcMA4J3tnalV+kHW/W2NQXWzU/84tgyYqjASJ6w0/+tSswWwWuwXtp
         AFU8Qt8jsuZdU9IIHCELPTMUFHYtKBVUjZapMWdq/0pvI4GfEMI2+QEBvsqKEk7RJm
         uzCh5u18ELxFh/IJuLjqSUieoPV4WaqlDJw8p5WNKMWSvHO7ANhsSQq7SlkE1StyVd
         it0f+NpVUjfs0oxpijbaTFE7jDiKC9frq4CXEybwc/Qu7BsCfHIpamDLdvcN7rGO9D
         ZxPSsI8+nnwbXiAmIxjz8sNB8qLkC0RXkOP1sxll4JwfFH8+d7oK4AbOAD+WCd3Bgg
         mqM71qr1LX2cA==
Date:   Fri, 13 Oct 2023 16:04:25 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] dt-bindings: arm: mediatek: Sort entries by SoC then
 board compatibles
Message-ID: <20231013-manpower-unmoving-c40fc53e05af@spud>
References: <20231012230237.2676469-1-wenst@chromium.org>
 <20231012230237.2676469-2-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Yaoptxthnmnc5rvc"
Content-Disposition: inline
In-Reply-To: <20231012230237.2676469-2-wenst@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Yaoptxthnmnc5rvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 07:02:27AM +0800, Chen-Yu Tsai wrote:
> Some of the new MediaTek board entries were inserted in a chronological
> order, or just randomly. This makes it harder to search for an entry.
>=20
> Sort the entries by first grouping by SoC, then sorting by board
> compatible strings. Also add a comment at the top asking people to do
> the same.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--Yaoptxthnmnc5rvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSlceQAKCRB4tDGHoIJi
0uMkAP9FBpDroU9zuSOnz3MjTjKZpnxV7J+6qg4PS6wmhlUrUgD+Ob9+UuB6eUWL
x6jDnjhbUwiYIxqF0LdzvLoTYl4IRQY=
=7kRj
-----END PGP SIGNATURE-----

--Yaoptxthnmnc5rvc--
